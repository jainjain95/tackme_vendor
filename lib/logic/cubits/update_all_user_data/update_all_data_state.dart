import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/update_all_user_data_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class UpdateAllDataState{}

class UpdateAllDataInitialState extends UpdateAllDataState{}

class UpdateAllDataLoadingState extends UpdateAllDataState{}

class UpdateAllDataEmptyState extends UpdateAllDataState{}

class UpdateAllDataResponseState extends UpdateAllDataState{
  final MessageModel response;
  UpdateAllDataResponseState(this.response);

}

class UpdateAllDataErrorState extends UpdateAllDataState{
  final String error;
  UpdateAllDataErrorState(this.error);
}