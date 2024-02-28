import 'dart:convert';
import 'package:tagmevendor/core/constants/api_urls.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/models/business_category_model.dart';
import 'package:tagmevendor/models/company_detail_model.dart';
import 'package:tagmevendor/models/company_info_model.dart';
import 'package:tagmevendor/models/login_otp_model.dart';
import 'package:http/http.dart' as http;
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/com_info_req_model.dart';
import 'package:tagmevendor/models/req_model/sign_up_req_model.dart';
import 'package:tagmevendor/models/req_model/update_all_user_data_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/models/user_data_model.dart';

class AuthRepository {
  /////////////////////////////////////////////////////////////////////////////////      get login otp
  static Future<MessageModel> getLoginOtp(
      String dialCode, String number) async {
    var url = LOGIN_OTP;
    print(url);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"dialCode": '+91', "number": number});
    print("login api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("<<<<<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>>>>>");
    var data = jsonDecode(await response.stream.bytesToString());
    print("BBBBBBBBBBBBBBBBBBBBBBBBBB");
    print(data);
    try {
      if (response.statusCode == 200) {
        print("////////////////////////////////////////////////////");
        print(data);
        return MessageModel.fromJson(data);
      } else {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<00");
        print("failed");
        return MessageModel.fromJson(data);
      }
    } catch (e) {
      print(e);
      return MessageModel.fromJson(data);
    }
  }

  /////////////////////////////////////////////////////////////////////  verify otp
  static Future<UserDataModel> verifyOtp(
      String dialCode, String number, String otp) async {
    var url = VERIFY_OTP;
    print("?????????????????");
    print(url);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body =
        json.encode({"dialCode": dialCode, "number": number, "otp": otp});
    print("verify otp api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var datac = jsonDecode(await response.stream.bytesToString());
    // var datac = await response.stream.bytesToString();

    try {
      if (response.statusCode == 200) {
        print("////////////////////////////////////////////////////");
        print(datac);
        return UserDataModel.fromJson(datac);
      } else if (response.statusCode == 400) {
        print("//////////////////////////////////111//////////////////");
        print(response);
        return UserDataModel.fromJson(datac);
      } else {
        print("failed");
        return UserDataModel.fromJson(datac);
      }
    } catch (e) {
      print(e);
      return UserDataModel.fromJson(datac);
    }
  }

  /////////////////////////////////////////////////////////////////////  verify otp and update number api call
  static Future<MessageModel> verifyOtpAndUpdateNumber(
      String dialCode, String number, String otp) async {
    var uid = await Helper.getUid();
    var url = VERIFY_UPDATE_NUMBER_OTP_URL(uid);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body =
        json.encode({"dialCode": dialCode, "number": number, "otp": otp});
    print("verify otp and update number api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var datac = jsonDecode(await response.stream.bytesToString());
    // var datac = await response.stream.bytesToString();

    try {
      if (response.statusCode == 200) {
        print("////////////////////////////////////////////////////");
        print(datac);
        return MessageModel.fromJson(datac);
      } else if (response.statusCode == 400) {
        print("//////////////////////////////////111//////////////////");
        print(response);
        return MessageModel.fromJson(datac);
      } else {
        print("failed");
        return MessageModel.fromJson(datac);
      }
    } catch (e) {
      print(e);
      return MessageModel.fromJson(datac);
    }
  }

  /////////////////////////////////////////////////////////////////////  signup request
  static Future<SignupModel> signUp(SignupReqModel req) async {
    var url = SIGNUP;
    var token = await Helper.getUserIdData();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // var request = http.Request('POST', Uri.parse(url));
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'name': req.name.toString(),
      'email': req.email.toString(),
      'additionalInfo': req.additionalInfo.toString(),
      'dialCode': '+91',
      "number": req.number.toString(),
      'foodTruckRego': req.foodTruckRego.toString()
    });
    print("sign up api call");
    request.headers.addAll(headers);
    var data;

    try {
      http.StreamedResponse response = await request.send();
      data = jsonDecode(await response.stream.bytesToString());
      // var data = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("////////////////////////////////////////////////////");
        print(data);
        return SignupModel.fromJson(data);
      } else {
        print("failed");
        print(data);
        return SignupModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return SignupModel.fromJson(data);
    }
  }

  /////////////////////////////////////////////////////////////////////  Add company detail
  static Future<CompanyInfoModel> addCompanyDetail(ComInfoReqModel req) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = ADD_COMPANY_INFO_URL(uid);
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // var request = http.Request('POST', Uri.parse(url));
    // Map<String,String> data = {

    // };
    // data.
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // String listToCommaSeparatedString() {
    //   return req.businessCategory.join(', ');
    // }
    // req.businessCategory!.join(',');

    request.fields.addAll({
      'companyName': req.companyName.toString(),
      'companyWebsite': req.companyWebsite.toString(),
      'companyAdditionalInfo': req.companyAdditionalInfo.toString(),
      // 'businessCategory': "652e3f54742aafffbd3aa9f0,652e3f9d742aafffbd3aa9f4",
      'businessCategory': req.businessCategory!.join(',')
    });

    request.files
        .add(await http.MultipartFile.fromPath('image', req.image.toString()));
    print("company info api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return CompanyInfoModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return CompanyInfoModel.fromJson(data);
    }
  }

  ////////////////////////////////////////////////////////////////////////////////   get person detail
  static Future<SignupModel> getPersonDetail() async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_PERSON_DETAIL_URL(uid);
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // var request = http.Request('POST', Uri.parse(url));
    var request = http.MultipartRequest('GET', Uri.parse(url));
    print("GET person detail api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return SignupModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return SignupModel.fromJson(data);
    }
  }

  ////////////////////////////////////////////////////////////////////////////////   get company detail
  static Future<CompanyDetailModel> getCompanyDetail() async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_COMPANY_DETAIL_URL(uid);
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // var request = http.Request('POST', Uri.parse(url));
    var request = http.MultipartRequest('GET', Uri.parse(url));
    print("GET company detail api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return CompanyDetailModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return CompanyDetailModel.fromJson(data);
    }
  }

  ////////////////////////////////////////////////////////////////////////////////   notification Check
  static Future<MessageModel> notificationCheck(bool noti) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_NOTIFICATION_URL(uid, noti);
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // var request = http.Request('POST', Uri.parse(url));
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    // var request = http.MultipartRequest('PUT', Uri.parse('https://b3d0-103-175-180-79.ngrok-free.app/vendor/notify-vendor/652fb2bc424c5ab932f159b2?notification=true'));
    print("notification api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return MessageModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return MessageModel.fromJson(data);
    }
  }

  ////////////////////////////////////////////////////////////////////////////////   upload profile image
  static Future<MessageModel> uploadProfileImage(String imageUrl) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = UPLOAD_PROFILE_IMAGE_URL(uid);
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    // var request = http.Request('POST', Uri.parse(url));
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('profileImage', imageUrl));
    print("upload image  api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return MessageModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return MessageModel.fromJson(data);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////      get NEW NUMBER otp
  static Future<MessageModel> getNewNumberOtp(
      String dialCode, String number) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = NEW_NUMBER_OTP_URL(uid);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"dialCode": dialCode, "number": number});
    print("get new number otp api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return MessageModel.fromJson(data);
    } else {
      print("failed");
      return MessageModel.fromJson(data);
    }
  }

  ////////////////////////////////////**///////////////////////////////////////////     update all user data
  //////////////////////////////////////////////////////    used in update company info
  static Future<MessageModel> updateAllUserData(
      UpdateAllUserDataReqModel req, String imagePath) async {
    print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
    print(imagePath);
    print(req.image.toString());
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = UPDATE_ALL_USER_DATA_URL(uid);
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // var request = http.Request('POST', Uri.parse(url));
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.fields.addAll({
      'name': req.name.toString(),
      'additionalInfo': req.additionalInfo.toString(),
      'dialCode': req.dialCode.toString(),
      'number': req.number.toString(),
      'foodTruckRego': req.foodTruckRego.toString(),
      'companyName': req.companyName.toString(),
      'companyWebsite': req.companyWebsite.toString(),
      'companyAdditionalInfo': req.companyAdditionalInfo.toString(),
      'businessCategory': req.businessCategory!.join(',')
    });
    

    if (imagePath != "") {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    } else {
      request.fields.addAll({
        'image': req.image.toString(),
      });
    }

    print("update all user data api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return MessageModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return MessageModel.fromJson(data);
    }
  }

  ////////////////////////////////////////////////     used in update profile data
  static Future<MessageModel> updateProfileData(
      UpdateAllUserDataReqModel req) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = UPDATE_ALL_USER_DATA_URL(uid);
    print("GGGGGGGGGGGGGGGGGGGGGGGGGGGg");
    print(
      req.image.toString(),
    );
    print(url);
    print(token);
    print(uid + "***");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.fields.addAll({
      'name': req.name.toString(),
      'additionalInfo': req.additionalInfo.toString(),
      'dialCode': req.dialCode.toString(),
      'number': req.number.toString(),
      'foodTruckRego': req.foodTruckRego.toString(),
      'companyName': req.companyName.toString(),
      'companyWebsite': req.companyWebsite.toString(),
      'companyAdditionalInfo': req.companyAdditionalInfo.toString(),
      'image': req.image.toString(),
      'businessCategory': req.businessCategory!.join(','),
    });
    

    print("update all user data api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return MessageModel.fromJson(data);
    } else {
      print("failed");
      print(data);
      return MessageModel.fromJson(data);
    }
  }

  ////////////////////////////////////////////////////////////////      get business category
  static Future<BusinessCategoryModel> getCategory() async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_BUSINESS_CATEGORY;
    print(token);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    print("get BUSINESS CATEGORY api call");
    request.headers.addAll(headers);
    print("111111111111111111");
    http.StreamedResponse response = await request.send();
    print("22222222222222222222");
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());
    print("333333333333333333333");
    try {
      if (response.statusCode == 200) {
        print("////////////////////////////////////////////////////");
        print(data);
        return BusinessCategoryModel.fromJson(data);
      } else {
        print("failed");
        return BusinessCategoryModel.fromJson(data);
      }
    } catch (e) {
      print("Catched error");
      print(e.toString());
      return BusinessCategoryModel.fromJson(data);
    }
  }
}
