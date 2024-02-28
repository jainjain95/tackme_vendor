import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class NewNumberState{}

class NewNumberInitialState extends NewNumberState{}

class NewNumberLoadingState extends NewNumberState{}

class NewNumberEmptyState extends NewNumberState{}

class NewNumberResponseState extends NewNumberState{
  final MessageModel response;
  NewNumberResponseState(this.response);

}

class NewNumberErrorState extends NewNumberState{
  final String error;
  NewNumberErrorState(this.error);
}