import 'dart:convert';

import 'package:kitchen_inventory/models/Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSaver {
  void saveData(List<Item> itemsList) async {
    List<String> jsonList = [];
    final prefs = await SharedPreferences.getInstance();
    itemsList.forEach((element) {
      String jsonItem = jsonEncode(element);
      jsonList.add(jsonItem);
    });
    prefs.setString("items", jsonList.toString());
  }
}
