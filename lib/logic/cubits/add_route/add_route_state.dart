import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class AddRouteState{}

class AddRouteInitialState extends AddRouteState{}

class AddRouteLoadingState extends AddRouteState{}

// class AddStopEmptyState extends AddStopState{}

class AddRouteResponseState extends AddRouteState{
  Map<PolylineId, Polyline> polylines = {};
  Map<String, Marker> marker= {};
  PolylineResult polyLineResult;
  AddRouteResponseState(this.polylines, this.marker, this.polyLineResult);
  
}

class AddRouteErrorState extends AddRouteState{
  final String error;
  AddRouteErrorState(this.error);
}