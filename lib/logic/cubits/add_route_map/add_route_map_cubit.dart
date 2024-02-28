import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/add_route_map/add_route_map_state.dart';
import 'package:tagmevendor/logic/cubits/edit_rote_stop/edit_route_stop_state.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';

import '../../../models/stop_model.dart';


class AddRouteMapCubit extends Cubit<AddRouteMapState> {
  AddRouteMapCubit():super(AddRouteMapInitialState());


  List<LatLng> stopsLatLngList =[];  //  selected stops list
  List<String> selectedStopName=[];
  // List<Data> allSStop;
  // int stopsLength = 0;
  
  Schedule? scheduleId;

  List<String> stopList=[];
  List<PolyLine> polydata = [];
  String routeName="";


  //////////////////////////////////////////     
  StopModel? allStop;                               //all stop for drop down stop
  ScheduleListModel? allSchedule;                   //allSchedule for drop down Schedule

  ///////////////////////////////////////    fro add route api
  List<Data> selectedStopList = [];
  

  stops() async {
    allStop = await StopRepository.getStop();
    allSchedule = await ScheduleRepository.getSchedule();
    stopsdata();
  }
  

  stopsdata() async {
    print("response state  call");
    emit(AddRouteMapResponseState(
      selectedStopList
    ));


    print(stopsLatLngList);
  }


  addStop(Data stopData){
    print("add stopcubit func call");
    selectedStopList.add(stopData);
    stopsdata();
  }

  cancleStop(int index){
    selectedStopList.removeAt(index);
    stopsdata();
  }

  updateStop(int index, Data stopData){

    print("updated");
    selectedStopList.removeAt(index);
    selectedStopList.insert(index, stopData);
    stopsdata();
  }


}
