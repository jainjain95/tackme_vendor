import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../router/app_router.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  const SizedBox(height: 17),
                  Image.asset(
                    
                    "$pngAssetsBasePath/first_logo.png",
                    height: 82,
                    width: 110,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: lightGreyF6F6F6Color,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TabBar(
                        // controller: _tabController,
                        indicator: BoxDecoration(
                            color: redCA1F27Color,
                            borderRadius: BorderRadius.circular(10.0)),
                        labelStyle: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: black111011Color,
                                fontWeight: semiBold)),
                        labelColor: Colors.white,
                        unselectedLabelColor: redCA1F27Color,
                        tabs: const [
                          Tab(
                            text: 'Free',
                          ),
                          Tab(
                            text: 'Stop',
                          ),
                          Tab(
                            text: 'Location',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 37),
                  Expanded(
                    child: TabBarView(
                      children: [
                        //////////////////////////////////////////////////////////////////    tab 1
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 30, top: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              color: redCA1F27Color,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.5), // Shadow color and opacity
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: Offset(0, 3), // Offset from the top
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Free Plan",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 27.87,
                                            fontWeight: bold,
                                            color: whiteFFFFFFColor)),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(
                                              .4), // Shadow color and opacity
                                          spreadRadius: 5, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: Offset(
                                              0, 3), // Offset from the top
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          "$svgAssetsBasePath"
                                          "/teenyicons_gift-solid.svg",
                                          height: 50,
                                          width: 50,
                                        ), 
                                    )
                                  ),
                                  
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22, horizontal: 13.2),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        color: whiteFFFFFFColor),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "12 Month Plan",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color: redCA1F27Color)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "Only For NEW Vendors",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color: redCA1F27Color)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "Max. 5 Live Location Tracker",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color: redCA1F27Color)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$0.00 | Yearly",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 27.87,
                                            fontWeight: bold,
                                            color: whiteFFFFFFColor)),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return applePayBottomSheet();
                                          });
                                    },
                                    child: Container(
                                        width: 166,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13.8)),
                                            color: whiteFFFFFFColor),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 23.05, vertical: 13.83),
                                        child: Center(
                                          child: Text(
                                            "Buy Now",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.29,
                                                    fontWeight: bold,
                                                    color: redCA1F27Color)),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //////////////////////////////////////////////////////////////    2
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 30, top: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              color: whiteFFFFFFColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.5), // Shadow color and opacity
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: Offset(0, 3), // Offset from the top
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Stop Notifications",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 27.87,
                                            fontWeight: bold,
                                            color: darkBlack000000Color)),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(
                                              .4), // Shadow color and opacity
                                          spreadRadius: 4, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: Offset(
                                              0, 3), // Offset from the top
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          "$svgAssetsBasePath"
                                          "/zondicons_location.svg",
                                          height: 50,
                                          width: 50,
                                        ), 
                                    )
                                  ),
                                  // CircleAvatar(
                                  //     radius: 41,
                                  //     backgroundColor: whiteFFFFFFColor,
                                  //     child: Center(
                                  //       child: SvgPicture.asset(
                                  //         "/zondicons_location.svg",
                                  //         height: 50,
                                  //         width: 50,
                                  //       ),
                                  //     )),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22, horizontal: 13.2),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        color: whiteFFFFFFColor),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "12 Month Plan",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color:
                                                          darkBlack000000Color)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "Unlimited Stop Notifications",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color:
                                                          darkBlack000000Color)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "Unlimited Live Location Tracker",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color:
                                                          darkBlack000000Color)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$50 | Yearly",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 27.87,
                                            fontWeight: bold,
                                            color: redCA1F27Color)),
                                  ),
                                  GestureDetector(
                                    onTap:(){
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return applePayBottomSheet();
                                          });
                                    },
                                    child: Container(
                                        width: 166,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13.8)),
                                            color: redCA1F27Color),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 23.05, vertical: 13.83),
                                        child: Center(
                                          child: Text(
                                            "Buy Now",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.29,
                                                    fontWeight: bold,
                                                    color: whiteFFFFFFColor)),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //////////////////////////////////////////////////////////////    3
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 30, top: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              color: whiteFFFFFFColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.5), // Shadow color and opacity
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: Offset(0, 3), // Offset from the top
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Stop Notifications",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 27.87,
                                            fontWeight: bold,
                                            color: darkBlack000000Color)),
                                  ),
                                  Image.asset("$pngAssetsBasePath"
                                          "/Ac Repair.png",
                                          height: 100,
                                          width: 100,),
                                  // CircleAvatar(
                                  //     radius: 41,
                                  //     backgroundColor: whiteFFFFFFColor,
                                  //     child: Center(
                                  //       child: SvgPicture.asset(
                                  //         "/zondicons_location.svg",
                                  //         height: 50,
                                  //         width: 50,
                                  //       ),
                                  //     )),
                                  // Container(
                                  //   height: 80,
                                  //   width: 80,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     color: Colors.white,
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Colors.grey.withOpacity(
                                  //             .4), // Shadow color and opacity
                                  //         spreadRadius: 5, // Spread radius
                                  //         blurRadius: 7, // Blur radius
                                  //         offset: Offset(
                                  //             0, 3), // Offset from the top
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   child: Center(
                                  //     child: SvgPicture.asset(
                                          // "$svgAssetsBasePath"
                                          // "/zondicons_location.svg",
                                          // height: 50,
                                          // width: 50,
                                  //       ), 
                                  //   )
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22, horizontal: 13.2),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        color: whiteFFFFFFColor),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "12 Month Plan",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color:
                                                          darkBlack000000Color)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "Unlimited Live Location Tracker",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color:
                                                          darkBlack000000Color)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "$svgAssetsBasePath"
                                              "/gg_check-o.svg",
                                              height: 16.5,
                                              width: 16.5,
                                            ),
                                            const SizedBox(width: 7.7),
                                            Text(
                                              "Save 15% on each cut !",
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: bold,
                                                      color:
                                                          darkBlack000000Color)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$24 | Yearly",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 27.87,
                                            fontWeight: bold,
                                            color: redCA1F27Color)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return applePayBottomSheet();
                                          });
                                    },
                                    child: Container(
                                        width: 166,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13.8)),
                                            color: redCA1F27Color),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 23.05, vertical: 13.83),
                                        child: Center(
                                          child: Text(
                                            "Buy Now",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.29,
                                                    fontWeight: bold,
                                                    color: whiteFFFFFFColor)),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  Widget applePayBottomSheet() {
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
                Text(
                  "Enter Discount Code",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: bold,
                          color: darkBlack000000Color)),
                ),
                const SizedBox(
                  height: 30,
                ),
                textFieldOptionCode("Code (optional)"),
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
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    // You can customize the content of the bottom sheet here
                                    // height: double.infinity,
                                    color: black111011Color,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Apple Pay",
                                                textAlign: TextAlign.justify,
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: bold,
                                                        color:
                                                            whiteFFFFFFColor)),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    AppRouter.navigatorKey
                                                        .currentState
                                                        ?.pop();
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 70,
                                                width: 70,
                                                decoration: const BoxDecoration(
                                                    color: whiteFFFFFFColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 70,
                                                width: 250,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "(6 Months)",
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: GoogleFonts.openSans(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      whiteFFFFFFColor)),
                                                    ),
                                                    Text(
                                                      "Your App - Description",
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: GoogleFonts.openSans(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      mediumGrey9CA3AFColor)),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              color: mediumBlack6F6F6FColor),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "DETAILS",
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            mediumGrey9CA3AFColor)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 70,
                                                width: 250,
                                                child: Text(
                                                  "For testing purposes only. You will not be charged for confirming this purchase.",
                                                  textAlign: TextAlign.justify,
                                                  style: GoogleFonts.openSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              whiteFFFFFFColor)),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              color: mediumBlack6F6F6FColor),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "ACCOUNT",
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            mediumGrey9CA3AFColor)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "subs@mail.com",
                                                textAlign: TextAlign.justify,
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            whiteFFFFFFColor)),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              color: mediumBlack6F6F6FColor),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "TRIAL",
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            mediumGrey9CA3AFColor)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "3 DAYS FREE",
                                                textAlign: TextAlign.justify,
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            whiteFFFFFFColor)),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "PRICE",
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            mediumGrey9CA3AFColor)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Starting on 02 Oct 2021",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: GoogleFonts.openSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                whiteFFFFFFColor)),
                                                  ),
                                                  Text(
                                                    "\$ 4.99 per month",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: GoogleFonts.openSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                whiteFFFFFFColor)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                              color: mediumBlack6F6F6FColor),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (ctx) => AlertDialog(
                                                              backgroundColor:
                                                                  black111011Color,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    const Text(
                                                                      "You are all set",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color:
                                                                            whiteFFFFFFColor,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    const Text(
                                                                      "Your purchase was successful.",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              whiteFFFFFFColor),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          darkBlack000000Color,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        AppRouter
                                                                            .navigatorKey
                                                                            .currentState
                                                                            ?.pushNamed(AppRouter.dashboard);
                                                                        // Navigator.pop(context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Ok",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.blue),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              child: SvgPicture.asset(
                                                  "$svgAssetsBasePath/slide_button.svg")),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Confirm with Side Button",
                                            style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 17,
                                                    color: whiteFFFFFFColor)),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        },
                        child: Text(
                          "SUBMIT",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: bold)),
                        ))),
              ],
            ),
          ),
        ));
  }

  // showModalBottomSheet(
  //                       context: context,
  //                       isScrollControlled: true,
  //                       builder: (BuildContext context) {
  //                         return Padding(
  //                             padding: EdgeInsets.only(
  //                                 bottom:
  //                                     MediaQuery.of(context).viewInsets.bottom),
  //                             child: Container(
  //                               // You can customize the content of the bottom sheet here
  //                               // height: double.infinity,
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(20.0),
  //                                 child: Column(
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: <Widget>[
  //                                     SizedBox(height: 10,),
  //                                     Text(
  //                                       "Enter Discount Code",
  //                                       textAlign: TextAlign.justify,
  //                                       style: GoogleFonts.openSans(
  //                                           textStyle: const TextStyle(
  //                                               fontSize: 24,
  //                                               fontWeight: bold,
  //                                               color: darkBlack000000Color)),
  //                                     ),
  //                                     const SizedBox(
  //                                       height: 30,
  //                                     ),
  //                                     textFieldOptionCode("Code (optional)"),

  //                                     SizedBox(
  //                                         height: 50,
  //                                         width: double.infinity,
  //                                         child: ElevatedButton(
  //                                             style: ElevatedButton.styleFrom(
  //                                               backgroundColor: redCA1F27Color,
  //                                               foregroundColor: Colors.white,
  //                                               elevation: 0,
  //                                               shape: RoundedRectangleBorder(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           10.0)),
  //                                             ),
  //                                             onPressed: () {
  //                                               Navigator.pop(context);
  //                                               showModalBottomSheet(
  //                                                 context: context,
  //                                                 isScrollControlled: true,
  //                                                 builder:
  //                                                     (BuildContext context) {
  //                                                   return Padding(
  //                                                       padding: EdgeInsets.only(
  //                                                           bottom:
  //                                                               MediaQuery.of(
  //                                                                       context)
  //                                                                   .viewInsets
  //                                                                   .bottom),
  //                                                       child: Container(
  //                                                         // You can customize the content of the bottom sheet here
  //                                                         // height: double.infinity,
  //                                                         color:
  //                                                             black111011Color,
  //                                                         child: Padding(
  //                                                           padding:
  //                                                               const EdgeInsets
  //                                                                   .all(20.0),
  //                                                           child: Column(
  //                                                             mainAxisSize:
  //                                                                 MainAxisSize
  //                                                                     .min,
  //                                                             crossAxisAlignment:
  //                                                                 CrossAxisAlignment
  //                                                                     .center,
  //                                                             children: <Widget>[
  //                                                               Row(
  //                                                                 children: [
  //                                                                   Text(
  //                                                                     "Apple Pay",
  //                                                                     textAlign:
  //                                                                         TextAlign
  //                                                                             .justify,
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 24,
  //                                                                             fontWeight: bold,
  //                                                                             color: whiteFFFFFFColor)),
  //                                                                   ),
  //                                                                   const Spacer(),
  //                                                                   InkWell(
  //                                                                       onTap:
  //                                                                           () {
  //                                                                         AppRouter
  //                                                                             .navigatorKey
  //                                                                             .currentState
  //                                                                             ?.pop();
  //                                                                       },
  //                                                                       child:
  //                                                                           const Text(
  //                                                                         "Cancel",
  //                                                                         style:
  //                                                                             TextStyle(color: Colors.blue),
  //                                                                       ))
  //                                                                 ],
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 20,
  //                                                               ),
  //                                                               Row(
  //                                                                 children: [
  //                                                                   Container(
  //                                                                     height:
  //                                                                         70,
  //                                                                     width: 70,
  //                                                                     decoration: const BoxDecoration(
  //                                                                         color:
  //                                                                             whiteFFFFFFColor,
  //                                                                         borderRadius:
  //                                                                             BorderRadius.all(Radius.circular(10))),
  //                                                                   ),
  //                                                                   const SizedBox(
  //                                                                     width: 10,
  //                                                                   ),
  //                                                                   Container(
  //                                                                     height:
  //                                                                         70,
  //                                                                     width:
  //                                                                         250,
  //                                                                     child:
  //                                                                         Column(
  //                                                                       crossAxisAlignment:
  //                                                                           CrossAxisAlignment.start,
  //                                                                       children: [
  //                                                                         Text(
  //                                                                           "(6 Months)",
  //                                                                           textAlign:
  //                                                                               TextAlign.justify,
  //                                                                           style:
  //                                                                               GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 16, color: whiteFFFFFFColor)),
  //                                                                         ),
  //                                                                         Text(
  //                                                                           "Your App - Description",
  //                                                                           textAlign:
  //                                                                               TextAlign.justify,
  //                                                                           style:
  //                                                                               GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 16, color: mediumGrey9CA3AFColor)),
  //                                                                         ),
  //                                                                       ],
  //                                                                     ),
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               const Divider(
  //                                                                   color:
  //                                                                       mediumBlack6F6F6FColor),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               Row(
  //                                                                 crossAxisAlignment:
  //                                                                     CrossAxisAlignment
  //                                                                         .start,
  //                                                                 children: [
  //                                                                   Text(
  //                                                                     "DETAILS",
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 16,
  //                                                                             color: mediumGrey9CA3AFColor)),
  //                                                                   ),
  //                                                                   const SizedBox(
  //                                                                     width: 10,
  //                                                                   ),
  //                                                                   Container(
  //                                                                     height:
  //                                                                         70,
  //                                                                     width:
  //                                                                         250,
  //                                                                     child:
  //                                                                         Text(
  //                                                                       "For testing purposes only. You will not be charged for confirming this purchase.",
  //                                                                       textAlign:
  //                                                                           TextAlign.justify,
  //                                                                       style: GoogleFonts.openSans(
  //                                                                           textStyle:
  //                                                                               const TextStyle(fontSize: 16, color: whiteFFFFFFColor)),
  //                                                                     ),
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               const Divider(
  //                                                                   color:
  //                                                                       mediumBlack6F6F6FColor),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               Row(
  //                                                                 crossAxisAlignment:
  //                                                                     CrossAxisAlignment
  //                                                                         .start,
  //                                                                 children: [
  //                                                                   Text(
  //                                                                     "ACCOUNT",
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 16,
  //                                                                             color: mediumGrey9CA3AFColor)),
  //                                                                   ),
  //                                                                   const SizedBox(
  //                                                                     width: 10,
  //                                                                   ),
  //                                                                   Text(
  //                                                                     "subs@mail.com",
  //                                                                     textAlign:
  //                                                                         TextAlign
  //                                                                             .justify,
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 16,
  //                                                                             color: whiteFFFFFFColor)),
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               const Divider(
  //                                                                   color:
  //                                                                       mediumBlack6F6F6FColor),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               Row(
  //                                                                 crossAxisAlignment:
  //                                                                     CrossAxisAlignment
  //                                                                         .start,
  //                                                                 children: [
  //                                                                   Text(
  //                                                                     "TRIAL",
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 16,
  //                                                                             color: mediumGrey9CA3AFColor)),
  //                                                                   ),
  //                                                                   const SizedBox(
  //                                                                     width: 10,
  //                                                                   ),
  //                                                                   Text(
  //                                                                     "3 DAYS FREE",
  //                                                                     textAlign:
  //                                                                         TextAlign
  //                                                                             .justify,
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 18,
  //                                                                             color: whiteFFFFFFColor)),
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               Row(
  //                                                                 crossAxisAlignment:
  //                                                                     CrossAxisAlignment
  //                                                                         .start,
  //                                                                 children: [
  //                                                                   Text(
  //                                                                     "PRICE",
  //                                                                     style: GoogleFonts.openSans(
  //                                                                         textStyle: const TextStyle(
  //                                                                             fontSize: 16,
  //                                                                             color: mediumGrey9CA3AFColor)),
  //                                                                   ),
  //                                                                   const SizedBox(
  //                                                                     width: 10,
  //                                                                   ),
  //                                                                   Column(
  //                                                                     crossAxisAlignment:
  //                                                                         CrossAxisAlignment
  //                                                                             .start,
  //                                                                     children: [
  //                                                                       Text(
  //                                                                         "Starting on 02 Oct 2021",
  //                                                                         textAlign:
  //                                                                             TextAlign.justify,
  //                                                                         style:
  //                                                                             GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 18, color: whiteFFFFFFColor)),
  //                                                                       ),
  //                                                                       Text(
  //                                                                         "\$ 4.99 per month",
  //                                                                         textAlign:
  //                                                                             TextAlign.justify,
  //                                                                         style:
  //                                                                             GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 18, color: whiteFFFFFFColor)),
  //                                                                       ),
  //                                                                     ],
  //                                                                   )
  //                                                                 ],
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               const Divider(
  //                                                                   color:
  //                                                                       mediumBlack6F6F6FColor),
  //                                                               const SizedBox(
  //                                                                 height: 10,
  //                                                               ),
  //                                                               InkWell(
  //                                                                   onTap: () {
  //                                                                     Navigator.pop(
  //                                                                         context);
  //                                                                     showDialog(
  //                                                                         context:
  //                                                                             context,
  //                                                                         builder: (ctx) =>
  //                                                                             AlertDialog(
  //                                                                               backgroundColor: black111011Color,
  //                                                                               insetPadding: EdgeInsets.zero,
  //                                                                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
  //                                                                               content: SingleChildScrollView(
  //                                                                                 child: Column(
  //                                                                                   children: <Widget>[
  //                                                                                     const SizedBox(
  //                                                                                       height: 20,
  //                                                                                     ),
  //                                                                                     const Text(
  //                                                                                       "You are all set",
  //                                                                                       style: TextStyle(
  //                                                                                         fontSize: 18,
  //                                                                                         color: whiteFFFFFFColor,
  //                                                                                       ),
  //                                                                                     ),
  //                                                                                     const SizedBox(
  //                                                                                       height: 5,
  //                                                                                     ),
  //                                                                                     const Text(
  //                                                                                       "Your purchase was successful.",
  //                                                                                       textAlign: TextAlign.center,
  //                                                                                       style: TextStyle(fontSize: 14, color: whiteFFFFFFColor),
  //                                                                                     ),
  //                                                                                     const SizedBox(
  //                                                                                       height: 20,
  //                                                                                     ),
  //                                                                                     const Divider(
  //                                                                                       color: darkBlack000000Color,
  //                                                                                     ),
  //                                                                                     const SizedBox(
  //                                                                                       height: 20,
  //                                                                                     ),
  //                                                                                     InkWell(
  //                                                                                       onTap: () {
  //                                                                                         AppRouter.navigatorKey.currentState?.pushNamed(AppRouter.dashboard);
  //                                                                                         // Navigator.pop(context);
  //                                                                                       },
  //                                                                                       child: const Text(
  //                                                                                         "Ok",
  //                                                                                         style: TextStyle(fontSize: 20, color: Colors.blue),
  //                                                                                       ),
  //                                                                                     ),
  //                                                                                   ],
  //                                                                                 ),
  //                                                                               ),
  //                                                                             ));
  //                                                                   },
  //                                                                   child: SvgPicture
  //                                                                       .asset(
  //                                                                           "$svgAssetsBasePath/slide_button.svg")),
  //                                                               const SizedBox(
  //                                                                 height: 20,
  //                                                               ),
  //                                                               Text(
  //                                                                 "Confirm with Side Button",
  //                                                                 style: GoogleFonts.openSans(
  //                                                                     textStyle: const TextStyle(
  //                                                                         fontSize:
  //                                                                             17,
  //                                                                         color:
  //                                                                             whiteFFFFFFColor)),
  //                                                               ),
  //                                                               const SizedBox(
  //                                                                 height: 20,
  //                                                               ),
  //                                                             ],
  //                                                           ),
  //                                                         ),
  //                                                       ));
  //                                                 },
  //                                               );
  //                                             },
  //                                             child: Text(
  //                                               "SUBMIT",
  //                                               style: GoogleFonts.openSans(
  //                                                   textStyle: const TextStyle(
  //                                                       fontSize: 16,
  //                                                       fontWeight: bold)),
  //                                             ))),
  //                                     // const SizedBox(
  //                                     //   height: 10,
  //                                     // ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ));
  //                       },
  //                     );

  SizedBox textFieldOptionCode(String labelText, {keyBoardType, focusNode}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: TextField(
        // textAlign: TextAlign.center,
        focusNode: focusNode,
        keyboardType: keyBoardType,
        cursorColor: black111011Color,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.openSans(
              textStyle: const TextStyle(
            color: darkBlack000000Color,
            fontSize: 16,
          )),
          alignLabelWithHint: false,
          floatingLabelAlignment: FloatingLabelAlignment.start,
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
                const BorderSide(width: 1, color: mediumGrey9CA3AFColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(width: 1, color: mediumGrey9CA3AFColor),
          ),
          filled: true,
          fillColor: mediumDarkGreyF1F1F1Color,
          // hintText: "Code Optional",
          // hintStyle: GoogleFonts.openSans(
          //     textStyle: const TextStyle(color: mediumGrey9CA3AFColor, fontSize: 16, fontWeight: bold)),
        ),
      ),
    );
  }
}
