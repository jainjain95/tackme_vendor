import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class ProfileTabState{}

// class VOtpInitialState extends ScheduleState{}

class ProfileTabLoadingState extends ProfileTabState{}

class ProfileTabEmptyState extends ProfileTabState{}

class ProfileTabResponseState extends ProfileTabState{
  final SignupModel response;
  ProfileTabResponseState(this.response);

}

class ProfileTabErrorState extends ProfileTabState{
  final String error;
  ProfileTabErrorState(this.error);
}