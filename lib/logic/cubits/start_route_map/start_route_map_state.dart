import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/start_route_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class StartRouteMapState{}

class StartRouteMapInitialState extends StartRouteMapState{}

class StartRouteMapLoadingState extends StartRouteMapState{}

// class StartStopEMapmptyState extends StartStopSMaptate{}

class StartRouteMapResponseState extends StartRouteMapState{
  Map<PolylineId, Polyline> polylines = {};
  Map<String, Marker> marker = {};
  StartRouteModel startRouteData;
  List<LatLng> points = [];
  String currentStop;
  int cindex=0;
  StartRouteMapResponseState(this.polylines, this.marker, this.startRouteData, this.points, this.currentStop, this.cindex);
  
}

class StartRouteMapErrorState extends StartRouteMapState{
  final String error;
  StartRouteMapErrorState(this.error);
}