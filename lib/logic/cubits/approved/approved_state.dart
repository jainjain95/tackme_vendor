import 'package:tagmevendor/models/approved_req_model.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class ApprovedState{}

// class VOtpInitialState extends ScheduleState{}

class ApprovedLoadingState extends ApprovedState{}

class ApprovedEmptyState extends ApprovedState{}

class ApprovedResponseState extends ApprovedState{
  final UserRequestModel response;
  ApprovedResponseState(this.response);

}

class ApprovedErrorState extends ApprovedState{
  final String error;
  ApprovedErrorState(this.error);
}