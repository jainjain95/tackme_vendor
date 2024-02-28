import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/data/repository/map_repository.dart';
import 'package:tagmevendor/logic/cubits/route_info/routr_info_state.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_state.dart';
import 'package:tagmevendor/models/req_model/sign_up_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';

class RouteInfoCubit extends Cubit<RouteInfoState> {
  RouteInfoCubit() : super(RouteInfoLoadingState());


  void getPolyline(RData rDtata) async {
    // emit(RouteInfoLoadingState());
    MapRepository mapRepo = MapRepository();
    Map<PolylineId, Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await mapRepo.getPolyline(
      rDtata
    );
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
        // emit(RouteInfoResponseState(polylines));
      } else {
        emit(RouteInfoErrorState("No Polyline Found"));
      }
    } catch (e) {
      emit(RouteInfoErrorState(e.toString()));
    }
  }

}
