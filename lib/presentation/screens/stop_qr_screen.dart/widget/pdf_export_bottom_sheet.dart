
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'dart:io' as io;
import 'package:pdf/widgets.dart' as pw;

import '../../../widgets/message_snackbar.dart';
import '../../my_qr_screen/my_qr_screen.dart';
 
class PdfExportBottomSheet extends StatefulWidget {
  Data stopData;
  PdfExportBottomSheet({super.key, required this.stopData});

  @override
  State<PdfExportBottomSheet> createState() => _PdfExportBottomSheetState();
}

class _PdfExportBottomSheetState extends State<PdfExportBottomSheet> {


  final pdf = pw.Document();
  String selectedSize="A4";


  Future<pw.Document> generatePdf() async {

    final netImage = await networkImage(widget.stopData.qrCode.toString());

    pdf.addPage(pw.Page(
        pageFormat:
        selectedSize=="A3"?PdfPageFormat.a3:
        selectedSize=="A4"?PdfPageFormat.a4:
        selectedSize=="A5"?PdfPageFormat.a5:
        selectedSize=="A6"?PdfPageFormat.a6:PdfPageFormat.standard,
        build: (pw.Context context) {
          return pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFFF6F6F6),
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(10))),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "$pngAssetsBasePath/Component 7.png",
                  //   height: 80,
                  //   width: 80,
                  // ),
                  pw.SizedBox(height: 30),
                  pw.Center(child: pw.AspectRatio(
                      aspectRatio: 1/1,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(70),
                        child:pw.Image(
                          netImage,
                          // imageUrl: "https://tagme-s3-bucket.s3.ap-southeast-2.amazonaws.com/654a3530c74d89c2364689b3.png",
                          // height: 150,
                          // width: 150,
                          // progressIndicatorBuilder: (context, url, progress){
                          //   return SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: redCA1F27Color));
                          // },
                        ),)
                  ),),
                  pw.Spacer(),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: pw.Text(
                      "Scan the QR Code to get the stop location on your map",
                      textAlign: pw.TextAlign.center,
                      style:  pw.TextStyle(
                          fontSize: 23,
                          color: PdfColor.fromInt(0xFF898888)),
                    ),
                  ),
                  pw.SizedBox(height: 30),
                ],
              )); // Center
        })); // Page
    return pdf;
  }

  Future<io.File> saveDocument() async {
    String name =
        "QR_${DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now())}.pdf";
    final dir = io.Platform.isAndroid
        ? io.File('/storage/emulated/0/Download')
        : 
        // await getDownloadsDirectory();
        await getApplicationDocumentsDirectory();
    final file = io.File('${dir?.path}/$name');
    await file.writeAsBytes(await pdf.save());
    await Share.shareXFiles([XFile('${dir.path}/$name')], text: 'Great picture');
    return file;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          // You can customize the content of the bottom sheet here
          // height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Size",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: bold,
                              color: darkBlack000000Color)),
                    ),
                    InkWell(
                        onTap: () {
                          AppRouter.navigatorKey.currentState?.pop();
                        },
                        child: SvgPicture.asset(
                            "$svgAssetsBasePath/cancel_icon.svg"))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                customDropDown(
                    context,hintText: "select size",
                    items: ["Standard","A3","A4","A5","A6"],
                    value: selectedSize,
                    onChanged: (val){
                      setState(() {
                        selectedSize=val;
                      });
                    }
                ),
                // Row(
                //   children: [
                //     Flexible(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Length (cm)",
                //             textAlign: TextAlign.justify,
                //             style: GoogleFonts.openSans(
                //                 textStyle: const TextStyle(
                //                     fontSize: 12,
                //                     fontWeight: normal,
                //                     color: mediumGrey9CA3AFColor)),
                //           ),
                //           const SizedBox(height: 4),
                //           WidgetTextfieldnewstop("2"),
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 13,
                //     ),
                //     Flexible(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Length (cm)",
                //             textAlign: TextAlign.justify,
                //             style: GoogleFonts.openSans(
                //                 textStyle: const TextStyle(
                //                     fontSize: 12,
                //                     fontWeight: normal,
                //                     color: mediumGrey9CA3AFColor)),
                //           ),
                //           const SizedBox(height: 4),
                //           WidgetTextfieldnewstop("2"),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 24),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: redCA1F27Color,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () {
                          //Navigator.pop(context);
                          generatePdf().then((value) => saveDocument().then((value) {
                            Navigator.pop(context);
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(SnackBar(
                            //     content: Text(
                            //         "Pdf is saved successfully.")));
                          }));
                          // MessageSnackbar(heading: "Success!",message: "Pdf is saved successfully.",);


                        },
                        child: Text(
                          "SHARE",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: bold)),
                        ))),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ));
  }

  Padding WidgetTextfieldnewstop(String labelText,
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: TextField(
  
          // keyboardType: TextInputType.number,
          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorColor: black111011Color,
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: GoogleFonts.openSans(
                textStyle: const TextStyle(
              color: mediumGrey9CA3AFColor,
            )),
            // labelText: labelText,
            // labelStyle: GoogleFonts.openSans(textStyle: const TextStyle(color: mediumGrey9CA3AFColor, )),
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
            // hintText: hintText,
            // hintStyle: GoogleFonts.openSans(
            //     textStyle: const TextStyle(
            //         color: mediumGrey9CA3AFColor, fontSize: 15)),
          ),
        ),
      ),
    );
  }
}