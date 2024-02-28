import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_state.dart';
import 'package:tagmevendor/logic/cubits/route/route_state.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class ProfileTabCubit extends Cubit<ProfileTabState> {
  ProfileTabCubit():super(ProfileTabLoadingState()) {
    // getProfileInfo();
  }

  void getProfileInfo() async {
    try{
      SignupModel res = await AuthRepository.getPersonDetail();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(ProfileTabEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(ProfileTabResponseState(res));
      }
    } catch (e){
      emit(ProfileTabErrorState(e.toString()));
    }
  }

}