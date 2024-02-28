import 'package:tagmevendor/models/message_model.dart';

abstract class ResendOtpState{}

class ResendOtpInitialState extends ResendOtpState{}

class ResendOtpLoadingState extends ResendOtpState{}

class ResendOtpResponseState extends ResendOtpState{
  final MessageModel response;
  ResendOtpResponseState(this.response);

}

class ResendOtpErrorState extends ResendOtpState{
  final String error;
  ResendOtpErrorState(this.error);
}