import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

customErrorSnackBar(BuildContext context,String message){
  final maxMessageLength = 60; // Define your maximum message length here

  if (message.length > maxMessageLength) {
    message = message.substring(0, maxMessageLength) + '...';
  }
  return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: lightRedFFE3E4Color,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Error",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: bold,
                                      color: redCA1F27Color)),
                            ),
                            Text(
                              message,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                      color: redCA1F27Color)),
                            ),
                          ],
                        ),
                      );
}

customSuccessSnackBar(BuildContext context,String message){
  final maxMessageLength = 60; // Define your maximum message length here

  if (message.length > maxMessageLength) {
    message = message.substring(0, maxMessageLength) + '...';
  }
  return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: greenLightDFFEE7Color,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Success",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: bold,
                                      color: green34A853Color)),
                            ),
                            Text(
                              message,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                      color: green34A853Color)),
                            ),
                          ],
                        ),
                      );
}
 