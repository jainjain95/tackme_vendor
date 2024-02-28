import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/route_model.dart';

abstract class RouteInfoState {}

class RouteInfoInitialState extends  RouteInfoState{}

class RouteInfoLoadingState extends  RouteInfoState{}

class RouteInfoResponseState extends  RouteInfoState{
  // Map<PolylineId, Polyline> polylines = {};
  RouteModel routeInfo;
  RouteInfoResponseState(this.routeInfo);
}

class RouteInfoErrorState extends  RouteInfoState{
  String error;
  RouteInfoErrorState( this.error);
}