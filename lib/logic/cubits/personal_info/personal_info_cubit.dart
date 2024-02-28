import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/data/repository/stop_repository.dart';
import 'package:tagmevendor/logic/cubits/get_company_info/get_com_info_state.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_state.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_state.dart';
import 'package:tagmevendor/logic/cubits/route/route_state.dart';
import 'package:tagmevendor/models/business_category_model.dart';
import 'package:tagmevendor/models/company_detail_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

class GetPersonalInfoCubit extends Cubit<PersonalInfoState> {
  GetPersonalInfoCubit():super(PersonalInfoLoadingState()) {
    // getPersonalInfo();
  }

  BusinessCategoryModel? category;
  List<ValueItem> categoryList=[];


  void getPersonalInfo() async {
    emit(PersonalInfoLoadingState());
    print("one");
    try{
      category = await AuthRepository.getCategory();
      for(int i=0; i<category!.data!.length; i++){
      categoryList.add(ValueItem(
        label: category!.data![i].name.toString(),
        value: category!.data![i].id.toString()
      ));
    }
      SignupModel res = await AuthRepository.getPersonDetail();
      if(res.status ==  false){
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PersonalInfoEmptyState());
      } else {
        print("<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>");
        emit(PersonalInfoResponseState(res,categoryList));
      }
    } catch (e){
      emit(PersonalInfoErrorState(e.toString()));
    }
  }

}