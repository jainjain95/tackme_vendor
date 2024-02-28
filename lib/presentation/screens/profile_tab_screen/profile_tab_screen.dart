import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_cubit.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/profile_tab_screen/widgets/logoutDialog.dart';
import 'package:tagmevendor/presentation/screens/signup_company_info/widget/upload_image_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/message_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  // bool notificationCheck = true;
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileTabCubit>(context).getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer< InternetCubit, bool>(
              listener: (context, state) {
        if(state == true){
          // BlocProvider.of<ApprovedCubit>(context).getApprovedRequest();
        }
      }, 
              builder: (context, state){
      if(state == false){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "$svgAssetsBasePath/robot_connection_error.svg"
              ),
              const SizedBox(height: 10,),
              Text(
                              "Connection failed, Please check your\nnetwork settings",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: black111011Color, fontWeight: semiBold))
                ),
            ],
          )
        );
      }
              return BlocConsumer<ProfileTabCubit, ProfileTabState>(
                listener: (context, state) {
                  if (state is ProfileTabResponseState) {}
                },
                builder: (context, state) {
                  if (state is ProfileTabResponseState) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 7),
                            Stack(
                              children: [
                                CircleAvatar(
                                    radius: 50,
                                    backgroundColor: lightGreyF6F6F6Color,
                                    child: Container(
                                      height: 85,
                                      width: 85,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.white,
                                        // image: state.response.data!
                                        //             .profileImage ==
                                        //         ""
                                        //     ? _image != null
                                        //         ? DecorationImage(
                                        //             image: FileImage(_image!),
                                        //             fit: BoxFit.fill)
                                        //         : DecorationImage(
                                        // image: AssetImage(
                                        //     "$pngAssetsBasePath/Oval.png"),
                                        //             fit: BoxFit.fill)
                                        //     : DecorationImage(
                                        //         image: NetworkImage(state
                                        //             .response.data!.profileImage
                                        //             .toString()),
                                        // image: DecorationImage(
                                        // image: CachedNetworkImage(
                                        //                           imageUrl: state.response.data!.profileImage.toString(),
                                        //                           height: 80,
                                        //                           width: 80,
                                        //                           progressIndicatorBuilder: (context, url, progress){
                                        //                             return CircularProgressIndicator(color: redCA1F27Color);
                                        //                           },
                                        //                         ),
                                        // ),
                                        // fit: BoxFit.fill)
                                      ),
                                      // child: Center(child: SizedBox( height: 20, width:20,child: CircularProgressIndicator(color: redCA1F27Color))),
                                      child:
                                          state.response.data!.profileImage == ""
                                              ? _image != null
                                                  ? ClipOval(
                                                      child: Image.file(
                                                      _image!,
                                                      fit: BoxFit.fill,
                                                    ))
                                                  : Center(
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 40,
                                                      ),
                                                    )
                                              : ClipOval(
                                                  child: CachedNetworkImage(
                                                    imageUrl: state.response.data!
                                                        .profileImage
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                    progressIndicatorBuilder:
                                                        (context, url, progress) {
                                                      return Center(
                                                        child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                              color:
                                                                  redCA1F27Color),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                    )),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        var image = await showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: UploadImageBottomSheet(),
                                            );
                                          },
                                        );
                                        _image = image;
                                        setState(() {
                                          _image = image;
                                        });
            
                                        print(
                                            "MMMMMMMMMMMMMMMMMMDDDDDDDDDDDDDDDDD");
                                        AuthRepository.uploadProfileImage(
                                                _image!.path.toString())
                                            .then((value) {
                                          print(
                                              "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx");
                                          BlocProvider.of<ProfileTabCubit>(
                                                  context)
                                              .getProfileInfo();
            
                                          showTopSnackBar(
                                              Overlay.of(context),
                                              customSuccessSnackBar(context,
                                                  "Profile Imgae Updated"));
                                        });
                                      },
                                      child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: lightGreyF6F6F6Color,
                                          child: Center(
                                              child: SvgPicture.asset(
                                            "$svgAssetsBasePath/camera.svg",
                                            height: 20,
                                            width: 20,
                                          ))),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(state.response.data!.name.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: normalblack0D1F3CColor,
                                        fontWeight: semiBold))),
                            const SizedBox(
                              height: 33,
                            ),
                            GestureDetector(
                                onTap: () {
                                  AppRouter.navigatorKey.currentState
                                      ?.pushNamed(AppRouter.personalInfoScreen);
                                },
                                child: infoTile("Personal information")),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                                onTap: () {
                                  AppRouter.navigatorKey.currentState
                                      ?.pushNamed(AppRouter.companyInfoScreen);
                                },
                                child: infoTile("Company’s information")),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                                onTap: () {
                                  AppRouter.navigatorKey.currentState?.pushNamed(
                                      AppRouter.myQrScreen,
                                      arguments: [
                                        state.response.data!.qrCode.toString(),
                                        state.response.data!.name.toString()
                                      ]);
                                },
                                child: infoTile("My QR Code")),
                            const SizedBox(
                              height: 33,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Settings",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          color: normalblack0D1F3CColor,
                                          fontWeight: semiBold))),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: () {
                                  AppRouter.navigatorKey.currentState?.pushNamed(
                                      AppRouter.scheduleScreen,
                                      arguments: false);
                                },
                                child: infoTile("My Schedule")),
                            const SizedBox(
                              height: 22,
                            ),
                            Container(
                                height: 54,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: lightGreyF6F6F6Color),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Notifications",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: greyicon374151Color,
                                                fontWeight: semiBold))),
                                    CupertinoSwitch(
                                      value: state.response.data!.notification ??
                                          false,
                                      onChanged: (value) async {
                                        await AuthRepository.notificationCheck(
                                                value)
                                            .then((data) {
                                          // if (data.status == true) {
                                          //   setState(() {
                                          //     notificationCheck = value;
                                          //   });
                                          // }
                                          BlocProvider.of<ProfileTabCubit>(
                                                  context)
                                              .getProfileInfo();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 22,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: lightGreyF6F6F6Color),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Subscription",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: greyicon374151Color,
                                                fontWeight: semiBold))),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Live Location Tracker",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 10.60,
                                                    color: redCA1F27Color,
                                                    fontWeight: semiBold))),
                                        Text("Expires on :- 22/08/2024",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 10.60,
                                                    color: darkBlack000000Color,
                                                    fontWeight: semiBold))),
                                      ],
                                    )
                                  ],
                                )),
                            const SizedBox(
                              height: 22,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return LogoutDialog();
                                    });
                              },
                              child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: lightGreyF6F6F6Color),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 15),
                                  child: Center(
                                    child: Text("SIGN OUT",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: redCA1F27Color,
                                                fontWeight: bold))),
                                  )),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is ProfileTabErrorState) {
                    return Center(child: Text("Something Went Wrong"));
                  }
                  return const Center(
                      child: CircularProgressIndicator(color: redCA1F27Color));
                },
              );}
            )),
      ),
    );
  }

  Widget infoTile(String name) {
    return Container(
        height: 54,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: lightGreyF6F6F6Color),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        color: greyicon374151Color,
                        fontWeight: semiBold))),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: greyicon374151Color,
            )
          ],
        ));
  }
}
