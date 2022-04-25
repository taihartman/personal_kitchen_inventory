import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kitchen_inventory/models/Item.dart';

class KitchenItem extends StatefulWidget {
  KitchenItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  Item item;
  @override
  State<KitchenItem> createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFEEE8F4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Material(
              color: Color(0xFFEEE8F4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              clipBehavior: Clip.antiAlias,
              child: TextButton(
                child: Text('-' + widget.item.changeValue.toString()),
                onPressed: () {
                  log("Decreasing amount");
                  setState(() {
                    widget.item.quantity -= widget.item.changeValue;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item.name,
                  textAlign: TextAlign.center,
                ),
                Text('${widget.item.quantity.toStringAsPrecision(2)}',
                    textAlign: TextAlign.center),
                Text('${widget.item.unit}', textAlign: TextAlign.center),
              ],
            ),
          ),
          Flexible(
            child: Material(
              color: Color(0xFFEEE8F4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              clipBehavior: Clip.antiAlias,
              child: TextButton(
                child: Text('+' + widget.item.changeValue.toString()),
                onPressed: () {
                  log("Increasing amount");
                  setState(() {
                    widget.item.quantity += widget.item.changeValue;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
