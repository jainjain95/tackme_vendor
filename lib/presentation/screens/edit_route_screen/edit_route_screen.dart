import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/logic/cubits/edit_rote_stop/edit_rote_stop_cubit.dart';
import 'package:tagmevendor/logic/cubits/edit_rote_stop/edit_route_stop_state.dart';
import 'package:tagmevendor/logic/cubits/edit_route_map/edit_rout_map_state.dart';
import 'package:tagmevendor/logic/cubits/edit_route_map/edit_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/route/route_cubit.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/presentation/screens/edit_route_screen/widget/stop_dropdown_tile.dart';
import 'package:tagmevendor/presentation/screens/home_screen/home_screen.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import '../../../models/stop_model.dart';

class EditRouteScreen extends StatefulWidget {
  final RData routeData;
  const EditRouteScreen({super.key, required this.routeData});

  @override
  State<EditRouteScreen> createState() => _EditRouteScreenState();
}

class _EditRouteScreenState extends State<EditRouteScreen> {

  LatLng _center = LatLng(28.984463, 77.706413);

  ////////////////////////////////////////////    new
  // String? selectedValue;
  List<String> stopIdList = []; // for update api call
  // List<PolyLine> polydata = [];
  AddRouteReqModel? reqData;
  String? selectedScheduleId;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final GlobalKey<FormFieldState> _lastDropdownFormkey =
      GlobalKey<FormFieldState>();

  @override
  void initState() {
    // TODO: implement initState
    // test();
    super.initState();
    selectedScheduleId = widget.routeData.schedule!.id.toString();
    BlocProvider.of<EditRouteStopCubit>(context).stops(widget.routeData);
    // _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //     target: LatLng(widget.routeData.stops![0].location!.coordinates![0],
    //         widget.routeData.stops![0].location!.coordinates![1]),
    //     zoom: 12)));
  }

