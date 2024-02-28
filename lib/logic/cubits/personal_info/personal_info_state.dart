import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:tagmevendor/models/company_detail_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class PersonalInfoState{}

// class VOtpInitialState extends ScheduleState{}

class PersonalInfoLoadingState extends PersonalInfoState{}

class PersonalInfoEmptyState extends PersonalInfoState{}

class PersonalInfoResponseState extends PersonalInfoState{
  final SignupModel response;
  List<ValueItem> categoryList=[];
  PersonalInfoResponseState(this.response, this.categoryList);

}

class PersonalInfoErrorState extends PersonalInfoState{
  final String error;
  PersonalInfoErrorState(this.error);
}