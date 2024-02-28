import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/map_repository.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_state.dart';
import 'package:tagmevendor/logic/cubits/add_route_poly/add_route_poly_state.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/stop_model.dart';


class AddRoutePolyCubit extends Cubit<AddRoutePolyState> {
  AddRoutePolyCubit():super(AddRoutePolyInitialState());




  void addRoute(AddRouteReqModel req) async {
    try{
      emit(AddRoutePolyLoadingState());
      MessageModel res = await RouteRepository.addRoute(req);
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(AddRoutePolyErrorState(res.message.toString()));
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(AddRoutePolyResponseState(res));
      }
      
    } catch (e){
      emit(AddRoutePolyErrorState(e.toString()));
    }
  }
}