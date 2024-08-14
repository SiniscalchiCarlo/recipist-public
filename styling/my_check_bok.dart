import 'package:flutter/material.dart';

class MyCheckBok extends StatefulWidget {
  final Function? onChanged;
  final bool? initialValue;
  const MyCheckBok({super.key, this.onChanged, this.initialValue});

  @override
  State<MyCheckBok> createState() => _MyCheckBokState();
}

class _MyCheckBokState extends State<MyCheckBok> {
  late bool? isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue ?? false;
  }

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
        if (widget.onChanged != null) {
          widget.onChanged!(); // Use ! to call the non-null function
        }
      },
    );
  }
}
