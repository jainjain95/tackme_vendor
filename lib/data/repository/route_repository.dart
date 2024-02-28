import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/constants/api_urls.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/models/message_model.dart';
import 'package:tagmevendor/models/req_model/add_route_req_model.dart';
import 'package:tagmevendor/models/req_model/add_stop_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/start_route_model.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:http/http.dart' as http;

class RouteRepository {
  ////////////////////////////////////////////////////////////////      get route
  static Future<RouteModel> getRoute() async {
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = GET_ROUTE_URL(uid);
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
        return RouteModel.fromJson(data);
      } else {
        
        return RouteModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
      return RouteModel.fromJson(data);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////      add route
  static Future<MessageModel> addRoute(AddRouteReqModel req,) async {
    var url = Add_ROUTE_URL;
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    List<String>? stopList;
    
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "routeNickName": req.routeNickName,
      'stops': req.stops,
      "vendorId": uid,
      'schedule': req.schedule,
      'polyLine': req.polyLine
    });
    print("add stop api call");
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

  //////////////////////////////////////////////////////      update route
  static Future<MessageModel> updateRoute( AddRouteReqModel req
  ) async {
    
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = UPDATE_ROUTE_URL(req.routeId.toString());
    
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({
      "routeNickName": req.routeNickName,
      'stops': req.stops,
      "vendorId": uid,
      'schedule': req.schedule,
      'polyLine': req.polyLine
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





  ///////////////////////////////////////////////////////////////////////////////      add route
  static Future<StartRouteModel> routeStart(RData routeData, LatLng cLocation) async {
    
    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = START_ROUTE_URL(routeData.id.toString());
    print(url);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "currentLat": cLocation.latitude,
      "currentLong": cLocation.longitude,
      "startingStop": routeData.stops![0].sid.toString(),
      "vendorId": uid
    });
    print("start route api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());
    print(data);
    if (response.statusCode == 200) {
      return StartRouteModel.fromJson(data);
    } else {
      print("failed");
      return StartRouteModel.fromJson(data);
    }


    
  }

  ///////////////////////////////////////////////////////////////////////////////      checkInStop route
  static Future<StartRouteModel> checkInStop(
    String routeId,
    String stopId
  ) async {
    var token = await Helper.getUserIdData();
    var url = CHECKIN_STOP_URL(routeId);
    print(url);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({
      "stopId": stopId
    });
    print("checkin stop api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());
    print(data);
    if (response.statusCode == 200) {
      return StartRouteModel.fromJson(data);
    } else {
      print("failed");
      return StartRouteModel.fromJson(data);
    }
  }


  ///////////////////////////////////////////////////////////////////////////////      add route
  static Future<StartRouteModel> ongoingRoute() async {

    var token = await Helper.getUserIdData();
    var uid = await Helper.getUid();
    var url = ONGOING_ROUTE_URL(uid);
    print(url);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    print("ongoingRoute api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // var data = await response.stream.bytesToString();
    var data = jsonDecode(await response.stream.bytesToString());
    print(data);
    if (response.statusCode == 200) {
      return StartRouteModel.fromJson(data);
    } else {
      print("failed");
      return StartRouteModel.fromJson(data);
    }
  }



  ///////////////////////////////////////////////////////////////////////////////      checkInStop route
  static Future<StartRouteModel> endOngoingRoute(
    String ongoingRouteId
  ) async {
    var token = await Helper.getUserIdData();
    var url = END_ONGOING_ROUTE_URL(ongoingRouteId);
    print(url);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    print("checkin stop api call");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    print(data);
    if (response.statusCode == 200) {
      return StartRouteModel.fromJson(data);
    } else {
      print("failed");
      return StartRouteModel.fromJson(data);
    }
  }
}
