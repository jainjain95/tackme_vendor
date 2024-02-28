import 'package:tagmevendor/models/schedule_List_Model.dart';

abstract class ScheduleState{}

// class VOtpInitialState extends ScheduleState{}

class ScheduleLoadingState extends ScheduleState{}

class ScheduleEmptyState extends ScheduleState{}

class ScheduleResponseState extends ScheduleState{
  final ScheduleListModel response;
  ScheduleResponseState(this.response);

}

class ScheduleErrorState extends ScheduleState{
  final String error;
  ScheduleErrorState(this.error);
}