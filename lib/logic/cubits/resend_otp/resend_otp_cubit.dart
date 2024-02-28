import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/resend_otp/resend_otp_state.dart';
import 'package:tagmevendor/models/message_model.dart';


class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit():super(ResendOtpInitialState());

  void getLoginOtp(String mobNo) async {
    try{
      emit(ResendOtpLoadingState());
      print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
      MessageModel res = await AuthRepository.getLoginOtp('+91', mobNo);
      if(res.status == true){
        print(res.message);
        emit(ResendOtpResponseState(res));
      } else {
        print("resend otp cubit call with error");
        emit(ResendOtpErrorState(res.message.toString()));
      }
    } catch (e){
      emit(ResendOtpErrorState(e.toString())); 
    }
  }

}