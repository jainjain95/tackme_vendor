import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/repository/route_repository.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_state.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/start_route_model.dart';

class StartRouteMapCubit extends Cubit<StartRouteMapState> {
  StartRouteMapCubit() : super(StartRouteMapInitialState());

  String currentStop ="";
  int cindex = 0;

  void getStartRouteData(RData routeData, LatLng cLocation) async {
    Map<PolylineId, Polyline> polylines = {};
    print(routeData.stops![0].sid.toString());
    // new
    List<LatLng> points = [];
    Map<String, Marker> marker = {};
    

    StartRouteModel startRoutedata =
        await RouteRepository.routeStart(routeData, cLocation);
    try {
      if (startRoutedata.route!.polyLines!.polyLine!.isNotEmpty) {
        print("get polyline point s not empty");
        for (var i = 0;
            i < startRoutedata.route!.polyLines!.polyLine!.length;
            i++) {
          points.add(LatLng(
              startRoutedata.route!.polyLines!.polyLine![i].latitude ?? 0.0,
              startRoutedata.route!.polyLines!.polyLine![i].longitude ?? 0.0));
        }
        marker["one"] = Marker(
          markerId: MarkerId('marker_one'),
          position: LatLng(
            points.first.latitude,
            points.first.longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(100.0, 100.0)
                // devicePixelRatio: 2.0
                ),
            'assets/images/pngs/car.png',
          ),
        );
        marker["two"] = Marker(
          markerId: MarkerId('marker_two'),
          position: LatLng(
            points.last.latitude,
            points.last.longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(200.0, 200.0)
                // devicePixelRatio: 2.0
                ),
            'assets/images/pngs/circle_stop.png',
          ),
        );
        PolylineId id = PolylineId("poly1");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: points,
          width: 3,
        );
        polylines[id] = polyline;
        for(int i=0; i<startRoutedata.route!.stops!.length; i++){
          if(startRoutedata.route!.stops![0].status.toString() == "upcoming"){
            currentStop = startRoutedata.route!.startingLocation!.startAddress.toString();
            cindex=0;
          }
          if(startRoutedata.route!.stops![i].status == "arrived"){
            currentStop = startRoutedata.route!.stops![i].location!.locationNickName.toString();
            cindex = i+1;
          }
        }
        emit(StartRouteMapResponseState(
            polylines, marker, startRoutedata, points, currentStop, cindex));
      } else {
        emit(StartRouteMapErrorState("No Polyline Found"));
      }
    } catch (e) {
      emit(StartRouteMapErrorState(e.toString()));
    }
  }

  void checkInStop(String routeId, String stopId) async {
    Map<PolylineId, Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
    List<LatLng> points = [];
    Map<String, Marker> marker = {};

    StartRouteModel startRoutedata =
        await RouteRepository.checkInStop(routeId, stopId);
    try {
      if (startRoutedata.route!.polyLines!.polyLine!.isNotEmpty) {
        print("get polyline point s not empty");
        for (var i = 0;
            i < startRoutedata.route!.polyLines!.polyLine!.length;
            i++) {
          points.add(LatLng(
              startRoutedata.route!.polyLines!.polyLine![i].latitude ?? 0.0,
              startRoutedata.route!.polyLines!.polyLine![i].longitude ?? 0.0));
        }
        marker["one"] = Marker(
          markerId: MarkerId('marker_one'),
          position: LatLng(
            points.first.latitude,
            points.first.longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(100.0, 100.0)
                // devicePixelRatio: 2.0
                ),
            'assets/images/pngs/car.png',
          ),
        );
        marker["two"] = Marker(
          markerId: MarkerId('marker_two'),
          position: LatLng(
            points.last.latitude,
            points.last.longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(200.0, 200.0)
                // devicePixelRatio: 2.0
                ),
            'assets/images/pngs/circle_stop.png',
          ),
        );
        PolylineId id = PolylineId("poly1");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: points,
          width: 3,
        );
        polylines[id] = polyline;
        for(int i=0; i<startRoutedata.route!.stops!.length; i++){
          if(startRoutedata.route!.stops![0].status.toString() == "upcoming"){
            currentStop = startRoutedata.route!.startingLocation!.startAddress.toString();
            cindex=0;
          }
          if(startRoutedata.route!.stops![i].status == "arrived"){
            currentStop = startRoutedata.route!.stops![i].location!.locationNickName.toString();
            cindex = i+1;
          }
        }
        emit(StartRouteMapResponseState(
            polylines, marker, startRoutedata, points, currentStop, cindex));
      } else {
        emit(StartRouteMapErrorState("No Polyline Found"));
      }
    } catch (e) {
      emit(StartRouteMapErrorState(e.toString()));
    }
  }

  void ongoingRoute() async {
    Map<PolylineId, Polyline> polylines = {};
    // List<LatLng> polylineCoordinates = [];
    List<LatLng> points = [];
    Map<String, Marker> marker = {};

    StartRouteModel startRoutedata = await RouteRepository.ongoingRoute();
    try {
      if (startRoutedata.route != null) {
        if (startRoutedata.route!.polyLines!.polyLine!.isNotEmpty) {
          print("get polyline point s not empty");
          for (var i = 0;
              i < startRoutedata.route!.polyLines!.polyLine!.length;
              i++) {
            points.add(LatLng(
                startRoutedata.route!.polyLines!.polyLine![i].latitude ?? 0.0,
                startRoutedata.route!.polyLines!.polyLine![i].longitude ??
                    0.0));
          }
          marker["one"] = Marker(
            markerId: MarkerId('marker_one'),
            position: LatLng(
              points.first.latitude,
              points.first.longitude,
            ),
            icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(100.0, 100.0)
                  // devicePixelRatio: 2.0
                  ),
              'assets/images/pngs/car.png',
            ),
          );
          marker["two"] = Marker(
            markerId: MarkerId('marker_two'),
            position: LatLng(
              points.last.latitude,
              points.last.longitude,
            ),
            icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(200.0, 200.0)
                  // devicePixelRatio: 2.0
                  ),
              'assets/images/pngs/circle_stop.png',
            ),
          );
          PolylineId id = PolylineId("poly1");
          Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.blueAccent,
            points: points,
            width: 3,
          );
          polylines[id] = polyline;
          for(int i=0; i<startRoutedata.route!.stops!.length; i++){
          if(startRoutedata.route!.stops![0].status.toString() == "upcoming"){
            currentStop = startRoutedata.route!.startingLocation!.startAddress.toString();
            cindex=0;
          }
          if(startRoutedata.route!.stops![i].status == "arrived"){
            currentStop = startRoutedata.route!.stops![i].location!.locationNickName.toString();
            cindex = i+1;
          }
        }
          emit(StartRouteMapResponseState(
              polylines, marker, startRoutedata, points, currentStop, cindex));
        } else {
          emit(StartRouteMapErrorState("No Polyline Found"));
        }
      } else {
        emit(StartRouteMapInitialState());
      }
    } catch (e) {
      emit(StartRouteMapErrorState(e.toString()));
    }
  }



  void endOngoingRoute(String ongoingRouteId) async {
    Map<PolylineId, Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
    List<LatLng> points = [];
    Map<String, Marker> marker = {};

    StartRouteModel startRoutedata =
        await RouteRepository.endOngoingRoute(ongoingRouteId);
    try {
      if (startRoutedata.route!.polyLines!.polyLine!.isNotEmpty) {
        print("get polyline point s not empty");
        for (var i = 0;
            i < startRoutedata.route!.polyLines!.polyLine!.length;
            i++) {
          points.add(LatLng(
              startRoutedata.route!.polyLines!.polyLine![i].latitude ?? 0.0,
              startRoutedata.route!.polyLines!.polyLine![i].longitude ?? 0.0));
        }
        marker["one"] = Marker(
          markerId: MarkerId('marker_one'),
          position: LatLng(
            points.first.latitude,
            points.first.longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(100.0, 100.0)
                // devicePixelRatio: 2.0
                ),
            'assets/images/pngs/car.png',
          ),
        );
        marker["two"] = Marker(
          markerId: MarkerId('marker_two'),
          position: LatLng(
            points.last.latitude,
            points.last.longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(200.0, 200.0)
                // devicePixelRatio: 2.0
                ),
            'assets/images/pngs/circle_stop.png',
          ),
        );
        PolylineId id = PolylineId("poly1");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: points,
          width: 3,
        );
        polylines[id] = polyline;
        for(int i=0; i<startRoutedata.route!.stops!.length; i++){
          if(startRoutedata.route!.stops![0].status.toString() == "upcoming"){
            currentStop = startRoutedata.route!.startingLocation!.startAddress.toString();
            cindex=0;
          }
          if(startRoutedata.route!.stops![i].status == "arrived"){
            currentStop = startRoutedata.route!.stops![i].location!.locationNickName.toString();
            cindex = i+1;
          }
        }
        emit(StartRouteMapResponseState(
            polylines, marker, startRoutedata, points, currentStop, cindex));
      } else {
        emit(StartRouteMapErrorState("No Polyline Found"));
      }
    } catch (e) {
      emit(StartRouteMapErrorState(e.toString()));
    }
  }



  void resetState() {
    emit(StartRouteMapInitialState());
  }
}
