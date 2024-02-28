import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class StopState{}

// class VOtpInitialState extends ScheduleState{}

class StopLoadingState extends StopState{}

class StopEmptyState extends StopState{}

class StopResponseState extends StopState{
  final StopModel response;
  StopResponseState(this.response);

}

class StopErrorState extends StopState{
  final String error;
  StopErrorState(this.error);
}