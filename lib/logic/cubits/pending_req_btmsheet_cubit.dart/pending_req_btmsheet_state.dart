import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class PendingReqBtmSheetState{}

class PendingReqBtmSheetInitialState extends PendingReqBtmSheetState{}

class PendingReqBtmSheetLoadingState extends PendingReqBtmSheetState{}

class PendingReqBtmSheetEmptyState extends PendingReqBtmSheetState{}

class PendingReqBtmSheetResponseState extends PendingReqBtmSheetState{
  final MessageModel response;
  PendingReqBtmSheetResponseState(this.response);

}

class PendingReqBtmSheetErrorState extends PendingReqBtmSheetState{
  final String error;
  PendingReqBtmSheetErrorState(this.error);
}