  Future<void> _animateCameraToTarget(LatLng targetPosition) async {
    if (_controller != null) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: 12),
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
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: greyicon374151Color)),
          ),
          title: Text(
            widget.routeData.routeNickName.toString(),
            // "route name",
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
                    // print(reqData!.schedule.toString());
                    RouteRepository.updateRoute(reqData!).then((value) {
                      BlocProvider.of<RouteCubit>(context).getRoute();
                      showTopSnackBar(
                                        Overlay.of(context),
                                        customSuccessSnackBar(
                                            context, "Route Updated Successfully"));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                  child: Icon(
                    Icons.check_rounded,
                    color: greyicon374151Color,
                  )),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: BlocBuilder<InternetCubit, bool>(builder: (context, state) {
              if (state == false) {
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
                  BlocBuilder<EditRouteStopCubit, EditRouteStopState>(
                    builder: (context, state) {
                      if (state is EditRouteStopResponseState) {
                        return SizedBox(
                          height: 48,
                          child: TextField(
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    // color: mediumGrey9CA3AFColor,
                                    color: Colors.green,
                                    fontWeight: normal)),
                            decoration: InputDecoration(
                              // labelText: 'DropDown',
                              // border: OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(9, 9, 9, 9),
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
                              hintText: "testing",
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color: mediumGrey9CA3AFColor,
                                      fontSize: 15)),

                              suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        // labelText: 'Select an option',
                                        border: InputBorder
                                            .none, // Remove the bottom border
                                      ),
                                      value: selectedScheduleId,
                                      // value: "654efa33d7eb8bb7c7ec57dd",
                                      onChanged: (newValue) {
                                        // Data stop = state.allStop.data!
                                        //     .where((element) =>
                                        //         element.id.toString() ==
                                        //         newValue)
                                        //     .first;
                                        print(
                                            "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
                                        print(newValue);
                                        selectedScheduleId = newValue;
                                        BlocProvider.of<EditRouteStopCubit>(
                                                context)
                                            .update();
                                      },
                                      hint: Text("Select Schedule"),
                                      items: state.allSchedule.data!.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.id.toString(),
                                          // value: "abc",
                                          child:
                                              Text(e.scheduleName.toString()),
                                        );
                                      }).toList())),
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 48,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: lightGreyF6F6F6Color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      height: 180,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: lightGreyF6F6F6Color,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:
                          BlocConsumer<EditRouteStopCubit, EditRouteStopState>(
                        listener: (context, state) {
                          if (state is EditRouteStopResponseState) {
                            print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
                            print(state.stopList);
                            stopIdList = state.selectedStop;
                            BlocProvider.of<EditRouteMapCubit>(context)
                                .getPolyline(state.stopsLatLngList);
                            // AddRouteReqModel req = AddRouteReqModel(
                            //   routeNickName: state.routeName,
                            //               // stops: selectedStopList,
                            //               stops: state.selectedStop,
                            //               schedule: state.scheduleId!.id.toString(),
                            //               polyLine: polydata
                            //   );
                          }
                        },
                        builder: (context, state) {
                          if (state is EditRouteStopInitialState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: redCA1F27Color,
                              ),
                            );
                          }
                          if (state is EditRouteStopResponseState) {
                            _lastDropdownFormkey.currentState?.reset();
                            return SingleChildScrollView(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.stopsLatLngList.length,
                                      itemBuilder: (context, index) {
                                        return StopDropdownTile(
                                            index: index,
                                            length:
                                                state.stopsLatLngList.length,
                                            // length: state.stopsLength,
                                            stopList: state.allStop.data,
                                            selectedValue:
                                                state.selectedStop[index]
                                            // stopsLength:
                                            //     state.stopsLatLngList.length
                                            );
                                      }),
                                  // Container(height: 50, width: 50, color: Colors.green),
                                  SizedBox(
                                    height: 50,
                                    child: TimelineTile(
                                      isFirst: state.stopsLatLngList.length == 0
                                          ? true
                                          : false,
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
                                              // length = widget.length + 1;
                                              // setState(() {});
                                              // BlocProvider.of<EditRouteStopCubit>(context).addStop();
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
                                                                  _lastDropdownFormkey,
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
                                                                Data stop = state
                                                                    .allStop
                                                                    .data!
                                                                    .where((element) =>
                                                                        element
                                                                            .id
                                                                            .toString() ==
                                                                        newValue)
                                                                    .first;
                                                                BlocProvider.of<EditRouteStopCubit>(context).addStop(
                                                                    LatLng(
                                                                        stop.location!.coordinates![
                                                                            1],
                                                                        stop.location!.coordinates![
                                                                            0]),
                                                                    newValue!,
                                                                    stop.id
                                                                        .toString());
                                                                print(
                                                                    "????????????????????????????");
                                                                print('add');
                                                              },
                                                              hint: Text(
                                                                  "Add a stop"),
                                                              items: state
                                                                  .allStop.data!
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
                            );
                          }
                          return Text("empty state");
                        },
                      )),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: [
                            BlocConsumer<EditRouteMapCubit, EditRouteMapState>(
                              listener: (context, state) {
                                if (state is EditRouteMapResponseState) {
                                  print(
                                      "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                                  print(selectedScheduleId);
                                  reqData = AddRouteReqModel(
                                      routeNickName:
                                          widget.routeData.routeNickName,
                                      stops: stopIdList,
                                      schedule: selectedScheduleId,
                                      polyLine: state.polydata,
                                      routeId: widget.routeData.id);
                                  setState(() {
                                    _animateCameraToTarget(LatLng(
                                        // state.polyLineResult.points.first.latitude,
                                        // state.polyLineResult.points.first.longitude
                                        state.marker["0"]!.position.latitude,
                                        state.marker["0"]!.position.longitude));
                                  });
                                }
                              },
                              builder: (context, state) {
                                if (state is EditRouteMapLoadingState) {
                                  return CircularProgressIndicator();
                                }
                                if (state is EditRouteMapResponseState) {
                                  return GoogleMap(
                                    myLocationButtonEnabled: false,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          widget.routeData.stops![0].location!
                                              .coordinates![1],
                                          widget.routeData.stops![0].location!
                                              .coordinates![0]),
                                      zoom: 12.0,
                                    ),
                                    polylines: Set<Polyline>.of(
                                        state.polylines.values),
                                    markers:
                                        Set<Marker>.of(state.marker.values),
                                  );
                                }
                                if (state is EditRouteMapErrorState) {
                                  return Center(
                                      child: Text(state.error.toString()));
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              );
            })));
  }
}
