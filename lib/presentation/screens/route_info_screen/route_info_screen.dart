import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/models/req_model/start_route_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:http/http.dart' as http;
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/route_running_alert_message.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:ui' as ui;

class RouteMapScreen extends StatefulWidget {
  RData routeData;
  RouteMapScreen({super.key, required this.routeData});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  GoogleMapController? _controller;
  LatLng _center = LatLng(28.984463, 77.706413);
  List<LatLng> points = [];
  final Map<String, Marker> marker = {};
  LatLngBounds? bounds;
  bool isOnGoing = false;

  @override
  void initState() {
    // TODO: implement initState

    generateMap();
    super.initState();
    // generateMap();
  }
  

  Future<void> generateMap() async {
    for (var i = 0; i < widget.routeData.polyLine!.length; i++) {
      
      points.add(LatLng(
        widget.routeData.polyLine![i].latitude ?? 0.0,
        widget.routeData.polyLine![i].longitude ?? 0.0,
      ));
      print("lat lng added");
    }
    for (int i = 0; i < widget.routeData.stops!.length; i++) {
      String img = i.toString() + ".png";
      final Uint8List? markerCustomImage =
            await getBytesFromAssets(img, 90);
      marker[i.toString()] = Marker(
        markerId: MarkerId('marker_$i'),
        // icon: markerIcon,
        position: LatLng(widget.routeData.stops![i].location!.coordinates![1],
            widget.routeData.stops![i].location!.coordinates![0]),
        // icon: await img(i),
        icon: BitmapDescriptor.fromBytes(markerCustomImage!),
      );
    }
    print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    print(marker.length);
    await RouteRepository.ongoingRoute().then((value) {
      if (value.status == true) {
        isOnGoing = true;
      } else {
        isOnGoing = false;
      }
    });

    setState(() {

    });
  }

  Future<Uint8List?> getBytesFromAssets(String path, int width) async {
  ByteData data = await rootBundle.load('assets/images/pngs/$path');
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      ?.buffer
      .asUint8List();
}

