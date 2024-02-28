import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/presentation/widgets/bottomsheet_widget.dart';

import '../../core/constants/font_weight.dart';

class CustomMainButton extends StatelessWidget {
  Function() onTap;
  String label;
  Color color;
  CustomMainButton({super.key, required this. onTap, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            onPressed: onTap,
            child: Text(
              label,
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: bold)),
            )));
  }
}