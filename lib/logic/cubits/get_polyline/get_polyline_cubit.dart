import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/map_repository.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_state.dart';
import 'package:tagmevendor/logic/cubits/get_polyline/get_polyline_state.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/stop_model.dart';


class GetPolylineCubit extends Cubit<GetPolylineState> {
  GetPolylineCubit():super(GetPolylineInitialState());

  MapRepository mapRepo = MapRepository();

  void addPolyline(List<Data> data) async {
    MapRepository mapRepo = MapRepository();
    Map<PolylineId, Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
    Map<String, Marker> marker= {};


    PolylineResult result = await mapRepo.addPolyline(data
    );
    for(var i = 0; i<data.length; i++){
      String img = i.toString() + ".png";
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(100.0, 100.0)
        // devicePixelRatio: 2.0
      ),
      'assets/images/pngs/$img',
    );

      marker[i.toString()] = Marker(
      markerId: MarkerId('marker_$i'),
      // icon: markerIcon,
      position: LatLng(
        data[i].location!.coordinates![0],
        data[i].location!.coordinates![1]
      ),
      icon: await customIcon,
      
    );
      print(i.toString());
    }

    try {
      if (result.points.isNotEmpty) {
        print("get polyline point s not empty");
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
        emit(GetPolylineResponseState(polylines, marker, result));
      } else {
        emit(GetPolylineErrorState("No Polyline Found"));
      }
    } catch (e) {
      emit(GetPolylineErrorState(e.toString()));
    }
  }

  void resetState() {
    emit(GetPolylineInitialState());
  }
}