  // Future<BitmapDescriptor> img(int imgIndex) async {
  //   String img = imgIndex.toString() + ".png";
  //   // BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
  //   //   ImageConfiguration(
  //   //       // size: Size(60.0, 60.0)
  //   //       // devicePixelRatio: 2.0
  //   //       ),
  //   //   'assets/images/pngs/$img',
  //   // );
  //   return customIcon;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

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
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: greyicon374151Color)),
          ),
          title: Text(
            widget.routeData.routeNickName.toString(),
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: black111011Color)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {
                    AppRouter.navigatorKey.currentState?.pushNamed(
                        AppRouter.editRouteScreen,
                        arguments: widget.routeData);

                    print("Checked");
                  },
                  child: SvgPicture.asset(
                    "$svgAssetsBasePath/edit.svg",
                    height: 19,
                    width: 19,
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: BlocBuilder< InternetCubit, bool>(
            builder: (context, state) {
              if(state == false){
        // return Center(child: Container(height: 10, width: 10, color: Colors.green));
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
              return Column(
              children: [
                const SizedBox(height: 20),
                Container(
                    height: 48,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 20, top: 8, bottom: 8),
                    decoration: const BoxDecoration(
                        color: lightGreyF6F6F6Color,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Text(
                          "Availability " +
                              widget.routeData.schedule!.startTime.toString() +
                              " to " +
                              widget.routeData.schedule!.endTime.toString(),
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: normal,
                                  color: mediumGrey9CA3AFColor)),
                        ),
                        const SizedBox(width: 5),
                        const Spacer(),
                        SizedBox(
                          // width: 150,
                          child: Text(
                            widget.routeData.schedule!.scheduleName.toString(),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: normal,
                                    color: mediumGrey9CA3AFColor)),
                          ),
                        ),
                        // SizedBox(width: 14),
                        // Icon(Icons.keyboard_arrow_down_rounded,size: 20, color: greyicon374151Color)
                      ],
                    )),
                const SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: lightGreyF6F6F6Color,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.routeData.stops!.length,
                        itemBuilder: (context, index) {
                          return AddRouteLineTile(
                              index + 1,
                              widget.routeData.stops![index].location!
                                  .locationNickName
                                  .toString(),
                              widget.routeData.stops!.length);
                        })),
                const SizedBox(height: 20),
                Expanded(
                  child: SizedBox(
                    // height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: [
                          GoogleMap(
                            myLocationButtonEnabled: false,
                            polylines: points.length == 0
                                ? const <Polyline>{}
                                : {
                                    Polyline(
                                      polylineId: PolylineId("12348"),
                                      color: Colors.blueAccent,
                                      points: points,
                                      width: 3,
                                    )
                                  },
                            markers: marker.values.toSet(),
                            onMapCreated: (GoogleMapController controller) {
                              _controller = controller;
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(
                                          widget.routeData.stops!.first.location!
                                              .coordinates![1],
                                          widget.routeData.stops!.first.location!
                                              .coordinates![0]),
                                      zoom: 12)));
                              setState(() {});
                            },
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 11.0,
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                if (await Geolocator.isLocationServiceEnabled()) {
                                  if (isOnGoing == true) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return RouteRunningAlertMessage();
                                        });
                                  } else {
                                    AppRouter.navigatorKey.currentState
                                        ?.pushNamed(AppRouter.routeOnMapScreen,
                                            arguments: StartRouteReqModel(
                                                widget.routeData, false));
                                  }
                                } else {
                                  await Geolocator.getCurrentPosition();
                                }
          
                                //   if( isOnGoing == true){
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return RouteRunningAlertMessage();
                                //       }
                                //     );
                                //   } else {
                                //     AppRouter.navigatorKey.currentState
                                // ?.pushNamed(AppRouter.routeOnMapScreen, arguments: StartRouteReqModel(widget.routeData, false));
                                //   }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    //width: 80,
                                    padding: EdgeInsets.symmetric(horizontal: 24),
                                    // constraints: BoxConstraints.loose(),
                                    decoration: BoxDecoration(
                                        color: redCA1F27Color,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "$svgAssetsBasePath/Icon.svg"),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            "Start",
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20)
              ],
            );}
          ),
        ));
  }

  Widget AddRouteLineTile(int count, String stopName, int last) {
    return SizedBox(
      height: 45,
      child: TimelineTile(
        isFirst: count == 1 ? true : false,
        isLast: count == last ? true : false,
        beforeLineStyle:
            const LineStyle(thickness: 2, color: greylineCFD5DFColor),
        indicatorStyle: IndicatorStyle(
            width: 20,
            padding: const EdgeInsets.symmetric(vertical: 3),
            indicator: Container(
              height: 20,
              width: 20,
              color: Colors.black,
              child: Center(
                child: Text(
                  '$count',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: bold,
                          color: whiteFFFFFFColor)),
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
                padding: const EdgeInsets.all(9.5),
                // height: 31,
                // width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: whiteFFFFFFColor,
                ),
                child: Row(
                  children: [
                    Text(
                      stopName,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: normal,
                              color: mediumGrey9CA3AFColor)),
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

//   Future<Map<String, dynamic>?> getDirection(
//     String origin,
//     String destination,
//     // Map<String, dynamic> boundsNe,
//     // Map<String, dynamic> boundsS,
//   ) async {
//     String apikey = 'AIzaSyAfT02pJTjvN2wj4dRjfIqOm-EuaPKcDYs';
//     var url = Uri.parse(
//         'https://maps.googleapis.com/maps/api/directions/json?destination=$destination&origin=$origin&key=$apikey');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       print("///////////////////////////////////////////");
//       print(data);
//       var result = {
//         'bounds_ne': data['routes'][0]['bounds']['northeast'],
//         'bounds_se': data['routes'][0]['bounds']['southeast'],
//         'start_location': data['routes'][0]['legs'][0]['start_location'],
//         'end_location': data['routes'][0]['legs'][0]['end_location'],
//         'polyline': data['routes'][0]['overview_polyline']['points'],
//         'polyline_decode': PolylinePoints()
//             .decodePolyline(data['routes'][0]['overview_polyline']['points'])
//       };
//       print(result);
//       return result;
//     }
//     return null;
//   }
}
