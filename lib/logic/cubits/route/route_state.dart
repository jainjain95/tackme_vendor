import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/stop_model.dart';

abstract class RouteState{}

// class VOtpInitialState extends ScheduleState{}

class RouteLoadingState extends RouteState{}

class RouteEmptyState extends RouteState{}

class RouteResponseState extends RouteState{
  final RouteModel response;
  RouteResponseState(this.response);

}

class RouteErrorState extends RouteState{
  final String error;
  RouteErrorState(this.error);
}