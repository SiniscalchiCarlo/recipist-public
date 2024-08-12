import 'package:flutter/material.dart';
import 'package:smart_shopping_list/styling/my_text.dart';

class Personscounter extends StatefulWidget {
  final Function onPressed;
  final int startValue;
  const Personscounter(
      {super.key, required this.onPressed, required this.startValue});

  @override
  State<Personscounter> createState() => _PersonscounterState();
}

class _PersonscounterState extends State<Personscounter> {
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
          size: 30,
        ),
        Icon(Icons.person, size: 40),
        Column(
          children: [
            IconButton(
                onPressed: () {
                  numberPersons += 1;
                  widget.onPressed(numberPersons);
                },
                icon: Icon(Icons.keyboard_arrow_up, size: 40)),
            IconButton(
                onPressed: () {
                  numberPersons -= 1;
                  widget.onPressed(numberPersons);
                },
                icon: Icon(Icons.keyboard_arrow_down, size: 40))
          ],
        )
      ],
    );
  }
}
