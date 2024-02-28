import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/map_repository.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_state.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
 

class AddRouteCubit extends Cubit<AddRouteState> {
  AddRouteCubit():super(AddRouteInitialState());

  MapRepository mapRepo = MapRepository();

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

  void addPolyline(List<Data> data) async {
    MapRepository mapRepo = MapRepository();
    Map<PolylineId, Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
    Map<String, Marker> marker= {};
    PolylineResult result = PolylineResult();
    for(var i = 0; i<data.length; i++){
      String img = i.toString() + ".png";
      final Uint8List? markerCustomImage =
            await getBytesFromAssets(img, 90);


      marker[i.toString()] = Marker(
      markerId: MarkerId('marker_$i'),
      position: LatLng(
        data[i].location!.coordinates![1],
        data[i].location!.coordinates![0]
      ),
      // icon: await customIcon,
      icon: BitmapDescriptor.fromBytes(markerCustomImage!),
      
    );
      print(i.toString());
    }
    try {
      result = await mapRepo.addPolyline(data);
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        PolylineId id = PolylineId("poly1");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: polylineCoordinates,
          width: 3,
        );
        polylines[id] = polyline;
        emit(AddRouteResponseState(polylines, marker, result));
      } else {
        print("else vala");
        emit(AddRouteResponseState(
          polylines, 
          marker,
          result
        ));
      }
    } catch (e) {
      print("catch  vala");
      emit(AddRouteResponseState(polylines, marker, result));
    // }
    } 
  }

  void resetState() {
    emit(AddRouteInitialState());
  }
}