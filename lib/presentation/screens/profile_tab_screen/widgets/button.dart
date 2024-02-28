import 'package:flutter/material.dart';

class AButton extends StatelessWidget {
  String? name;
  Color? color;
  Color? textcolor;
  Function()? onTap;
  AButton({super.key, this.name, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color
      ),

    );
  }
}