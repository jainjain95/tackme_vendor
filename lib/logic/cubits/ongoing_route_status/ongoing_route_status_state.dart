import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class OngoingRouteStatusState{}

class OngoingRouteStatusInitialState extends OngoingRouteStatusState{}

class OngoingRouteStatusLoadingState extends OngoingRouteStatusState{}

// class AddStopEmptyState extends AddStopState{}

class OngoingRouteStatusResponseState extends OngoingRouteStatusState{
  MessageModel response;
  OngoingRouteStatusResponseState(this.response);

}

class OngoingRouteStatusErrorState extends OngoingRouteStatusState{
  final String error;
  OngoingRouteStatusErrorState(this.error);
}