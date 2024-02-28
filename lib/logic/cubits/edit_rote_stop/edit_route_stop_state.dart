import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class EditRouteStopState{}

class EditRouteStopInitialState extends EditRouteStopState{}

class EditRouteStopLoadingState extends EditRouteStopState{}

// class AddStopEmptyState extends AddStopState{}

class EditRouteStopResponseState extends EditRouteStopState{
  StopModel allStop;
  ScheduleListModel allSchedule;
  final List<LatLng> stopsLatLngList;
  final List<String> selectedStop;
  int stopsLength;
  Schedule? scheduleId;
  String routeName;
  List<String> stopList=[];
  EditRouteStopResponseState(this.allStop, this.allSchedule, this.stopsLatLngList, this.selectedStop, this.stopsLength, this.scheduleId, this.routeName, stopList);
  
}

class EditRouteStopErrorState extends EditRouteStopState{
  final String error;
  EditRouteStopErrorState(this.error);
}