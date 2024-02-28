
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/signup_model.dart';


abstract class CompanyInfoState{}

class CompanyInfoInitialState extends CompanyInfoState{}

class CompanyInfoLoadingState extends CompanyInfoState{}

class CompanyInfoResponseState extends CompanyInfoState{
  final MessageModel response;
  CompanyInfoResponseState(this.response);

}

class CompanyInfoErrorState extends CompanyInfoState{
  final String error;
  CompanyInfoErrorState(this.error);
}