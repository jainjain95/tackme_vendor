import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/get_company_info/get_com_info_state.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_state.dart';
import 'package:tagmevendor/logic/cubits/route/route_state.dart';
import 'package:tagmevendor/models/company_detail_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class GetComInfoCubit extends Cubit<GetComInfoState> {
  GetComInfoCubit():super(GetComInfoLoadingState()) {
    // getCompanyInfo();
  }

  void getCompanyInfo() async {
    emit(GetComInfoLoadingState());
    try{
      CompanyDetailModel res = await AuthRepository.getCompanyDetail();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(GetComInfoEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(GetComInfoResponseState(res));
      }
    } catch (e){
      emit(GetComInfoErrorState(e.toString()));
    }
  }

}