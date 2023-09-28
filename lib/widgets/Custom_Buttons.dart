import 'package:flutter/material.dart';

Widget rowSingleButton(
    {required String name,
    required String iconImage,
    required Color color,
    bool isHover = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    decoration: BoxDecoration(
        color: isHover ? Colors.black.withOpacity(0.1) : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(4))),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          child: Image.asset(
            iconImage,
            color: color,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
