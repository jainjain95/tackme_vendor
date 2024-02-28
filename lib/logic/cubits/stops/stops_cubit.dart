import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_state.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_state.dart';
import 'package:tagmevendor/models/delete_update_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class StopCubit extends Cubit<StopState> {
  StopCubit():super(StopLoadingState()) {
    // getStop();
  }

  void getStop() async {
    try{
      emit(StopLoadingState());
      StopModel res = await StopRepository.getStop();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(StopEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(StopResponseState(res));
      }
      
    } catch (e){
      emit(StopErrorState(e.toString()));
    }
  }

}