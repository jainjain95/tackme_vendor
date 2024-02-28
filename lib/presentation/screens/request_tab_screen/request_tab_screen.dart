import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/request_tab_screen/widget/approved_subtab.dart';
import 'package:tagmevendor/presentation/screens/request_tab_screen/widget/pending_subtab.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';

class RequestTabScreen extends StatefulWidget {
  const RequestTabScreen({super.key});

  @override
  State<RequestTabScreen> createState() => _RequestTabScreenState();
}


  

class _RequestTabScreenState extends State<RequestTabScreen> with SingleTickerProviderStateMixin{

  int tabindex = 0;
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      // Add your calculation or actions here based on the selected tab index
      
      
      // Perform your calculations or actions based on the tab change
      // For example, you can call a function or update a variable
      setState(() {
      tabindex = _tabController.index;
      print('Tab changed: $tabindex');
    });
    });
    
  }
    void method() async {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
    // var position = await _determinePosition();
    // print(position);
  }

  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Requests",
            style: GoogleFonts.openSans(
                textStyle:
                    const TextStyle(color: darkBlack000000Color, fontWeight: bold)),
          )
        ),
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
                      text: 'Approved',
                    ),
                    Tab(
                      text: 'Pending',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: TabBarView(
                    controller: _tabController,
                children: const  [
                  ApprovedSubTab(),
                  PendingSubtab()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
