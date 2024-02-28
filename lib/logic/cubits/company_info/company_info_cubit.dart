import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/company_info/comapny_info_state.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_state.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/sign_up_req_model.dart';
import 'package:tagmevendor/models/req_model/update_all_user_data_model.dart';
import 'package:tagmevendor/models/signup_model.dart';

class ComapnyInfoCubit extends Cubit<CompanyInfoState> {
  ComapnyInfoCubit():super(CompanyInfoInitialState());

  void updateCompInfo(UpdateAllUserDataReqModel req, String imagePath) async {
    try{
      emit(CompanyInfoLoadingState());
      MessageModel res = await AuthRepository.updateAllUserData(req, imagePath);
      if(res.status == true){
        emit(CompanyInfoResponseState(res));
      } else {
        emit(CompanyInfoErrorState(res.message.toString()));
      }
      
    } catch (e){
      emit(CompanyInfoErrorState(e.toString()));
    }
  }

}