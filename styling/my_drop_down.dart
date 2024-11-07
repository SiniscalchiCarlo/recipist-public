import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class MyDropDown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final Function(String) onChanged;

  MyDropDown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.grey.shade100,
      value: selectedValue,
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: MyText(text: value),
        );
      }).toList(),
    );
  }
}
