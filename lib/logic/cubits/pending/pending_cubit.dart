import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/request_repository.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_state.dart';
import 'package:tagmevendor/models/user_request_model.dart';


class PendingCubit extends Cubit<PendingState> {
  PendingCubit():super(PendingLoadingState()) {
    getPendingRequest();
  }

  void getPendingRequest() async {
    try{
      emit(PendingLoadingState());
      UserRequestModel res = await RequestRepository.getPendingRequest();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PendingEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PendingResponseState(res));
      }
      
    } catch (e){
      emit(PendingErrorState(e.toString()));
    }
  }


}