import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class EditRouteMapState{}

class EditRouteMapInitialState extends EditRouteMapState{}

class EditRouteMapLoadingState extends EditRouteMapState{}

// class AddStopEmptyState extends AddStopState{}

class EditRouteMapResponseState extends EditRouteMapState{
  Map<PolylineId, Polyline> polylines = {};
  Map<String, Marker> marker= {};
  PolylineResult polyLineResult;
  List<PolyLine> polydata = [];
  EditRouteMapResponseState(this.polylines, this.marker, this.polyLineResult, this.polydata);
  
}

class EditRouteMapErrorState extends EditRouteMapState{
  final String error;
  EditRouteMapErrorState(this.error);
}