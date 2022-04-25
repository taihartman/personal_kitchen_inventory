import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kitchen_inventory/DataSaver.dart';
import 'package:kitchen_inventory/models/Item.dart';

class KitchenItem extends StatefulWidget {
  KitchenItem({Key? key, required this.item, required this.itemsList})
      : super(key: key);
  Item item;
  List<Item> itemsList;
  @override
  State<KitchenItem> createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  DataSaver dataSaver = DataSaver();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFEEE8F4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Item name
          Text(
            widget.item.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text("\n" + '${widget.item.quantity}' + ' ${widget.item.unit}',
              textAlign: TextAlign.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //decrease Button
              Material(
                color: Color(0xFFEEE8F4),
                child: TextButton(
                  child: Text('-' + widget.item.changeValue.toString()),
                  onPressed: () {
                    log("Decreasing amount");
                    setState(() {
                      //decreasing the quantity
                      widget.item.quantity -= widget.item.changeValue;
                      //truncating the number for visibilty
                      widget.item.quantity = double.parse(
                          widget.item.quantity.toStringAsPrecision(2));
                      //getting index and replacing the item
                      int indexOfItem = widget.itemsList.indexOf(widget.item);
                      widget.itemsList.isNotEmpty
                          ? widget.itemsList.removeAt(indexOfItem)
                          : null;
                      widget.itemsList.insert(indexOfItem, widget.item);
                      //saving data
                      dataSaver.saveData(widget.itemsList);
                    });
                  },
                ),
              ),
              //Increase Button
              Material(
                color: Color(0xFFEEE8F4),
                child: TextButton(
                  child: Text('+' + widget.item.changeValue.toString()),
                  onPressed: () {
                    log("Increasing amount");
                    setState(() {
                      //increasing the quantity
                      widget.item.quantity += widget.item.changeValue;
                      //truncating the number for visibilty
                      widget.item.quantity = double.parse(
                          widget.item.quantity.toStringAsPrecision(2));
                      //getting index and replacing the item
                      int indexOfItem = widget.itemsList.indexOf(widget.item);
                      widget.itemsList.isNotEmpty
                          ? widget.itemsList.removeAt(indexOfItem)
                          : null;
                      widget.itemsList.insert(indexOfItem, widget.item);
                      //saving data
                      dataSaver.saveData(widget.itemsList);
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
