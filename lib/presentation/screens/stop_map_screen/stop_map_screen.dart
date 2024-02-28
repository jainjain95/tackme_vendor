import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';

class StopMapScreen extends StatefulWidget {
  Data data;
  StopMapScreen({super.key, required this.data});

  @override
  State<StopMapScreen> createState() => _StopMapScreenState();
}

class _StopMapScreenState extends State<StopMapScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: greyicon374151Color)),
          ),
          title: Text(
            widget.data.location!.locationNickName.toString(),
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: black111011Color)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocConsumer<InternetCubit, bool>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state == false) {
                // return Center(child: Container(height: 10, width: 10, color: Colors.green));
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        "$svgAssetsBasePath/robot_connection_error.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Connection failed, Please check your\nnetwork settings",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: black111011Color,
                                fontWeight: semiBold))),
                  ],
                ));
              }
              return Column(
                children: [
                  CustomTextFeild(
                    hintText: widget.data.location!.locationNickName,
                    enable: false,
                  ),
                  const SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: lightGreyF6F6F6Color,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.search,
                            color: mediumGrey9CA3AFColor,
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Text(
                              widget.data.location!.text.toString(),
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: mediumGrey9CA3AFColor,
                                      fontWeight: normal)),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: [
                          GoogleMap(
                              // scrollGesturesEnabled: false,
                              myLocationButtonEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    widget.data.location!.coordinates![1],
                                    widget.data.location!.coordinates![0]),
                                zoom: 16.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId('first_mark'),
                                  position: LatLng(
                                      widget.data.location!.coordinates![1],
                                      widget.data.location!.coordinates![
                                          0]), // Coordinates for the marker
                                )
                              }),
                          Positioned(
                            bottom: 25,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              child: GestureDetector(
                                onTap: () {
                                  AppRouter.navigatorKey.currentState
                                      ?.pushNamed(AppRouter.stopQrScreen,
                                          arguments: widget.data);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  // constraints: BoxConstraints(
                                  //   minHeight: 0.0,
                                  // ),
                                  decoration: BoxDecoration(
                                      color: redCA1F27Color,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //     "$pngAssetsBasePath/Component 7.png"),
                                      SvgPicture.asset(
                                          "$svgAssetsBasePath/qr.svg"),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Show QR",
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              );
            },
          ),
        ));
  }
}
