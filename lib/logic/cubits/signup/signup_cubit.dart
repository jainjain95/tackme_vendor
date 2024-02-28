import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_state.dart';
import 'package:tagmevendor/models/req_model/sign_up_req_model.dart';
import 'package:tagmevendor/models/signup_model.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit():super(SignupInitialState());

  void signup(SignupReqModel req) async {
    try{
      emit(SignupLoadingState());
      print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
      SignupModel res = await AuthRepository.signUp(req);
      if(res.status == true){
        await Helper.saveUid(res.data!.sId.toString());
        await Helper.saveStatus('SU');
        emit(SignupResponseState(res));
      } else {
        emit(SignupErrorState(res.message.toString()));
      }
    } catch (e){
      emit(SignupErrorState(e.toString()));
    }
  }
}