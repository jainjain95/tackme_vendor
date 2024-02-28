import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class UploadImageBottomSheet extends StatefulWidget {
  const UploadImageBottomSheet({super.key});

  @override
  State<UploadImageBottomSheet> createState() => _UploadImageBottomSheetState();
}

class _UploadImageBottomSheetState extends State<UploadImageBottomSheet> {

  
  Future<File?> getImage(ImageSource type)async {
    final image = await ImagePicker().pickImage(source: type);
    if(image == null){
      return null;
    } else {
      final tempImage = File(image.path);
        return tempImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: whiteFFFFFFColor),
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
              SizedBox(),
              Text(
                "Edit Profile Picture",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: semiBold,
                        color: darkBlack000000Color)),
              ),
              InkWell(
                  onTap: () {
                    AppRouter.navigatorKey.currentState?.pop();
                  },
                  child: SvgPicture.asset("$svgAssetsBasePath/cancel_icon.svg"))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: lightGreyF6F6F6Color),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      AppRouter.navigatorKey.currentState?.pop(getImage(ImageSource.camera));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Take Photo",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                  color: grey374151Color)),
                        ),
                        SvgPicture.asset("$svgAssetsBasePath/camera.svg")
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: lightBlackC9C9C9Color,
                    height: 24,
                  ),
                  InkWell(
                    onTap: (){
                      AppRouter.navigatorKey.currentState?.pop(getImage(ImageSource.gallery));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Photo",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                  color: grey374151Color)),
                        ),
                        SvgPicture.asset("$svgAssetsBasePath/gallery.svg")
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}