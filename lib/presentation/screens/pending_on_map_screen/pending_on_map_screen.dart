import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/pending_on_map_screen/widget/request_bottom_sheet.dart';

class PendingOnMapScreen extends StatefulWidget {
  DataR reqData;
  PendingOnMapScreen({super.key, required this.reqData});

  @override
  State<PendingOnMapScreen> createState() => _PendingOnMapScreenState();
}

class _PendingOnMapScreenState extends State<PendingOnMapScreen> {


  LatLng _center = LatLng(28.984463, 77.706413);
  final Map<String, Marker> marker= {};
  GoogleMapController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: RequsetBottomSheet(reqData: widget.reqData,),
                                    );
                                  },
                                );
    });
    createMarker();
    super.initState();
  }

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
          widget.reqData.customer!.name ?? "",
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  fontSize: 20, fontWeight: semiBold, color: black111011Color)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            setState(() {
                              _controller = controller;
      
                            });
                          },
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 12.0,
                          ),
                          markers: marker.values.toSet(),
                        ),
              )
            )
          ],
        ),
      ),
    );
  }

  //  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  // }

  createMarker() async {
    
    
    try {
      print("**********************\n***********************");
    print("marker maker func call");
    
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "$svgAssetsBasePath/marker.svg",
    );
    marker["0"] = Marker(
      markerId: MarkerId('marker_first'),
      icon: markerIcon,
      position: LatLng(28.984463, 77.706413)
    );
    marker["1"] = Marker(
      markerId: MarkerId('marker_second'),
      icon: markerIcon,
      position: LatLng(28.983463, 77.716413)
    );
    } catch (e){
      print("MMMMMMMMMMMMMMMMMMMMMMMMMMM");
      print(e.toString());
    }
    setState(() {
      
    });
  }
}