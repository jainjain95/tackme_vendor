import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class AddStopState{}

class AddStopInitialState extends AddStopState{}

class AddStopLoadingState extends AddStopState{}

// class AddStopEmptyState extends AddStopState{}

class AddStopResponseState extends AddStopState{
  final MessageModel response;
  AddStopResponseState(this.response);

}

class AddStopErrorState extends AddStopState{
  final String error;
  AddStopErrorState(this.error);
}