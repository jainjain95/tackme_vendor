import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/stop_model.dart';
class MapRepository {




  String googleMapKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";


  /////////////////////////////////////////////////////////////////////////////////      get polyline
  PolylinePoints polylinePoints = PolylinePoints();
  final Map<String, Marker> marker= {};

  Future<PolylineResult> getPolyline(
    RData data
  ) async {

    List<PolylineWayPoint> polylineWayPoints = [];

    double originLat = data.stops!.first.location!.coordinates![0];
    double originLng = data.stops!.first.location!.coordinates![1];
    double destinationLat = data.stops!.last.location!.coordinates![0];
    double destinationLng = data.stops!.last.location!.coordinates![0];
    for(var i = 1; i<=data.stops!.length-2; i++){
      // print(object);
      polylineWayPoints.add(
        PolylineWayPoint(location: "${data.stops![i].location!.coordinates![0].toString()},${data.stops![i].location!.coordinates![1].toString()}",stopOver: true));
    }


    print("get polyline call");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleMapKey,
        PointLatLng(originLat, originLng),
        PointLatLng(destinationLat, destinationLng),
        travelMode: TravelMode.driving,
        wayPoints: polylineWayPoints
      );
    return result;
  }






  /////////////////////////////////////////////////////////////////////////////////      add polyline

  Future<PolylineResult> addPolyline( List<Data> data

  ) async {

    List<PolylineWayPoint> polylineWayPoints = [];

    double originLat = data.first.location!.coordinates![1];
    double originLng = data.first.location!.coordinates![0];
    double destinationLat = data.last.location!.coordinates![1];
    double destinationLng = data.last.location!.coordinates![0];


    for(var i = 1; i<=data.length-2; i++){
      // print(object);
      polylineWayPoints.add(
        PolylineWayPoint(location: "${data[i].location!.coordinates![1].toString()},${data[i].location!.coordinates![0].toString()}",stopOver: true));
    }



    print("add polyline call");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapKey,
        PointLatLng(originLat, originLng),
        PointLatLng(destinationLat, destinationLng),
        travelMode: TravelMode.driving,
        wayPoints: polylineWayPoints
      );
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // print(result.points.length);
    for(var a=0; a<result.points.length; a++){
      // print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(result.points[a].latitude);
    }
    print(result.points[0].latitude);
    print(result.points[0].longitude);
    print(result.points[1].latitude);
    print(result.points[1].longitude);
    print(result.points);
    return result;
  }




  //////////////////////////////////////////////      get polyline with ployline list
  Future<PolylineResult> getPolylineWithPloList( List<LatLng> data) async {

    List<PolylineWayPoint> polylineWayPoints = [];

    double originLat = data.first.latitude;
    double originLng = data.first.longitude;
    double destinationLat = data.last.latitude;
    double destinationLng = data.last.longitude;

    for(var i = 1; i<=data.length-2; i++){
      polylineWayPoints.add(
        PolylineWayPoint(location: "${data[i].latitude.toString()},${data[i].longitude.toString()}",stopOver: true));
    }

    print("add polyline call");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleMapKey,
        PointLatLng(originLat, originLng),
        PointLatLng(destinationLat, destinationLng),
        travelMode: TravelMode.driving,
        wayPoints: polylineWayPoints
      );
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(result.points[0].latitude);
    print(result.points[0].longitude);
    print(result.points[1].latitude);
    print(result.points[1].longitude);
    print(result.points);
    return result;
  }
}