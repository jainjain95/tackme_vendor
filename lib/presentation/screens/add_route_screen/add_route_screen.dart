import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_state.dart';
import 'package:tagmevendor/logic/cubits/add_route_map/add_route_map_state.dart';
import 'package:tagmevendor/logic/cubits/add_route_poly/add_route_poly_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_route_poly/add_route_poly_state.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/route/route_cubit.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:tagmevendor/presentation/screens/add_route_screen/widget/dropdown_tile.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/message_Error_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/message_snackbar.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

import '../../../logic/cubits/add_route_map/add_route_map_cubit.dart';

class AddRouteScreen extends StatefulWidget {
  LatLng currentLocation;
  AddRouteScreen({super.key, required this.currentLocation});
  @override
  State<AddRouteScreen> createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends State<AddRouteScreen> {
  int length = 2;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  ////////////   testing data
  bool isSelected = false;
  GlobalKey<FormState> __addRouteFormKey = new GlobalKey<FormState>();
  final GlobalKey mapKey = GlobalKey();
  final GlobalKey<FormFieldState> _lastDropdownFormkeyTwo =
      GlobalKey<FormFieldState>();

  late StopModel stopData;
  late ScheduleListModel scheduleData;
  List<Data> stopList = [];
  List<Datum> scheduleList = [];
  List<Data> selectStopList = [];
  List<PolyLine> polydata = [];
  int schLength = 0;
  var _selectedSchedule;
  String? selectedScheduleId;

  List<String> selectedStopList = [];
  bool isDropdLoading = true;

  var _selectedItem2;
  List<Map<String, dynamic>> stopMap = [];
  TextEditingController _routeName = TextEditingController();

  Map<String, String> testing = {};

  ///////////////////////////   new
  Map<String, Marker> marker = {};
  Map<PolylineId, Polyline> polylines = {};
  int stopLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    test();
    super.initState();
    setState(() {
      // _center = widget.currentLocation;
      _animateCameraToTarget(widget.currentLocation);
    });
  }

  @override
  void dispose() {
    BlocProvider.of<AddRouteCubit>(context).resetState();
    super.dispose();
    _selectedSchedule = [];
  }

  void test() async {
    stopData = await StopRepository.getStop();
    scheduleData = await ScheduleRepository.getSchedule();
    stopList = stopData.data!;
    scheduleList = scheduleData.data!;
    setState(() {
      isDropdLoading = false;
    });
  }


