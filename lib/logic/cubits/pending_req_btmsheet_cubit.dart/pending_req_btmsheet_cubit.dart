import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/request_repository.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_state.dart';
import 'package:tagmevendor/logic/cubits/pending_req_btmsheet_cubit.dart/pending_req_btmsheet_state.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/user_request_model.dart';


class PendingReqBtmSheetCubit extends Cubit<PendingReqBtmSheetState> {
  PendingReqBtmSheetCubit():super(PendingReqBtmSheetInitialState()) {

  }

  void updateRequestStatus(String reqStatus, String reqId) async {
    try{
      emit(PendingReqBtmSheetLoadingState());
      MessageModel res = await RequestRepository.updateRequestStatus(reqStatus, reqId);
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PendingReqBtmSheetErrorState(res.message.toString()));
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PendingReqBtmSheetResponseState(res));
      }
      
    } catch (e){
      emit(PendingReqBtmSheetErrorState(e.toString()));
    }
  }

  void rejectRequest(String reqId) async {
    try{
      emit(PendingReqBtmSheetLoadingState());
      MessageModel res = await RequestRepository.rejectRequest(reqId);
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PendingReqBtmSheetErrorState(res.message.toString()));
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PendingReqBtmSheetResponseState(res));
      }
      
    } catch (e){
      emit(PendingReqBtmSheetErrorState(e.toString()));
    }
  }


}