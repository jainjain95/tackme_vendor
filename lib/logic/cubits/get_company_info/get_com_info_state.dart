import 'package:tagmevendor/models/company_detail_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class GetComInfoState{}

// class VOtpInitialState extends ScheduleState{}

class GetComInfoLoadingState extends GetComInfoState{}

class GetComInfoEmptyState extends GetComInfoState{}

class GetComInfoResponseState extends GetComInfoState{
  final CompanyDetailModel response;
  GetComInfoResponseState(this.response);

}

class GetComInfoErrorState extends GetComInfoState{
  final String error;
  GetComInfoErrorState(this.error);
}