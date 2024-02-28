import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("$svgAssetsBasePath/undraw_schedule_empty.svg"),
              const SizedBox(height: 40),
              Text(
                "Schedule encompass a food truck's travel day and time.",
                textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: bold,
                                      color: darkBlack000000Color)),
              ),
              const SizedBox(height: 40),
              Text(
                "To add a schedule click on the ‘Add New’ button below.",
                textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: normal,
                                      color: mediumGrey9CA3AFColor)),
              ),
            ],
          ),
        );
  }
}