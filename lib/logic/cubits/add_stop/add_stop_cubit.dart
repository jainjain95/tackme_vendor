import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/add_stop/add_stop_state.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/add_stop_req_model.dart';

class AddStopCubit extends Cubit<AddStopState> {
  AddStopCubit():super(AddStopInitialState());

  void addStop(AddStopReqModel req) async {
    try{
      emit(AddStopLoadingState());
      MessageModel res = await StopRepository.addStop(req);
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(AddStopErrorState(res.message.toString()));
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(AddStopResponseState(res));
      }
      
    } catch (e){
      emit(AddStopErrorState(e.toString()));
    }
  }
}