  Future<void> _animateCameraToTarget(LatLng targetPosition) async {
    if (_controller != null) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: 11),
      ));
    }
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                )),
          ),
          title: Text(
            "New Route",
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: black111011Color)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: BlocBuilder<InternetCubit, bool>(
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
              return Form(
                key: __addRouteFormKey,
                child: Column(
                  children: [
                    CustomTextFeild(
                      hintText: "Enter a nickname",
                      controller: _routeName,
                      validator: (value) {
                        if (value == "") {
                          return "Invalid Nickname";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13.11,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: lightGreyF6F6F6Color),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: lightGreyF6F6F6Color),
                        ),
                        filled: true,
                        fillColor: lightGreyF6F6F6Color,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(left: 13.11),
                          child: DropdownButtonFormField(
                              iconSize: 0,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: greyicon374151Color,
                                    size: 27),
                                // Remove the bottom border
                              ),
                              value: _selectedSchedule,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedSchedule = newValue!;
                                  selectedScheduleId = newValue as String?;
                                });
                              },
                              hint: Text(
                                isDropdLoading ? "Loading" : "Select Schedule",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        color: mediumGrey9CA3AFColor,
                                        // fontSize: widget.fontsize,
                                        fontWeight: normal)),
                              ),
                              items: scheduleList.map((e) {
                                // schLength=schLength+1;
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.scheduleName.toString()),
                                );
                              }).toList()),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AddRouteMapCubit, AddRouteMapState>(
                        listener: (context, state) {
                      if (state is AddRouteMapResponseState) {
                        stopLength = state.selectedStopList.length;
                        selectStopList = state.selectedStopList;
                        BlocProvider.of<AddRouteCubit>(context)
                            .addPolyline(state.selectedStopList);
                      }
                    }, builder: (context, state) {
                      if (state is AddRouteMapResponseState) {
                        // _lastDropdownFormkeyTwo.currentState?.reset();
                        return Container(
                            width: double.infinity,
                            height: 180,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                color: lightGreyF6F6F6Color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.selectedStopList.length,
                                      // itemCount: 3,
                                      itemBuilder: (context, index) {
                                        return DropdownTile(
                                          index: index,
                                          length: state.selectedStopList.length,
                                          stopList: stopList,
                                          selectedValue: state
                                              .selectedStopList[index].id
                                              .toString(),
                                        );
                                      }),
                                  SizedBox(
                                    height: 50,
                                    child: TimelineTile(
                                      isLast: true,
                                      beforeLineStyle: LineStyle(
                                          thickness: 2,
                                          color: greylineCFD5DFColor),
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3),
                                        indicator: GestureDetector(
                                            onTap: () {
                                              print("clicked");
                                            },
                                            child: SvgPicture.asset(
                                                "$svgAssetsBasePath/plus.svg")),
                                      ),
                                      endChild: Row(
                                        children: [
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              height: 45,
                                              child: TextField(
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        // color: mediumGrey9CA3AFColor,
                                                        color: Colors.green,
                                                        fontWeight: normal)),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          9, 9, 9, 9),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color:
                                                            lightGreyF6F6F6Color),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color:
                                                            lightGreyF6F6F6Color),
                                                  ),
                                                  filled: true,
                                                  fillColor: whiteFFFFFFColor,
                                                  hintText: "Add a stop",
                                                  hintStyle: GoogleFonts.openSans(
                                                      textStyle: const TextStyle(
                                                          color:
                                                              mediumGrey9CA3AFColor,
                                                          fontSize: 15)),
                                                  suffixIcon: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 9.69),
                                                      child:
                                                          DropdownButtonFormField(
                                                              key:
                                                                  _lastDropdownFormkeyTwo,
                                                              icon: SvgPicture
                                                                  .asset(
                                                                      "$svgAssetsBasePath/Component 7.svg"),
                                                              decoration:
                                                                  const InputDecoration(
                                                                      border: InputBorder
                                                                          .none, // Remove the bottom border
                                                                      hintText:
                                                                          "Add a stop"),
                                                              value: null,
                                                              // value: "1",
                                                              // value: "654efa33d7eb8bb7c7ec57dd",
                                                              onChanged:
                                                                  (newValue) {
                                                                Data stop = stopList
                                                                    .where((element) =>
                                                                        element
                                                                            .id
                                                                            .toString() ==
                                                                        newValue)
                                                                    .first;
                                                                BlocProvider.of<
                                                                            AddRouteMapCubit>(
                                                                        context)
                                                                    .addStop(
                                                                        stop);
                                                                _lastDropdownFormkeyTwo
                                                                    .currentState
                                                                    ?.reset();
                                                              },
                                                              hint: Text(
                                                                  "Add a stop"),
                                                              items: stopList
                                                                  .map((e) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: e.id
                                                                      .toString(),
                                                                  child: Text(e
                                                                      .location!
                                                                      .locationNickName
                                                                      .toString()),
                                                                );
                                                              }).toList())),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          const SizedBox(width: 20)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }
                      return TextField(
                        decoration: InputDecoration(
                          // labelText: 'DropDown',
                          // border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 5, 0, 5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: lightGreyF6F6F6Color),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 1, color: lightGreyF6F6F6Color),
                          ),
                          filled: true,
                          fillColor: lightGreyF6F6F6Color,

                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 13.11),
                            child: DropdownButtonFormField(
                                iconSize: 0,
                                decoration: const InputDecoration(
                                  // labelText: 'Select an option',
                                  border: InputBorder
                                      .none, // Remove the bottom border
                                  suffixIcon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: greyicon374151Color,
                                      size: 27),
                                ),
                                value: _selectedItem2,
                                onChanged: (newValue) {
                                  // setState(() {
                                  // _selectedItem2 = newValue!;
                                  // selectStopList.add(stopList.where((element) => element.id.toString() == newValue).first);
                                  print("KKKKKKKKKKKKKKKKKKKKKKKKK");
                                  print(newValue);
                                  // isSelected = true;
                                  // selectStopList.add(stopList
                                  //     .where((element) =>
                                  //         element.id.toString() == newValue)
                                  //     .first);
                                  Data stop = stopList
                                      .where((element) =>
                                          element.id.toString() == newValue)
                                      .first;
                                  
                                  BlocProvider.of<AddRouteMapCubit>(context)
                                      .addStop(stop);
                                },
                                // hint: Text("Select Stop"),
                                hint: Text(
                                  isDropdLoading ? "Loading" : "Select Stop",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: mediumGrey9CA3AFColor,
                                          // fontSize: widget.fontsize,
                                          fontWeight: normal)),
                                ),
                                items: stopList.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.location!.locationNickName
                                        .toString()),
                                  );
                                }).toList()),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              BlocListener<AddRouteCubit, AddRouteState>(
                                  listener: (context, state) async {
                                    if (state is AddRouteResponseState) {
                                      polydata.clear();
                                      setState(() {
                                        marker = state.marker;
                                        polylines = state.polylines;
                                        
                                        _animateCameraToTarget(LatLng(
                                            state
                                                .marker["0"]!.position.latitude,
                                            state.marker["0"]!.position
                                                .longitude));
                                        

                                        
                                        print(
                                            state.polyLineResult.points.length);
                                        for (var i = 0;
                                            i <
                                                state.polyLineResult.points
                                                    .length;
                                            i++) {
                                          polydata.add(PolyLine(
                                            latitude: state.polyLineResult
                                                .points[i].latitude,
                                            longitude: state.polyLineResult
                                                .points[i].longitude,
                                          ));
                                        }
                                      });
                                    }
                                  },
                                  child: GoogleMap(
                                    myLocationButtonEnabled: false,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: widget.currentLocation,
                                      zoom: 12.0,
                                    ),
                                    markers: Set<Marker>.of(marker.values),
                                    polylines:
                                        Set<Polyline>.of(polylines.values),
                                    circles: {
                                      Circle(
                                        circleId:
                                            const CircleId("userLocationId"),
                                        center: LatLng(
                                            widget.currentLocation.latitude ??
                                                0.0,
                                            widget.currentLocation.longitude ??
                                                0.0),

                                        // radius: 700,
                                        radius: 40000,
                                        strokeWidth: 0,
                                        // fillColor: greenLightDFFEE7Color,
                                      )
                                    },
                                  )),

                              ////////////////////////////////////        Save Button
                              Positioned(
                                bottom: 25,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 70),
                                  child: BlocBuilder<AddRoutePolyCubit,
                                      AddRoutePolyState>(
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: () async {
                                          if (__addRouteFormKey.currentState!
                                                  .validate() &&
                                              stopLength >= 1 &&
                                              _selectedSchedule.length !=
                                                  null) {
                                            List<String> stops = [];
                                            for (int i = 0;
                                                i < selectStopList.length;
                                                i++) {
                                              stops!.add(selectStopList[i]
                                                  .id
                                                  .toString());
                                            }
                                            print(stops);
                                            AddRouteReqModel req =
                                                AddRouteReqModel(
                                                    routeNickName:
                                                        _routeName.text.trim(),
                                                    // stops: selectedStopList,
                                                    stops: stops,
                                                    schedule: _selectedSchedule,
                                                    polyLine: polydata);

                                            await RouteRepository.addRoute(req)
                                                .then((value) {
                                              if (value.status == true) {
                                                BlocProvider.of<RouteCubit>(
                                                        context)
                                                    .getRoute();
                                                Navigator.pop(context);

                                                showTopSnackBar(
                                                    Overlay.of(context),
                                                    customSuccessSnackBar(
                                                        context,
                                                        "New Route Added"));
                                              }
                                            });
                                          } else if (_selectedSchedule ==
                                              null) {
                                            showTopSnackBar(
                                                Overlay.of(context),
                                                customErrorSnackBar(context,
                                                    "Please Select Schedule"));
                                          } else {
                                            showTopSnackBar(
                                                Overlay.of(context),
                                                customErrorSnackBar(context,
                                                    "Please Select Min One Stop"));
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              //width: 80,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              // constraints: BoxConstraints.loose(),
                                              decoration: BoxDecoration(
                                                  color: redCA1F27Color,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.add,
                                                      color: whiteFFFFFFColor,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      "Add",
                                                      style: GoogleFonts.openSans(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      whiteFFFFFFColor,
                                                                  fontWeight:
                                                                      bold)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            },
          ),
        ));
  }
}
