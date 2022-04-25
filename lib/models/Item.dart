import 'dart:core';

class Item {
  Item(
      {required this.id,
      required this.name,
      required this.note,
      required this.quantity,
      required this.unit,
      required this.changeValue});
  int id;
  String name;
  String note;
  double quantity;
  String unit;
  double changeValue;

  Map toJson() => {
        'id': id,
        'name': name,
        'note': note,
        'quantity': quantity,
        'unit': unit,
        'changeValue': changeValue,
      };

  factory Item.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    final note = data['note'] as String;
    final quantity = data['quantity'] as double;
    final unit = data['unit'] as String;
    final changeValue = data['changeValue'] as double;
    return Item(
        id: id,
        name: name,
        note: note,
        quantity: quantity,
        unit: unit,
        changeValue: changeValue);
  }
}
