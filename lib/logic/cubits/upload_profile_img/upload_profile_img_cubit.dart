import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/upload_profile_img/upload_profile_img_state.dart';
import 'package:tagmevendor/models/message_model.dart';


class UploadProfileImgCubit extends Cubit<UploadProfileImgState> {
  UploadProfileImgCubit():super(UploadProfileImgInitialState());

  void upLoadProfileImage(String _image) async {
    emit(UploadProfileImgLoadingState());
    try{
      MessageModel res = await AuthRepository.uploadProfileImage(_image);
      if(res.status == true){

        emit(UploadProfileImgResponseState(res));
      } 
      else {
        emit(UploadProfileImgErrorState(res.message.toString()));
      }
    } catch (e){
      emit(UploadProfileImgErrorState(e.toString()));
    }
  }

}