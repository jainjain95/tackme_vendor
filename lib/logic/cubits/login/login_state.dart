import 'package:tagmevendor/models/message_model.dart';

abstract class LoginState{}

class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState{}

class LoginResponseState extends LoginState{
  final MessageModel response;
  LoginResponseState(this.response);

}

class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
}