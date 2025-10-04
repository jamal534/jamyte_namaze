import 'package:flutter/material.dart';

class Slide extends StatelessWidget {
  bool isActive;
  Slide(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: isActive ? 8 : 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
          color: isActive ? Color(0xFF137058) :
          Color(0x66137058),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
