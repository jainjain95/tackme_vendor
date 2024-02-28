import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_state.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_cubit.dart';
import 'package:tagmevendor/models/req_model/start_route_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/home_screen/widget/route_tab.dart';
import 'package:tagmevendor/presentation/screens/home_screen/widget/stop_tab.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/end_route_alert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int tabindex = 0;
  late TabController _tabController;
  Map<String, double>? initail_latlng;
  LatLng? currentLocation;
  bool isOngoingRoute = false;
  bool isPermissionOk = false;

  @override
  void initState() {
    // TODO: implement initState
    checkLocationPermissionStatus();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabindex = _tabController.index;
        print('Tab changed: $tabindex');
      });
    });
    BlocProvider.of<StartRouteMapCubit>(context).ongoingRoute();
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print("MMMMMMMMMMMMMMMMMMMMMMMMMMM");
  //   if (state == AppLifecycleState.resumed) {
  //     print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
  //     checkLocationPermissionStatus();
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

  ///////////////////////////////////////////////   to get current location
  getCLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position);
    initail_latlng = {'lat': position.latitude, 'lng': position.longitude};
    // // var position = await _determinePosition();
    // // print(position);
    print("BBBBBBBBBBBBBBBBBBBBBBbb");
    print(position.latitude.toString());
    print(position.longitude.toString());
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  /////////////////////////////////////////////////////       req location permission
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      // Permission granted
      print("Location permission granted");
      // isPermissionOk = true;
      if (await Geolocator.isLocationServiceEnabled()) {
        getCLocation();
        isPermissionOk = true;
      } else {
        getCLocation();
      }
    }
    // else if (status == PermissionStatus.denied) {
    //   // Permission denied
    //   print("Location permission denied");

    // }
    // if (status == PermissionStatus.permanentlyDenied) {
    //   // Permission permanently denied
    //   print("Location permission permanently denied, open settings");
    //   // openAppSettings(); // Opens the app settings page
    //   showDialog(
    //           context: context,
    //           builder: (context){
    //             return AlertDialog(
    //               title: Text("Permission"),
    //               content: Text("Please Allow Location permission to continue"),
    //               actions: [
    //                 ElevatedButton(onPressed: (){
    //                   // checkLocatinPermission();
    //                   Navigator.pop(context);

    //                 }, child: Text("OK")),
    //                 ElevatedButton(onPressed: (){
    //                   // Geolocator.openLocationSettings();
    //                   openAppSettings();
    //                 }, child: Text("Go to Settings"))
    //               ],
    //             );
    //           }
    //         );
    // }
  }

  // Future<void> checkLocationPermission() async {
  //   // var status = await Permission.locationAlways.status;
  //   print("CCCCCCCCCCCCCCCCCCCCCCCCCCCC");

  //   await Permission.locationAlways.status.then((value) async {
  //     if (value == PermissionStatus.granted) {
  //       // Permission granted
  //       print("Location permission is granted");
  //       if (await Geolocator.isLocationServiceEnabled()) {
  //         getCLocation();
  //         isPermissionOk = true;
  //       } else {
  //         getCLocation();
  //       }
  //     } else if (value == PermissionStatus.permanentlyDenied) {
  //       print("PPPPPPPPPPPPPPPPPPPPP   DDDDDDDDDDDDDd");
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Text("Permission"),
  //               content: Text("Please Allow Location permission to continue"),
  //               actions: [
  //                 ElevatedButton(
  //                     onPressed: () {
  //                       // checkLocatinPermission();
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text("OK")),
  //                 ElevatedButton(
  //                     onPressed: () {
  //                       // Geolocator.openLocationSettings();
  //                       openAppSettings();
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text("Go to Settings"))
  //               ],
  //             );
  //           });
  //     } else {
  //       // Permission not granted
  //       print("Location permission is not granted");
  //       // requestLocationPermission();
  //       await Permission.locationAlways.request();
  //     }
  //   });

  //   // if (status == PermissionStatus.granted) {
  //   //   // Permission granted
  //   //   print("Location permission is granted");
  //   //   if(await Geolocator.isLocationServiceEnabled()){
  //   //     getCLocation();
  //   //     isPermissionOk = true;
  //   //   } else {
  //   //     getCLocation();

  //   //   }

  //   // }
  //   // else if(status == PermissionStatus.permanentlyDenied){
  //   //   print("PPPPPPPPPPPPPPPPPPPPP   DDDDDDDDDDDDDd");
  //   //   showDialog(
  //   //           context: context,
  //   //           builder: (context){
  //   //             return AlertDialog(
  //   //               title: Text("Permission"),
  //   //               content: Text("Please Allow Location permission to continue"),
  //   //               actions: [
  //   //                 ElevatedButton(onPressed: (){
  //   //                   // checkLocatinPermission();
  //   //                   Navigator.pop(context);

  //   //                 }, child: Text("OK")),
  //   //                 ElevatedButton(onPressed: (){
  //   //                   // Geolocator.openLocationSettings();
  //   //                   openAppSettings();
  //   //                 }, child: Text("Go to Settings"))
  //   //               ],
  //   //             );
  //   //           }
  //   //         );
  //   // }
  //   // if(status == PermissionStatus.denied)
  //   // else
  //   // {
  //   //   // Permission not granted
  //   //   print("Location permission is not granted");
  //   //   requestLocationPermission();
  //   // }
  // }


  Future<void> requestLocPer() async {
    await Permission.location.request().then((value) async {
      if (value == PermissionStatus.granted) {
      // Permission granted
      print("Location permission granted");
      // isPermissionOk = true;
      if (await Geolocator.isLocationServiceEnabled()) {
        getCLocation();
        isPermissionOk = true;
      } else {
        getCLocation();
      }
    }
    });

  }


  Future<bool> checkLocationPermissionStatus() async {
    var status = await Permission.location.status;
    // await Permission.location.status.then((value) async {
      print("NNNNNNNNNNNNNNNNNNNNN");
      print(status.name.toString());
      if (status == PermissionStatus.granted) {
        // Permission granted
        print("Location permission is granted");
        if (await Geolocator.isLocationServiceEnabled()) {
          print("Location service enable");
          getCLocation();
          // isPermissionOk = true;
          return true;
        } else {
          print("Location service not enable");
          getCLocation();
          return true;
        }
      } else if (status == PermissionStatus.permanentlyDenied) {
        print("PPPPPPPPPPPPPPPPPPPPP   DDDDDDDDDDDDDd");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Permission"),
                content: Text("Please Allow Location permission to continue"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        // checkLocatinPermission();
                        Navigator.pop(context);
                      },
                      child: Text("OK")),
                  ElevatedButton(
                      onPressed: () {
                        // Geolocator.openLocationSettings();
                        openAppSettings();
                      },
                      child: Text("Go to Settings"))
                ],
              );
            });
        return false;
      } else if(status == PermissionStatus.limited){
        // Permission not granted
        print("Location permission is not granted limited");
        // requestLocationPermission();
        // await Permission.location.request();
        // requestLocPer();
        return false;
      }
      else {
        // Permission not granted
        print("Location permission is not granted");
        // requestLocationPermission();
        // await Permission.location.request();
        // requestLocPer();
        return false;
      }
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Stops",
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: darkBlack000000Color, fontWeight: bold)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                onTap: () async {

                  checkLocationPermissionStatus().then((value) async {
                    print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
                    print(value);
                    if (value) {
                      print("HHHHHHHHHHHHHHHHHHHHHH");
                      tabindex == 0
                  ? AppRouter.navigatorKey.currentState?.pushNamed(
                      AppRouter.addStopsScreen,
                      arguments: currentLocation)
                  : AppRouter.navigatorKey.currentState?.pushNamed(
                      AppRouter.addRouteScreen,
                      arguments: currentLocation);
                    } 
                    // else {
                    //   print("EEEEEEEEEEEEEEEEEEEEE");
                    //   // print(value.)
                    //   // requestLocationPermission();
                    //   // requestLocPer();
                    // }

                  });
                },
                child:
                    const Icon(Icons.add_rounded, color: greyicon374151Color),
              ),
            )
          ],
        ),
        floatingActionButton:
            BlocConsumer<StartRouteMapCubit, StartRouteMapState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is StartRouteMapResponseState) {
              return Theme(
                data: Theme.of(context).copyWith(
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        extendedSizeConstraints:
                            BoxConstraints.loose(Size(width - 40, 80)))),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    AppRouter.navigatorKey.currentState?.pushNamed(
                        AppRouter.routeOnMapScreen,
                        arguments: StartRouteReqModel(RData(), true));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  label: Container(
                      height: 80,
                      width: width - 34,
                      padding: EdgeInsets.only(
                          left: 22, right: 20, bottom: 16, top: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: lightRedFFE3E4Color.withOpacity(0.3),
                                offset: Offset(0, 0),
                                spreadRadius: 1.5,
                                blurRadius: 2),
                          ],
                          border: Border.all(color: lightRedFFE3E4Color),
                          borderRadius: BorderRadius.circular(15)),
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.startRouteData.route!.routeName!
                                      .routeNickName
                                      .toString(),
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: redCA1F27Color,
                                          fontWeight: bold,
                                          fontSize: 16)),
                                ),
                                Text(
                                  // state.startRouteData.route!.startingLocation!.startAddress.toString(),
                                  state.currentStop,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          color: grey374151Color,
                                          fontWeight: semiBold,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              // BlocProvider.of<StartRouteMapCubit>(context).endOngoingRoute(state.startRouteData.route!.id.toString());
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EndRouteAlertDialog(
                                        onGoingRouteid: state
                                            .startRouteData.route!.id
                                            .toString());
                                  });
                            },
                            child: Container(
                                height: 48,
                                // width: 80,
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: redCA1F27Color),
                                child: Center(
                                  child: Text(
                                    // state.startRouteData.route!.startingLocation!.startAddress.toString(),
                                    "End Route",
                                    maxLines: 1,

                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                            color: whiteFFFFFFColor,
                                            fontWeight: bold,
                                            fontSize: 16)),
                                  ),
                                )),
                          )
                        ],
                      )),
                ),
              );
            }
            return SizedBox();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: lightGreyF6F6F6Color,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TabBar(
                  controller: _tabController,
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
                      text: 'Stops',
                    ),
                    Tab(
                      text: 'Routes',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [StopTab(), RouteTab()],
              )),
              BlocBuilder<StartRouteMapCubit, StartRouteMapState>(
                  builder: (context, state) {
                if (state is StartRouteMapResponseState) {
                  if (state.startRouteData.route != null) {
                    return const SizedBox(height: 100);
                  }
                }
                return const SizedBox();
              })
            ],
          ),
        ),
      ),
    );
  }
}
