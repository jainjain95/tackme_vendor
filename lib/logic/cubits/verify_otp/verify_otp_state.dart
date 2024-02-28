import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/user_data_model.dart';
import 'package:tagmevendor/models/verify_otp_model.dart';

abstract class VOtpState{}

class VOtpInitialState extends VOtpState{}

class VOtpLoadingState extends VOtpState{}

class VOtpResponseState extends VOtpState{
  final UserDataModel response;
  VOtpResponseState(this.response);

}

class VOtpAndUpdateNumberResponseState extends VOtpState{
  final MessageModel response;
  VOtpAndUpdateNumberResponseState(this.response);

}

class VOtpErrorState extends VOtpState{
  final String error;
  VOtpErrorState(this.error);
}