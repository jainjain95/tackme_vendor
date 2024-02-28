import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class AlertMessageDialog extends StatefulWidget {
  String error;
  AlertMessageDialog({super.key, required this.error});

  @override
  State<AlertMessageDialog> createState() => _AlertMessageDialogState();
}

class _AlertMessageDialogState extends State<AlertMessageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              
              children: [
                // SvgPicture.asset(
                //   "$svgAssetsBasePath"
                //   "/Vector_route.svg",
                //   height: 50,
                //   width: 50,
                // ),
                // Icon(Icons.logout, color: redCA1F27Color, size: 41,),
                // const SizedBox(height: 12.17),
                Text(
                  "Alert",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 16.36,
                          fontWeight: bold,
                          color: redCA1F27Color)),
                ),
                const SizedBox(height: 10.26),
                Text(
                  widget.error,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 12.72,
                          fontWeight: normal,
                          color: darkBlack000000Color)),
                ),
                const SizedBox(height: 26.62),
                InkWell(
                  onTap: () {
                    
                    Navigator.pop(context);
                  },
                  child: Container(
                      // height: 48,
                      width: 72,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(9.09)),
                          color: redCA1F27Color),
                      child: Center(
                        child: Text(
                          // state.startRouteData.route!.startingLocation!.startAddress.toString(),
                          "OK",
                          maxLines: 1,

                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: whiteFFFFFFColor,
                                  fontWeight: semiBold,
                                  fontSize: 12.72)),
                        ),
                      )),
                )
                // InkWell(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: Container(
                //       // height: 48,
                //       width: 72,
                //       padding: EdgeInsets.symmetric(vertical: 8),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(10)),
                //           color: redCA1F27Color),
                //       child: Center(
                //         child: Text(
                //           // state.startRouteData.route!.startingLocation!.startAddress.toString(),
                //           "OK",
                //           maxLines: 1,

                //           style: GoogleFonts.inter(
                //               textStyle: const TextStyle(
                //                   color: whiteFFFFFFColor,
                //                   fontWeight: semiBold,
                //                   fontSize: 12.72)),
                //         ),
                //       )),
                // )
              ],
            )));
  }
}