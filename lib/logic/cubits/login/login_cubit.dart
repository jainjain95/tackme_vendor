import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/login/login_state.dart';
import 'package:tagmevendor/models/message_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit():super(LoginInitialState());

  void getLoginOtp(String mobNo) async {
    try{
      emit(LoginLoadingState());
      MessageModel res = await AuthRepository.getLoginOtp('+91', mobNo);
      if(res.status == true){
        print(res.message);
        emit(LoginResponseState(res));
      } else {
        emit(LoginErrorState(res.message.toString()));
      }
    } catch (e){
      emit(LoginErrorState(e.toString())); 
    }
  }

}