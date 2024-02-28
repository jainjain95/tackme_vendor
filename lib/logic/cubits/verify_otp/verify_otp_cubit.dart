import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/verify_otp/verify_otp_state.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/user_data_model.dart';

class VOtpCubit extends Cubit<VOtpState> {
  VOtpCubit():super(VOtpInitialState());



  void checkOtp(String mobNo, String otp) async {
    emit(VOtpLoadingState());
    try{
      UserDataModel res = await AuthRepository.verifyOtp("+91", mobNo, otp);
      if(res.status == true){
        await Helper.saveUserIdData(res.token.toString());
        
        if(res.data != null){
          await Helper.saveUid(res.data!.sId.toString() ?? "");
        }
        emit(VOtpResponseState(res));
      } 
      else {
        await Helper.saveUserIdData(res.token.toString());
        emit(VOtpErrorState(res.message.toString()));
      }
    } catch (e){
      emit(VOtpErrorState(e.toString()));
    }
  }


  void verifyOtpAndUpdateNumber(String mobNo, String otp) async {
    emit(VOtpLoadingState());
    try{
  
      MessageModel res = await AuthRepository.verifyOtpAndUpdateNumber("+91", mobNo, otp);
      if(res.status == true){
        emit(VOtpAndUpdateNumberResponseState(res));
      } 
      else {
        emit(VOtpErrorState(res.message.toString()));
      }
    } catch (e){
      emit(VOtpErrorState(e.toString()));
    }
  }

}