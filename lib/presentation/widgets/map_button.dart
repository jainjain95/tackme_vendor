import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class MapButton extends StatelessWidget {
  String? name;
  Widget iconWidget;
  Function()? onTap;
  MapButton({super.key, this.name, required this.iconWidget, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                          onTap: onTap,
                          child: Container(
                            width: 150,
                            // padding:
                            // EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            constraints: BoxConstraints.tight(Size(75, 50)),
                            decoration: const BoxDecoration(
                                color: redCA1F27Color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.values,
                                children: [
                                  // const Icon(
                                  //   Icons.check,
                                  //   color: whiteFFFFFFColor,
                                  //   size: 20,
                                  // ),
                                  iconWidget,
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    name!,
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: whiteFFFFFFColor,
                                            fontWeight: bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
  }
}