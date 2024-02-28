import 'package:cached_network_image/cached_network_image.dart';
// import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'dart:io' as io;
import 'package:pdf/widgets.dart' as pw;
class MyQrScreen extends StatefulWidget {
  List<String> data;
  MyQrScreen({super.key, required this.data});

  @override
  State<MyQrScreen> createState() => _MyQrScreenState();
}

class _MyQrScreenState extends State<MyQrScreen> {
  FocusNode mobFocus = FocusNode();
  FocusNode lengthFocus = FocusNode();
  FocusNode breathFocus = FocusNode();
  final pdf = pw.Document();
  String selectedSize="A4";

  Future<pw.Document> generatePdf() async {

    final netImage = await networkImage(widget.data.first);

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
                      widget.data[1],
                      textAlign: pw.TextAlign.center,
                      style:  pw.TextStyle(
                          fontSize: 27,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black),
                    ),
                  ),
                  pw.SizedBox(height: 30),
                ],
              )); // Center
        })); // Page
    return pdf;
  } 

  // Future<io.File> saveDocument() async {
  //   String name =
  //       "QR_${DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now())}.pdf";
  //   final dir = io.Platform.isAndroid
  //       ? io.File('/storage/emulated/0/Download')
  //       : 
  //       // await getDownloadsDirectory();
  //       await getApplicationDocumentsDirectory();
  //       await FileSaver.instance.saveFile(
  //         name: 'cghfhg'

  //       );
        
  //   final file = io.File('${dir.path}/$name');
  //   await file.writeAsBytes(await pdf.save());

  //   await FileSaver.instance.saveFile(
  //     name: 'cghfhg',
  //     file: await file.writeAsBytes(await pdf.save())
  //   );
    
    
  //   await Share.shareXFiles([XFile('${dir.path}/$name')], text: 'Great picture');
  //   return file;
  
  
  // }

  Future saveDocument() async {
    String name =
        "QR_${DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now())}.pdf";
    final dir = io.Platform.isAndroid
        ? io.File('/storage/emulated/0/Download')
        : 
        // await getDownloadsDirectory();
        await getApplicationDocumentsDirectory();

        final file = io.File('${dir.path}/$name');
        await file.writeAsBytes(await pdf.save());

        



    // if(io.Platform.isAndroid){
    //   final dir = io.File('/storage/emulated/0/Download');
    //   final file = io.File('${dir.path}/$name');
    //   await file.writeAsBytes(await pdf.save());
    //   // return file;
    //   await Share.shareXFiles([XFile('${dir.path}/$name')], text: 'Great picture');

    // } else {
      // final Uint8List pdfBytes = await pdf.save();
      // await FileSaver.instance.saveFile(
      // name: name,
      // bytes: pdfBytes,
      // ext: ".pdf",
      // mimeType: MimeType.pdf
      // );
      // return file;

    // }

    


    
        
    // final file = io.File('${dir.path}/$name');
    // await file.writeAsBytes(await pdf.save());

    // await FileSaver.instance.saveFile(
    //   name: 'cghfhg',
    //   file: await file.writeAsBytes(await pdf.save())
    // );
    
    
    await Share.shareXFiles([XFile('${dir.path}/$name')]);
    return file;
  
  
  }


  // share() async {
  //   final Uint8List pdfBytes = await pdf.save();
  //   await Share.shareXFiles([XFile('${dir.path}/$name')], text: 'Great picture');
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
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
            "My QR Code",
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
                        return dimestionBottomSheet(context);
                      },
                    );
                  },
                  child: SvgPicture.asset("$svgAssetsBasePath/logout.svg")),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                  decoration: BoxDecoration(
                      color: lightGreyF6F6F6Color,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 66.0, bottom: 45),
                          child: CachedNetworkImage(
                            imageUrl: widget.data.first,
                            height: 80,
                            width: 80,
                            placeholder:(context, url) {
                              return Center(child: SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: redCA1F27Color)));
                            },
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Text(
                          // "Mattie Hardwick",
                          widget.data[1],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 17.56,
                                  fontWeight: semiBold,
                                  color: darkBlack000000Color)),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  Widget dimestionBottomSheet(BuildContext context) {
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
                //           WidgetTextfieldnewstop("2", focusNode: lengthFocus),
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
                //           WidgetTextfieldnewstop("2",
                //               focusNode: breathFocus),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
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
                          // Navigator.pop(context);
                          generatePdf().then((value) => saveDocument().then((value) {
                            Navigator.pop(context);
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(SnackBar(
                            //     content: Text(
                            //         "Pdf is saved successfully.")));
                          }));
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

  Widget WidgetTextfieldnewstop(String labelText,
      {required FocusNode focusNode}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextField(
        focusNode: focusNode,
        // keyboardType: TextInputType.number,
        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursorColor: black111011Color,
        textAlign: TextAlign.center,
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
          contentPadding: const EdgeInsets.fromLTRB(13, 14, 13, 14),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: lightGreyF6F6F6Color),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: lightGreyF6F6F6Color),
          ),
          filled: true,
          fillColor: lightGreyF6F6F6Color,
          // hintText: hintText,
          // hintStyle: GoogleFonts.openSans(
          //     textStyle: const TextStyle(
          //         color: mediumGrey9CA3AFColor, fontSize: 15)),
        ),
      ),
    );
  }


}
_dropDownItems(List<String> list) {
  return list
      .map((String val) => DropdownMenuItem<String>(
    value: val,
    child: Text(val),
  ))
      .toList();
}

Widget customDropDown(
    BuildContext context,
    {
      required List<String> items,
      required String hintText,
      //required String assetName,
      Function? onChanged,
      String? value,

    }) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 13),
    decoration: BoxDecoration(
      color: lightGreyF6F6F6Color,
      borderRadius: BorderRadius.circular(7.0),
      // border: Border.all(color: grayE5E5E7Color, width: 1.5)
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          prefix:  const SizedBox(width: 5),
          prefixIconConstraints: const BoxConstraints(),
          // prefixIcon: SvgPicture.asset(assetName,
          //   height: 20,width: 20,
          //   //  fit: BoxFit.fill,
          // )

        ),
        hint: Text(hintText),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        items: _dropDownItems(items),
        onChanged: onChanged as void Function(Object?)?,
        isExpanded: true,
        value: value,

      ),
    ),
  );
}