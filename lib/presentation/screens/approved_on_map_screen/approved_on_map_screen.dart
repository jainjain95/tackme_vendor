import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class ApprovedOnMapScreen extends StatefulWidget {
  DataR data;
  ApprovedOnMapScreen({super.key, required this.data});

  @override
  State<ApprovedOnMapScreen> createState() => _ApprovedOnMapScreenState();
}

class _ApprovedOnMapScreenState extends State<ApprovedOnMapScreen> {
  // LatLng _center = LatLng(28.984463, 77.706413);

  GoogleMapController? _controller;
  LatLng? location;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteFFFFFFColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
                color: greyicon374151Color
            )),
        title: Text(
          widget.data.customer!.name.toString(),
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  fontSize: 20, fontWeight: semiBold, color: black111011Color)),
        ),
        actions: [
          
          GestureDetector(
            
            onTap: (){
              AppRouter.navigatorKey.currentState
                                    ?.pushNamed(AppRouter.addStopsScreen, arguments: LatLng(
                              widget.data.customer!.location!.coordinates![0], 
                              widget.data.customer!.location!.coordinates![1], 
                            ));
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
              "Add Stop",
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: semiBold, color: redCA1F27Color)),
                    ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                          onMapCreated: (GoogleMapController controller) {
                            setState(() {
                              _controller = controller;
      
                            });
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              widget.data.customer!.location!.coordinates![0], 
                              widget.data.customer!.location!.coordinates![1], 
                            ),
                            zoom: 12.0,
                          ),
                        ),
              )
            )
          ],
        ),
      ),
    );
  }
}