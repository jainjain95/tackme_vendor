import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/edit_rote_stop/edit_route_stop_state.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';

import '../../../models/stop_model.dart';


class EditRouteStopCubit extends Cubit<EditRouteStopState> {
  EditRouteStopCubit():super(EditRouteStopInitialState());

 
  List<LatLng> stopsLatLngList =[];  //  selected stops list
  List<String> selectedStopName=[];
  // List<Data> allSStop;
  int stopsLength = 0;
  StopModel? allStop;                    //all stop for drop down stop
  ScheduleListModel? allSchedule;        //allSchedule for drop down Schedule
  Schedule? scheduleId;

  List<String> stopList=[];
  List<PolyLine> polydata = [];
  String routeName="";

  stops(RData routeData) async {
    allStop = await StopRepository.getStop();
    allSchedule = await ScheduleRepository.getSchedule();
    stopsLength = routeData.stops!.length;
    for(int i =0 ; i< routeData.stops!.length; i++){
      stopsLatLngList.add(
        LatLng(
          routeData.stops![i].location!.coordinates![1],
          routeData.stops![i].location!.coordinates![0],
        )
      );
      selectedStopName.add(
        routeData.stops![i].sid.toString()
      );
      stopList.add(routeData.stops![i].sid.toString());
    }
    scheduleId = routeData.schedule;
    routeName = routeData.routeNickName.toString();
    stopsdata();
  }
  

  stopsdata() async {
    
    emit(EditRouteStopResponseState(
      allStop!,
      allSchedule!,
      stopsLatLngList,
      selectedStopName,
      stopsLength,
      scheduleId,
      routeName,
      stopList
    ));


    print(stopsLatLngList);
  }


  addStop(LatLng stopValue, String selectedValue, String stopId){
    stopsLatLngList.add(stopValue);
    selectedStopName.add(selectedValue);
    stopList.add(stopId);
    stopsdata();
  }

  cancleStop(int index){
    selectedStopName.removeAt(index);
    stopsLatLngList.removeAt(index);
    stopList.removeAt(index);
    stopsdata();
  }

  updateStop(int index, LatLng stopValue, String selectedValue, String stopId){

    print("updated");
    selectedStopName.removeAt(index);
    selectedStopName.insert(index, selectedValue);
    print("updated");
    stopsLatLngList.removeAt(index);
    stopsLatLngList.insert(index, stopValue);
    print("updated");
    stopList.removeAt(index);
    stopList.insert(index, stopId);
    stopsdata();
  }


  updateSchedule(Schedule scheduleId){
    scheduleId = scheduleId;
    stopsdata();
  }

  update(){
    stopsdata();
  }


}
