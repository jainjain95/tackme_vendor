import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_state.dart';
import 'package:tagmevendor/models/req_model/start_route_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/start_route_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/dashboard/dashboard.dart';
import 'package:tagmevendor/presentation/screens/home_screen/home_screen.dart';
import 'package:tagmevendor/presentation/screens/route_on_map_screen/widget/checkin_qr_dialog.dart';
import 'package:tagmevendor/presentation/widgets/end_route_alert_dialog.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../core/colors/app_colors.dart';
import '../../../logic/cubits/start_route_map/start_route_map_cubit.dart';

class RouteOnMapScreen extends StatefulWidget {
  StartRouteReqModel routeDataa;
  RouteOnMapScreen({super.key, required this.routeDataa});

  @override
  State<RouteOnMapScreen> createState() => _RouteOnMapScreenState();
}

class _RouteOnMapScreenState extends State<RouteOnMapScreen> {
  LatLng _center = LatLng(20.984463, 70.706413);

  List<LatLng> points = [];
  final Map<String, Marker> marker = {};
  // String routeName = "";
  // late StartRouteModel data;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> _animateCameraToTarget(LatLng targetPosition) async {
    if (_controller != null) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: 12),
      ));
    }
  }

  Future<void> getCurrentLocation() async {
    print("1");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      if (widget.routeDataa.isOngoing == true) {
        print("ongoing is true");
      } else {
        setState(() {
          print("2");
          // _center = LatLng(value.latitude, value.longitude);
          // _controller?.animateCamera(
          //                   CameraUpdate.newCameraPosition(
          //                     CameraPosition(
          //                       target:
          //                       LatLng(value.latitude, value.longitude),
          //                       zoom: 12
          //                     )
          //                   )
          //                 );
          BlocProvider.of<StartRouteMapCubit>(context).getStartRouteData(
              widget.routeDataa.routeData,
              LatLng(value.latitude, value.longitude));
        });
        // BlocProvider.of<StartRouteMapCubit>(context).getStartRouteData(
        //     widget.routeDataa.routeData,
        //     LatLng(value.latitude, value.longitude));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BlocProvider.of<StartRouteMapCubit>(context).resetState();
    super.dispose();
  }

  LatLngBounds calculateLatLngBounds(List<LatLng> coordinates) {
    double minLat = coordinates[0].latitude;
    double maxLat = coordinates[0].latitude;
    double minLng = coordinates[0].longitude;
    double maxLng = coordinates[0].longitude;

    for (LatLng coordinate in coordinates) {
      if (coordinate.latitude > maxLat) maxLat = coordinate.latitude;
      if (coordinate.latitude < minLat) minLat = coordinate.latitude;
      if (coordinate.longitude > maxLng) maxLng = coordinate.longitude;
      if (coordinate.longitude < minLng) minLng = coordinate.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          title: BlocBuilder<StartRouteMapCubit, StartRouteMapState>(
            builder: (context, state) {
              if (state is StartRouteMapResponseState) {
                return Text(
                  // widget.routeDataa.routeData.routeNickName.toString() ??
                  //     routeName,
                  state.startRouteData.route!.routeName!.routeNickName
                      .toString(),
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: semiBold,
                          color: darkBlack000000Color)),
                );
              }
              return Container();
            },
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: InkWell(
                onTap: () {
                  // AppRouter.navigatorKey.currentState?.pop();
                  AppRouter.navigatorKey.currentState?.pop();
                  // MaterialPageRoute(builder: (context) => Dashboard());

                  // AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRouter.dashboard, (route) => false);
                },
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: greyicon374151Color)),
          ),
        ),
        body: BlocBuilder<InternetCubit, bool>(
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
                  Text("Connection failed, Please check your\nnetwork settings",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: black111011Color,
                              fontWeight: semiBold))),
                ],
              ));
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                BlocConsumer<StartRouteMapCubit, StartRouteMapState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is StartRouteMapErrorState) {
                      AppRouter.navigatorKey.currentState?.pop();
                      //           Navigator.pushReplacement(
                      // context,
                      // MaterialPageRoute(builder: (context) => HomeScreen()));

                      //   }
                    }
                    if (state is StartRouteMapResponseState) {
                      setState(() {
                        _animateCameraToTarget(LatLng(
                            state.points.first.latitude,
                            state.points.first.longitude));
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is StartRouteMapResponseState) {
                      return GoogleMap(
                        myLocationButtonEnabled: false,
                        polylines: {
                          Polyline(
                            polylineId: PolylineId("12348"),
                            color: Colors.blueAccent,
                            points: state.points,
                            width: 3,
                          )
                        },
                        // markers: marker.values.toSet(),
                        markers: Set<Marker>.of(state.marker.values),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          setState(() {
                            _animateCameraToTarget(LatLng(
                                state.points.first.latitude,
                                state.points.first.longitude));
                          });
                        },
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 12.0,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                BlocConsumer<StartRouteMapCubit, StartRouteMapState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    // Navigator.pop(context);
                    if (state is StartRouteMapResponseState) {
                      if (state.startRouteData.route!.stops!.first.isArrived ==
                          false) {
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is StartRouteMapResponseState) {
                      return DraggableScrollableSheet(
                        initialChildSize:
                            (state.startRouteData.route!.stops!.length > 2)
                                ? 0.51
                                : 0.43,
                        minChildSize: 0.3,
                        maxChildSize:
                            (state.startRouteData.route!.stops!.length > 2)
                                ? 0.51
                                : 0.43,
                        builder: (context, controller) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // child: routeBottomSheet()
                              child: Container(
                                color: whiteFFFFFFColor,
                                padding: const EdgeInsets.only(
                                    top: 15, left: 24, right: 24),
                                child: ListView(
                                  controller: controller,
                                  shrinkWrap: true,
                                  children: [
                                    SvgPicture.asset(
                                        "$svgAssetsBasePath/drag_handle.svg"),
                                    const SizedBox(height: 20),
                                    state.startRouteData.route!.stops!.last
                                                .isArrived ==
                                            true
                                        ? Center(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return EndRouteAlertDialog(
                                                            onGoingRouteid: state
                                                                .startRouteData
                                                                .route!
                                                                .id
                                                                .toString());
                                                      });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.logout,
                                                      color: redCA1F27Color,
                                                    ),
                                                    Text(
                                                      "End Route",
                                                      style: GoogleFonts.inter(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      semiBold,
                                                                  color:
                                                                      redCA1F27Color)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // state.startRouteData.route!.stops!.last.isArrived == true ? SizedBox() :
                                              Row(
                                                children: [
                                                  Text(
                                                    state.startRouteData.route!
                                                        .distance
                                                        .toString(), // api gives time in distance key
                                                    style: GoogleFonts.openSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                semiBold,
                                                            color:
                                                                redCA1F27Color)),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "(" +
                                                        state.startRouteData
                                                            .route!.duration
                                                            .toString()
                                                            .toString() +
                                                        ")",

                                                    /// api gives distance in duration key
                                                    style: GoogleFonts.openSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 22,
                                                            fontWeight: normal,
                                                            color:
                                                                redCA1F27Color)),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return EndRouteAlertDialog(
                                                            onGoingRouteid: state
                                                                .startRouteData
                                                                .route!
                                                                .id
                                                                .toString());
                                                      });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.logout,
                                                      color: redCA1F27Color,
                                                    ),
                                                    Text(
                                                      "End Route",
                                                      style: GoogleFonts.inter(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      semiBold,
                                                                  color:
                                                                      redCA1F27Color)),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                    state.startRouteData.route!.stops!.last
                                                .isArrived ==
                                            true
                                        ? SizedBox()
                                        : Text(
                                            "Fastest Route now due to traffic conditions",
                                            style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: normal,
                                                    color:
                                                        redwithOpacityCA1F27Color)),
                                          ),
                                    const SizedBox(height: 24),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: TimelineTile(
                                            isFirst: true,
                                            beforeLineStyle: LineStyle(
                                                thickness: 2,
                                                color: green4CAF50Color
                                                // redwithOpacityCA1F27Color
                                                ),
                                            // beforeLineStyle: LineStyle(),
                                            indicatorStyle:
                                                const IndicatorStyle(
                                                    indicator: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.green,
                                              // redwithExtraOpacityCA1F27Color,
                                              child: CircleAvatar(
                                                  radius: 3,
                                                  backgroundColor: Colors.green
                                                  // redCA1F27Color
                                                  ),
                                            )),

                                            endChild: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    height: 36,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            // vertical: 10,
                                                            horizontal: 20),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                mediumDarkGreyF1F1F1Color)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Text(
                                                              state
                                                                  .startRouteData
                                                                  .route!
                                                                  .startingLocation!
                                                                  .startAddress
                                                                  .toString(),
                                                              // "testing",
                                                              maxLines: 1,
                                                              style: GoogleFonts.openSans(
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          semiBold,
                                                                      color:
                                                                          green4CAF50Color)),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state.startRouteData
                                                .route!.stops!.length,
                                            itemBuilder: (context, index) {
                                              return AddRouteLineTile(
                                                  context,
                                                  index,
                                                  state.startRouteData,
                                                  state.cindex);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                )
              ],
            );
          },
        ));
  }

  Widget AddRouteLineTile(
      BuildContext context, int count, StartRouteModel data, int cindex) {
    return SizedBox(
      height: 50,
      child: TimelineTile(
        isFirst: false,
        isLast: (count + 1) == data.route!.stops!.length ? true : false,
        beforeLineStyle: LineStyle(
            thickness: 2,
            color: data.route!.stops![count].isArrived == true
                ? green4CAF50Color
                : redwithOpacityCA1F27Color),
        // beforeLineStyle: LineStyle(),
        indicatorStyle: IndicatorStyle(
            indicator: CircleAvatar(
          radius: 15,
          backgroundColor: redwithExtraOpacityCA1F27Color,
          child: Center(
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: data.route!.stops![count].isArrived == true
                      ? green4CAF50Color
                      : redCA1F27Color),
              child: Center(
                child: FittedBox(
                  child: Text(
                    (count + 1).toString(),
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: semiBold,
                            color: whiteFFFFFFColor)),
                  ),
                ),
              ),
            ),
          ),
        )),

        endChild: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Container(
                height: 36,
                padding: EdgeInsets.symmetric(
                    // vertical: 10,
                    horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(width: 1, color: mediumDarkGreyF1F1F1Color)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 50,
                      child: Text(
                        data.route!.stops![count].location!.locationNickName
                            .toString(),
                        // "njxdbv",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: semiBold,
                          color: data.route!.stops![count].isArrived == true
                              ? green4CAF50Color
                              : redCA1F27Color,
                        )),
                      ),
                    ),
                    data.route!.stops![count].isArrived == true
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return CheckinAndQrDialog(
                                      routeId: data.route!.id.toString(),
                                      stopId: data.route!.stops![count].sid
                                          .toString(),
                                      qrImage: data.route!.stops![count].qrCode
                                          .toString());
                                },
                              );
                            },
                            child: Text(
                              "Arrived",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: extraBold,
                                      // color: redCA1F27Color
                                      color: green4CAF50Color)),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return CheckinAndQrDialog(
                              //         routeId: data.route!.id.toString(),
                              // stopId: data.route!.stops![count].stopId
                              //     .toString(),
                              //         qrImage: data.route!.stops![count].qrCode
                              //             .toString());
                              //   },
                              // );
                              if (cindex == count) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                                  color: redCA1F27Color)));
                                    });
                                BlocProvider.of<StartRouteMapCubit>(context)
                                    .checkInStop(
                                        data.route!.id.toString(),
                                        data.route!.stops![count].sid
                                            .toString());
                              }
                            },
                            child: Text(
                              "CHECK IN",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          cindex == count ? extraBold : normal,
                                      color: redCA1F27Color)),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// (data.route!.stops![count-1].status.toString() == "arrived") ? normal :
