import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_state.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_state.dart';
import 'package:tagmevendor/logic/cubits/update_all_user_data/update_all_data_state.dart';
import 'package:tagmevendor/models/delete_update_model.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/update_all_user_data_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class UpdateAllDataCubit extends Cubit<UpdateAllDataState> {
  UpdateAllDataCubit():super(UpdateAllDataInitialState()) {
  }

  void updateAllUserData(UpdateAllUserDataReqModel req) async {
    try{
      emit(UpdateAllDataLoadingState());
      MessageModel res = await AuthRepository.updateAllUserData(req, "");
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(UpdateAllDataEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(UpdateAllDataResponseState(res));
      }
      
    } catch (e){
      emit(UpdateAllDataErrorState(e.toString()));
    }
  }

}