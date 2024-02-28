import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/add_com_info/add_com_info_state.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_state.dart';
import 'package:tagmevendor/models/company_info_model.dart';
import 'package:tagmevendor/models/req_model/com_info_req_model.dart';
import 'package:tagmevendor/models/req_model/sign_up_req_model.dart';
import 'package:tagmevendor/models/signup_model.dart';

class AddComInfoCubit extends Cubit<AddComInfoState> {
  AddComInfoCubit():super(AddComInfoInitialState());

  void addInfo(ComInfoReqModel req) async {
    try{
      emit(AddComInfoLoadingState());
      CompanyInfoModel res = await AuthRepository.addCompanyDetail(req);
      if(res.status == true){
        await Helper.saveUid(res.data!.sId.toString());
        await Helper.saveStatus('SU');
        emit(AddComInfoResponseState(res));
      } else {
        emit(AddComInfoErrorState(res.message.toString()));
      }
    } catch (e){
      emit(AddComInfoErrorState(e.toString()));
    }
  }
}