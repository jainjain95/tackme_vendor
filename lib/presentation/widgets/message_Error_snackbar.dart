import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class MessageErrorSnackbar extends StatefulWidget {
  
  String heading;
  String message;
  MessageErrorSnackbar({super.key, required this.heading, required this.message,});

  @override
  State<MessageErrorSnackbar> createState() => _MessageErrorSnackbarState();
}

class _MessageErrorSnackbarState extends State<MessageErrorSnackbar> {
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
                                                        redCA1F27Color

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
                                                        redCA1F27Color
                                                        )),
                                              ),
                                            ],
                                          );
  }
}