import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/models/signup_model.dart';

abstract class SignupState{}

class SignupInitialState extends SignupState{}

class SignupLoadingState extends SignupState{}

class SignupResponseState extends SignupState{
  final SignupModel response;
  SignupResponseState(this.response);

}

class SignupErrorState extends SignupState{
  final String error;
  SignupErrorState(this.error);
}