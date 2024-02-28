import 'dart:convert';
import 'package:tagmevendor/core/constants/api_urls.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/add_stop_req_model.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:http/http.dart' as http;

class StopRepository {

  ////////////////////////////////////////////////////////////////      get stops
  static Future<StopModel> getStop() async {
    
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_STOP_URL(uid);
    print(token);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());
    try {
      if (response.statusCode == 200) {
      return StopModel.fromJson(data);
    } else {
      print("failed");
      return StopModel.fromJson(data);
    }
    } catch(e) {
      print("Catched error");
      print(e.toString());
      return StopModel.fromJson(data);
    }
  }



  ///////////////////////////////////////////////////////////////////////////////      add stop
  static Future<MessageModel> addStop(AddStopReqModel req) async {
    var url = ADD_STOP;
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var headers = {
      'Authorization':
          'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "locationNickName": req.locationNickName,
      "longitude": req.longitude,
      "latitude": req.latitude,
      "vendorId": uid,
      "address": req.address
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());
    print(data);
    if (response.statusCode == 200) {
      return MessageModel.fromJson(data);
    } else {
      print("failed");
      return MessageModel.fromJson(data);
    }
  }
}
