import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen_inventory/DataSaver.dart';
import 'package:kitchen_inventory/main.dart';

import 'models/Item.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(
      {Key? key,
      required this.item,
      required this.itemsList,
      required this.funCallback})
      : super(key: key);
  Item item;
  List<Item> itemsList;
  final Function() funCallback;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final nameController = TextEditingController();
  final noteController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final changeValueController = TextEditingController();
  bool _validateName = false;
  bool _validateQuantity = false;
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
  void initState() {
    nameController.text = widget.item.name;
    noteController.text = widget.item.note;
    quantityController.text = widget.item.quantity.toString();
    unitController.text = widget.item.unit;
    changeValueController.text = widget.item.changeValue.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.item.name),
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
                    FilteringTextInputFormatter.allow(
                      RegExp(r'(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)'),
                    ),
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
                    FilteringTextInputFormatter.allow(
                      RegExp(r'(^\d*\.?\d*[0-9]+\d*$)|(^[0-9]+\d*\.\d*$)'),
                    )
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
                      //getting index of item before changing vals
                      int indexOfItem = widget.itemsList.indexOf(widget.item);
                      widget.item.name = nameController.text;
                      widget.item.quantity = double.parse(
                          double.parse(quantityController.text)
                              .toStringAsFixed(2));
                      widget.item.unit = unitController.text.isNotEmpty
                          ? unitController.text
                          : "";
                      widget.item.changeValue =
                          changeValueController.text.isNotEmpty
                              ? double.parse(changeValueController.text)
                              : 1.0;
                      widget.item.note = noteController.text.isNotEmpty
                          ? noteController.text
                          : "";

                      widget.itemsList.isNotEmpty
                          ? widget.itemsList.removeAt(indexOfItem)
                          : null;
                      widget.itemsList.insert(indexOfItem, widget.item);
                      //saving data
                      dataSaver.saveData(widget.itemsList);
                      widget.funCallback();
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
