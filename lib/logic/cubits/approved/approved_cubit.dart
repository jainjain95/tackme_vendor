import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/request_repository.dart';
import 'package:tagmevendor/data/repository/schedule_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/approved/approved_state.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_state.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_state.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_state.dart';
import 'package:tagmevendor/models/approved_req_model.dart';
import 'package:tagmevendor/models/delete_update_model.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class ApprovedCubit extends Cubit<ApprovedState> {
  ApprovedCubit():super(ApprovedLoadingState()) {
    getApprovedRequest();
  }

  void getApprovedRequest() async {
    try{
      emit(ApprovedLoadingState());
      UserRequestModel res = await RequestRepository.getApprovedRequest();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(ApprovedEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(ApprovedResponseState(res));
      }
      
    } catch (e){
      emit(ApprovedErrorState(e.toString()));
    }
  }
}