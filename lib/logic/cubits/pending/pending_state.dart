import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class PendingState{}

// class VOtpInitialState extends ScheduleState{}

class PendingLoadingState extends PendingState{}

class PendingEmptyState extends PendingState{}

class PendingResponseState extends PendingState{
  final UserRequestModel response;
  PendingResponseState(this.response);

}

class PendingErrorState extends PendingState{
  final String error;
  PendingErrorState(this.error);
}