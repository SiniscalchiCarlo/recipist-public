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
    return Container(
      margin: EdgeInsets.only(left: 4, right: 8),
      height: 20,
      width: 20,
      child: Checkbox(
        value: isChecked,
        activeColor: Colors.grey.shade700,
        checkColor: Colors.grey.shade200,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value); // Pass the new value to the parent
          }
        },
      ),
    );
  }
}
