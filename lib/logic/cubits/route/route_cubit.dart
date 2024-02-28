import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/route/route_state.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit():super(RouteLoadingState()) {
    // getRoute();
  }

  void getRoute() async {
    try{
      emit(RouteLoadingState());
      RouteModel res = await RouteRepository.getRoute();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(RouteEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(RouteResponseState(res));
      }
    } catch (e){
      emit(RouteErrorState(e.toString()));
    }
  }



}