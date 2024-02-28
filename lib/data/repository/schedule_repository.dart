import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tagmevendor/core/constants/api_urls.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/models/delete_update_model.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';

class ScheduleRepository {

  ///////////////////////////////////////////////////////////////////////////////      get Schedule
  static Future<ScheduleListModel> getSchedule() async {
    // var url = GET_SECHDULE;
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    print("++++++++++++++++  "+uid);
    var url = GET_USER_SCHEDULE(uid);
    
    print(token);
    var headers = {
      'Authorization':
          'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    print("get schedule api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = await response.stream.bytesToString();
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ScheduleListModel.fromRawJson(data);
    } else {
      print("failed");
      return ScheduleListModel.fromRawJson(data);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////      add schedule
  static Future<ScheduleListModel> 
  addSchedule(
    Datum req
  ) async {
    var url = ADD_SECHDULE;
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var headers = {
      'Authorization':
          'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "startTime": req.startTime,
      "endTime": req.endTime,
      "liveLocation": req.liveLocation,
      "vendorId": uid,
      "days": req.days,
      "scheduleName": req.scheduleName
    });
    print("add schedule api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = await response.stream.bytesToString();
    // var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ScheduleListModel.fromRawJson(data);
    } else {
      print("failed");
      return ScheduleListModel.fromRawJson(data);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////      delete schedule
  static Future<DAUModel> deleteSchedule( String schId) async {
    var url = GET_DELETE_SCHEDULR_URL(schId,"true");
    var token = await Helper.getUserIdData();
    var headers = {
      'Authorization':
          'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    print("delete schedule api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return DAUModel.fromJson(data);
    } else {
      print("failed");
      return DAUModel.fromJson(data);
    }
  }


  ///////////////////////////////////////////////////////////////////////////////      update schedule
  static Future<DAUModel> updateSchedule(Datum req) async {
    var url = GET_UPDATE_SCHEDULE_URL(req.id.toString());
    var token = await Helper.getUserIdData();
    var headers = {
      'Authorization':
          'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({
      "startTime": req.startTime,
      "endTime": req.endTime,
      "days": req.days,
      "liveLocation": req.liveLocation,
      "scheduleName": req.scheduleName
    });
    print("update schedule api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print("////////////////////////////////////////////////////");
      print(data);
      return DAUModel.fromJson(data);
    } else {
      print("failed");
      return DAUModel.fromJson(data);
    }
  }


}
