import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen_inventory/DataSaver.dart';
import 'package:kitchen_inventory/main.dart';

import 'models/Item.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage({Key? key, required this.itemsList}) : super(key: key);
  List<Item> itemsList;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final nameController = TextEditingController();
  final noteController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final changeValueController = TextEditingController();
  bool _validateName = true;
  bool _validateQuantity = true;
  DataSaver dataSaver = DataSaver();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    noteController.dispose();
    unitController.dispose();
    quantityController.dispose();
    changeValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Add Item'),
        titleTextStyle: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Color(0xFF587291),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xFFEEE8F4),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                TextFormField(
                  controller: nameController,
                  onChanged: (text) {
                    setState(() {
                      if (text.isEmpty) {
                        _validateName = true;
                      } else {
                        _validateName = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    errorText: _validateName ? 'Please Enter a name' : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: _validateName
                        ? const Icon(
                            Icons.error,
                          )
                        : null,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: quantityController,
                  onChanged: (text) {
                    setState(() {
                      if (text.isEmpty) {
                        _validateQuantity = true;
                      } else {
                        _validateQuantity = false;
                      }
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r".")),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    errorText:
                        _validateQuantity ? 'Please Enter a Quantity' : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: _validateQuantity
                        ? const Icon(
                            Icons.error,
                          )
                        : null,
                  ),
                ),
                TextFormField(
                  controller: unitController,
                  decoration: const InputDecoration(
                    labelText: 'Unit',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: changeValueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r"."))
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Change Value',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: noteController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2F97C1),
                    elevation: 3,
                    minimumSize: const Size(120, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Back',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF1CCAD8),
                    elevation: 3,
                    minimumSize: const Size(120, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        quantityController.text.isNotEmpty) {
                      print(widget.itemsList.length);
                      Item newItem = Item(
                          id: widget.itemsList.length,
                          name: nameController.text,
                          note: noteController.text.isNotEmpty
                              ? noteController.text
                              : "",
                          quantity: double.parse(
                              double.parse(quantityController.text)
                                  .toStringAsFixed(2)),
                          changeValue: changeValueController.text.isNotEmpty
                              ? double.parse(changeValueController.text)
                              : 1.0,
                          unit: unitController.text.isNotEmpty
                              ? unitController.text
                              : "");
                      widget.itemsList.add(newItem);
                      dataSaver.saveData(widget.itemsList);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Done',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
