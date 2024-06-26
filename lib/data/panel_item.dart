import 'package:flutter/material.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class OuterItem {
  String headerValue;
  List<ExpansionPanel> innerItems;
  bool isExpanded = false;

  OuterItem({required this.headerValue, required this.innerItems});
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Inner Panel ${index + 1}',
      expandedValue: 'This is item number ${index + 1}',
    );
  });
}
