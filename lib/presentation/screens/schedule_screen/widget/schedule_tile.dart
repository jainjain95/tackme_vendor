import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';

class ScheduleTile extends StatelessWidget {
  Datum? schedulData;
  int? index; 
  bool location;
  ScheduleTile({super.key, this.schedulData,  required this.location, this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Schedule $index",
                      schedulData!.scheduleName.toString(),
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: normal,
                              color: darkBlack000000Color)),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        schedulData!.days.toString(),
                        // day.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: normal,
                                color: grey374151Color)),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  location ? "ON" : "OFF",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 16.20,
                          fontWeight: bold,
                          color: location ? green4CAF50Color : redCA1F27Color
                  )),
                ),
              ],
            ),
            const SizedBox(height: 13),
            // const Divider(
            //   thickness: 1,
            //   height: 0,
            //   color: lightBlackC9C9C9Color,
            // )
          ],
        ));
  }
}
