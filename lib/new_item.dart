import 'package:flutter/material.dart';
import 'package:listcart/data/categories.dart';
import 'package:listcart/models/category.dart';
import 'package:listcart/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final nameKey = GlobalKey<FormState>();
  var enteredVal = '';
  var enteredQunt = 1;
  var enteredCateg = categories[Categories.vegetables]!;

  void process() {
    if (nameKey.currentState!.validate()) {
      nameKey.currentState!.save();
      Navigator.of(context).pop(GroceryItem(
          id: DateTime.now().toString(),
          name: enteredVal,
          quantity: enteredQunt,
          category: enteredCateg));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a newItem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: nameKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length > 50 ||
                      value.trim().length <= 0) {
                    return 'The Name should be between 1 to 50 letters...REtry';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredVal = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      // key: nameKey,
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: enteredQunt.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value)! <= 0 ||
                            int.tryParse(value) == null) {
                          return 'Must be a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredQunt = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: enteredCateg,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          enteredCateg = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      nameKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: process,
                    child: const Text('Submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
