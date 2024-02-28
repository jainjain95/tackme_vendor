import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class UpdateRouteState{}

class UpdateRouteInitialState extends UpdateRouteState{}

class UpdateRouteLoadingState extends UpdateRouteState{}

// class AddStopEmptyState extends AddStopState{}

class UpdateRouteResponseState extends UpdateRouteState{
  final MessageModel response;
  UpdateRouteResponseState(this.response);

}

class UpdateRouteErrorState extends UpdateRouteState{
  final String error;
  UpdateRouteErrorState(this.error);
}