import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class MessageSnackbar extends StatefulWidget {
  
  String heading;
  String message;
  MessageSnackbar({super.key, required this.heading, required this.message,});

  @override
  State<MessageSnackbar> createState() => _MessageSnackbarState();
}

class _MessageSnackbarState extends State<MessageSnackbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
                                            children: [
                                              Text(
                                                widget.heading,
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: bold,
                                                        color: 
                                                        // widget.fontcolor
                                                        green34A853Color

                                                        )),
                                              ),
                                              Text(
                                                widget.message,
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: semiBold,
                                                        color: 
                                                        // widget.fontColor
                                                        green34A853Color
                                                        )),
                                              ),
                                            ],
                                          );
  }
}