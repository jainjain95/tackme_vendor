import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/get_company_info/get_com_info_state.dart';
import 'package:tagmevendor/logic/cubits/new_number/new_number_state.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_state.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_state.dart';
import 'package:tagmevendor/logic/cubits/route/route_state.dart';
import 'package:tagmevendor/models/company_detail_model.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class NewNumberCubit extends Cubit<NewNumberState> {
  NewNumberCubit():super(NewNumberInitialState()) {
   
  }

  void getNewNumberOtp(String number) async {
    emit(NewNumberLoadingState());
    try{
      MessageModel res = await AuthRepository.getNewNumberOtp('+91', number);
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(NewNumberErrorState(res.message.toString()));
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(NewNumberResponseState(res));
      }
    } catch (e){
      emit(NewNumberErrorState(e.toString()));
    }
  }

}