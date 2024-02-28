import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/user_data_model.dart';
import 'package:tagmevendor/models/verify_otp_model.dart';

abstract class UploadProfileImgState{}

class UploadProfileImgInitialState extends UploadProfileImgState{}

class UploadProfileImgLoadingState extends UploadProfileImgState{}

class UploadProfileImgResponseState extends UploadProfileImgState{
  final MessageModel response;
  UploadProfileImgResponseState(this.response);

}

class UploadProfileImgErrorState extends UploadProfileImgState{
  final String error;
  UploadProfileImgErrorState(this.error);
}