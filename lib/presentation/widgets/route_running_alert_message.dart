import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class RouteRunningAlertMessage extends StatefulWidget {
  const RouteRunningAlertMessage({super.key});

  @override
  State<RouteRunningAlertMessage> createState() =>
      _RouteRunningAlertMessageState();
}

class _RouteRunningAlertMessageState extends State<RouteRunningAlertMessage> {
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
                SvgPicture.asset(
                  "$svgAssetsBasePath"
                  "/Vector_route.svg",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(height: 12),
                Text(
                  "Route is in progress...",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 16.36,
                          fontWeight: bold,
                          color: redCA1F27Color)),
                ),
                const SizedBox(height: 7),
                Text(
                  "End current route to proceed",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 12.72,
                          fontWeight: normal,
                          color: redCA1F27Color)),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      // height: 48,
                      width: 72,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
              ],
            )));
  }
}
