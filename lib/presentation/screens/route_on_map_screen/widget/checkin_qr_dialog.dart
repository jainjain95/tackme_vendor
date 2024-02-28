import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_cubit.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class CheckinAndQrDialog extends StatelessWidget {
  String routeId;
  String stopId;
  String qrImage;
  CheckinAndQrDialog({super.key, required this.routeId, required this.stopId, required this.qrImage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // contentPadding: EdgeInsets.only(top: 66, left: 60, right: 61, bottom: 44),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      content: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 222,
                width: 222,
                child: CachedNetworkImage(
                          imageUrl: qrImage,
                          height: 80,
                          width: 80,
                          placeholder:(context, url) {
                            return Center(child: SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: redCA1F27Color)));
                          },
                        )
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Scan the QR Code to get the stop location on your map",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 16.56,
                        color: greyk898989Color,
                        fontWeight: normal))),
            const SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: () {
                AppRouter.navigatorKey.currentState?.pop();
              },
              child: Container(
                height: 32,
                // width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: lightGreyF6F6F6Color),
                child: Center(
                  child: Text("HIDE",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 10.32,
                              color: redCA1F27Color,
                              fontWeight: bold))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}