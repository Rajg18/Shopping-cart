import 'package:flutter/material.dart';
import 'package:listcart/models/grocery_item.dart';
import 'package:listcart/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];

  void addItem() async {
    final newVal = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    if (newVal == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newVal);
    });
  }

  void removable(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget initial = const Center(
      child: Text('NO data inside'),
    );

    if (_groceryItem.isNotEmpty) {
      initial = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) {
            removable(_groceryItem[index]);
          },
          key: ValueKey(_groceryItem[index].id),
          child: ListTile(
            title: Text(_groceryItem[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItem[index].category.color,
            ),
            trailing: Text(_groceryItem[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Grocery Items'),
          actions: [
            IconButton(onPressed: addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: initial);
  }
}
