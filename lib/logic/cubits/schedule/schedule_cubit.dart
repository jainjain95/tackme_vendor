import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_state.dart';
import 'package:tagmevendor/models/delete_update_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit():super(ScheduleLoadingState()) {
    getSchedule();
  }

  void getSchedule() async {
    try{
      emit(ScheduleLoadingState());
      ScheduleListModel res = await ScheduleRepository.getSchedule();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        // emit(ScheduleEmptyState());
        emit(ScheduleResponseState(res));
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(ScheduleResponseState(res));
      }
      
    } catch (e){
      emit(ScheduleErrorState(e.toString()));
    }
  }



  void addSchedule( Datum req ) async {
    try{
      emit(ScheduleLoadingState());
      ScheduleListModel res = await ScheduleRepository.addSchedule(req);
      getSchedule();
      // emit(ScheduleResponseState(res));
    } catch (e){
      emit(ScheduleErrorState(e.toString()));
    }
  }


  void deleteSchedule(String schId) async {
    try{
      emit(ScheduleLoadingState());
      print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
      DAUModel res = await ScheduleRepository.deleteSchedule(schId);
      getSchedule();
    } catch (e){
      emit(ScheduleErrorState(e.toString()));
    }
  }


  void updateSchedule(Datum req) async {
    try{
      emit(ScheduleLoadingState());
      print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
      DAUModel res = await ScheduleRepository.updateSchedule(req);
      getSchedule();
    } catch (e){
      emit(ScheduleErrorState(e.toString()));
    }
  }

}