import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class GetPolylineState{}

class GetPolylineInitialState extends GetPolylineState{}

class GetPolylineLoadingState extends GetPolylineState{}

// class AddStopEmptyState extends AddStopState{}

class GetPolylineResponseState extends GetPolylineState{
  Map<PolylineId, Polyline> polylines = {};
  Map<String, Marker> marker= {};
  PolylineResult polyLineResult;
  GetPolylineResponseState(this.polylines, this.marker, this.polyLineResult);
  
}

class GetPolylineErrorState extends GetPolylineState{
  final String error;
  GetPolylineErrorState(this.error);
}