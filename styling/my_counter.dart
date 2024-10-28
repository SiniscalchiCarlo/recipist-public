import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class MyCounter extends StatefulWidget {
  final Function onPressed;
  final double? size;
  final int startValue;
  const MyCounter(
      {super.key,
      required this.onPressed,
      required this.startValue,
      this.size});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  late int numberPersons;
  @override
  void initState() {
    super.initState();
    numberPersons = widget.startValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: IconButton(
              onPressed: () {
                numberPersons -= 1;
                widget.onPressed(numberPersons);
              },
              icon: Icon(Icons.remove,
                  size: widget.size != null ? (widget.size! - 5) : 10)),
        ),
        MyText(
          text: "$numberPersons",
          size: (widget.size) ?? 18,
        ),
        SizedBox(
          height: 35,
          width: 35,
          child: IconButton(
              onPressed: () {
                numberPersons += 1;
                widget.onPressed(numberPersons);
              },
              icon: Icon(Icons.add,
                  size: widget.size != null ? (widget.size!) : 15)),
        ),
      ],
    );
  }
}
