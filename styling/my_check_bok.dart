import 'package:flutter/material.dart';

class MyCheckBok extends StatefulWidget {
  const MyCheckBok({super.key});

  @override
  State<MyCheckBok> createState() => _MyCheckBokState();
}

class _MyCheckBokState extends State<MyCheckBok> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      activeColor: Theme.of(context).colorScheme.inversePrimary,
      checkColor: Theme.of(context).colorScheme.primary,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
