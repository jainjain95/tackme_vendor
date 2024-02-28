import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/map_repository.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_state.dart';
import 'package:tagmevendor/logic/cubits/edit_route_map/edit_rout_map_state.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/stop_model.dart';


class EditRouteMapCubit extends Cubit<EditRouteMapState> {
  EditRouteMapCubit():super(EditRouteMapInitialState());

  MapRepository mapRepo = MapRepository();

  String? name;

  void getPolyline(List<LatLng> data) async {

    MapRepository mapRepo = MapRepository();
    Map<PolylineId, Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
    List<Marker> markers = [];
    Map<String, Marker> marker= {};
    List<PolyLine> polydata = [];
    PolylineResult result = PolylineResult();

    // PolylineResult result = await mapRepo.getPolylineWithPloList(data);
    for(var i = 0; i<data.length; i++){
      String img = i.toString() + ".png";
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        // size: Size(60.0, 60.0)
        // devicePixelRatio: 2.0
      ),
      'assets/images/pngs/$img',
    );

      marker[i.toString()] = Marker(
      markerId: MarkerId('marker_$i'),
      // icon: markerIcon,
      position: LatLng(
        data[i].latitude,
        data[i].longitude
      ),
      icon: await customIcon,
    );
      print(i.toString());
    }
    try{
      result = await mapRepo.getPolylineWithPloList(data);
      print("invalid value");
    // } catch (e) {
      // print("invalid value");
    // }

    // try {
      if (result.points.isNotEmpty) {
        print("get polyline point s not empty");
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          polydata.add(PolyLine(latitude: point.latitude,longitude: point.longitude));
        });
        PolylineId id = PolylineId("poly1");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: polylineCoordinates,
          width: 3,
        );
        polylines[id] = polyline;
        emit(EditRouteMapResponseState(polylines, marker, result, polydata));
      } else {
        // emit(EditRouteMapErrorState("No Polyline Found"));
        emit(EditRouteMapResponseState(polylines, marker, result, polydata));
      }
    } catch (e) {
      // emit(EditRouteMapErrorState(e.toString()));
      emit(EditRouteMapResponseState(polylines, marker, result, polydata));
    }
  }



  void resetState() {
    emit(EditRouteMapInitialState());
  }
}