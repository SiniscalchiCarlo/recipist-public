import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class MyCounter extends StatefulWidget {
  final Function onPressed;
  final double? size;
  final int startValue;
  final Widget? child;
  const MyCounter(
      {super.key,
      required this.onPressed,
      required this.startValue,
      this.child,
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
        MyText(
          text: "$numberPersons",
          size: (widget.size) ?? 18,
        ),
        widget.child ?? SizedBox.shrink(),
        Column(
          children: [
            IconButton(
                onPressed: () {
                  numberPersons += 1;
                  widget.onPressed(numberPersons);
                },
                icon: Icon(Icons.keyboard_arrow_up,
                    size: widget.size != null ? (widget.size! + 10) : 30)),
            IconButton(
                onPressed: () {
                  numberPersons -= 1;
                  widget.onPressed(numberPersons);
                },
                icon: Icon(Icons.keyboard_arrow_down,
                    size: widget.size != null ? (widget.size! + 10) : 30))
          ],
        )
      ],
    );
  }
}
