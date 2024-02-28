import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class AddRouteMapState{}

class AddRouteMapInitialState extends AddRouteMapState{}

class AddRouteMapLoadingState extends AddRouteMapState{}

// class AddStopEmptyState extends AddStopState{}

class AddRouteMapResponseState extends AddRouteMapState{
  // StopModel allStop;
  // ScheduleListModel allSchedule;
  // final List<LatLng> stopsLatLngList;
  // final List<String> selectedStop;
  // Schedule? scheduleId;
  // String routeName;
  // // List<String> stopList=[];
  List<Data> selectedStopList = [];  //  new
  AddRouteMapResponseState(
    // this.allStop, 
    // this.allSchedule, 
    // this.stopsLatLngList, 
    // this.selectedStop, 
    // this.scheduleId, 
    // this.routeName, 
    this.selectedStopList
  );
  
}

class AddRouteMapErrorState extends AddRouteMapState{
  final String error;
  AddRouteMapErrorState(this.error);
}