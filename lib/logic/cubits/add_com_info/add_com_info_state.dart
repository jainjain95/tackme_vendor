import 'package:tagmevendor/models/company_info_model.dart';
import 'package:tagmevendor/models/signup_model.dart';

abstract class AddComInfoState{}

class AddComInfoInitialState extends AddComInfoState{}

class AddComInfoLoadingState extends AddComInfoState{}

class AddComInfoResponseState extends AddComInfoState{
  final CompanyInfoModel response;
  AddComInfoResponseState(this.response);

}

class AddComInfoErrorState extends AddComInfoState{
  final String error;
  AddComInfoErrorState(this.error);
}