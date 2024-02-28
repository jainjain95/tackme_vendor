import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class AddRoutePolyState{}

class AddRoutePolyInitialState extends AddRoutePolyState{}

class AddRoutePolyLoadingState extends AddRoutePolyState{}

// class AddStopEmptyState extends AddStopState{}

class AddRoutePolyResponseState extends AddRoutePolyState{
  MessageModel response;
  AddRoutePolyResponseState(this.response);

}

class AddRoutePolyErrorState extends AddRoutePolyState{
  final String error;
  AddRoutePolyErrorState(this.error);
}