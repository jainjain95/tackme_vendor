import 'dart:convert';
import 'package:tagmevendor/core/constants/api_urls.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/models/approved_req_model.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/models/req_model/add_stop_req_model.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:http/http.dart' as http;

class RequestRepository {

  ////////////////////////////////////////////////////////////////      get Pending requset
  static Future<UserRequestModel> getPendingRequest() async {
    
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_PENDING_REQ_URL("652fb2bc424c5ab932f159b2");
    print(token);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    print("get pending request api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    try {
      if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return UserRequestModel.fromJson(data);
    } else {
      print("failed");
      return UserRequestModel.fromJson(data);
    }
    } catch(e) {
      print("Catched error");
      print(e.toString());
      return UserRequestModel.fromJson(data);
    }
  }


  ////////////////////////////////////////////////////////////////      get approved requset
  static Future<UserRequestModel> getApprovedRequest() async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_APPROVED_REQ_URL("652fb2bc424c5ab932f159b2");
    print(token);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    print("get approved request api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    try {
      if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return UserRequestModel.fromJson(data);
    } else {
      print("failed");
      return UserRequestModel.fromJson(data);
    }
    } catch(e) {
      print("Catched error");
      print(e.toString());
      return UserRequestModel.fromJson(data);
    }
  }



  /////////////////////////////////////////////////////////////////////       update req
  static Future<MessageModel> updateRequestStatus(String reqStatus, String reqId) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = UPDATE_REQ_REQ_URL(reqId);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(
      {
        "status": reqStatus
      }
    );
    print("update req  api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var datac = jsonDecode(await response.stream.bytesToString());
    // var datac = await response.stream.bytesToString();

    try {
      if (response.statusCode == 200) {
        return MessageModel.fromJson(datac);
      } else if (response.statusCode == 400) {
        return MessageModel.fromJson(datac);
      } else if (response.statusCode == 400) {
        return MessageModel.fromJson(datac);
      }
      else {
        print("failed");
        return MessageModel.fromJson(datac);
      }
    } catch (e) {
      print(e);
      return MessageModel.fromJson(datac);
    }
  }


  /////////////////////////////////////////////////////////////////////  reject req 
  static Future<MessageModel> rejectRequest(String reqId) async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = REJECT_REQ_URL(reqId);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(url));
    print("reject req api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var datac = jsonDecode(await response.stream.bytesToString());
    try {
      if (response.statusCode == 200) {
        return MessageModel.fromJson(datac);
      } else if (response.statusCode == 400) {
        return MessageModel.fromJson(datac);
      } else if (response.statusCode == 400) {
        return MessageModel.fromJson(datac);
      }
      else {
        print("failed");
        return MessageModel.fromJson(datac);
      }
    } catch (e) {
      print(e);
      return MessageModel.fromJson(datac);
    }
  }

}
