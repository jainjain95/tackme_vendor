import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField({super.key,   this.hintText,
    this.prefixIcon, this. fontSize});
  final String? hintText;
  final dynamic? prefixIcon;
  double? fontSize;
  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      // cursorColor: goldenEFC441Color,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            // borderSide: BorderSide(width: 1,
            //     // color: borderGreyE0E0E0Color
            // ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1,
                // color: borderGreyE0E0E0Color
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          // hintStyle: TextStyle(color: thickGreyBDBDBDColor),
          prefixIcon: widget.prefixIcon
      ),
    );
  }
}
