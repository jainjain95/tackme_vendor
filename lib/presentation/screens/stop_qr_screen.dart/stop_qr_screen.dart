import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tagmevendor/presentation/screens/stop_qr_screen.dart/widget/pdf_export_bottom_sheet.dart';

import 'package:tagmevendor/presentation/widgets/pdf_screen.dart';

import '../my_qr_screen/my_qr_screen.dart';

class StopQrScreen extends StatefulWidget {
  Data stopData;
  StopQrScreen({super.key, required this.stopData});

  @override
  State<StopQrScreen> createState() => _StopQrScreenState();
}

class _StopQrScreenState extends State<StopQrScreen> {
  FocusNode addressFocus = FocusNode();
  FocusNode lengthFocus = FocusNode();
  FocusNode breathFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          leading: Padding(
            padding: const EdgeInsets.only(left:24),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                    color: greyicon374151Color
                )),
          ),
          title: Text(
            widget.stopData.location!.locationNickName.toString(),
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: black111011Color)),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          // child: dimestionBottomSheet(context, widget.stopData),
                          child: PdfExportBottomSheet(stopData: widget.stopData),
                        );
                      },
                    );
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfScreen()));
                },
                child: SvgPicture.asset("$svgAssetsBasePath/logout.svg")
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Container(
                // height: 48,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: lightGreyF6F6F6Color
                ), 
                child: Text(
                            widget.stopData.location!.text.toString(),
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: normal,
                                    color: mediumGrey9CA3AFColor)),
                          ), 
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Container(
                  decoration: BoxDecoration(
                      color: lightGreyF6F6F6Color,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1/1,
                        child: Padding(
                          padding: const EdgeInsets.only(top:66.0, bottom: 45),
                          child: CachedNetworkImage(
                            imageUrl: widget.stopData.qrCode.toString(),
                            height: 80,
                            width: 80,
                            // progressIndicatorBuilder: (context, url, progress){
                            //   return SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: redCA1F27Color));
                            // },
                            placeholder:(context, url) {
                              return Center(child: SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: redCA1F27Color)));
                            },
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Text(
                          "Scan the QR Code to get the stop location on your map",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 16.50,
                                  fontWeight: normal,
                                  color: greyk898989Color)),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }


  Padding WidgetTextfieldnewstop(String labelText,
      {required FocusNode focusNode}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: TextField(
          focusNode: focusNode,
          // keyboardType: TextInputType.number,
          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorColor: black111011Color,
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: GoogleFonts.openSans(
                textStyle: const TextStyle(
              color: mediumGrey9CA3AFColor,
            )),
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).colorScheme.error
                    : black111011Color;
                return TextStyle(color: color, fontSize: 20);
              },
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: lightGreyF6F6F6Color),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 1, color: lightGreyF6F6F6Color),
            ),
            filled: true,
            fillColor: lightGreyF6F6F6Color,
          ),
        ),
      ),
    );
  }

}
