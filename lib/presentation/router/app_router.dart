import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_route_map/add_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/edit_rote_stop/edit_rote_stop_cubit.dart';
import 'package:tagmevendor/logic/cubits/edit_route_map/edit_route_map_cubit.dart';
import 'package:tagmevendor/models/req_model/start_route_req_model.dart';
import 'package:tagmevendor/models/route_model.dart';
import 'package:tagmevendor/models/stop_model.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/presentation/screens/approved_on_map_screen/approved_on_map_screen.dart';
import 'package:tagmevendor/presentation/screens/check_login_status/check_login_status.dart';
import 'package:tagmevendor/presentation/screens/company_info_screen/company_info_screen.dart';
import 'package:tagmevendor/presentation/screens/edit_route_screen/edit_route_screen.dart';
import 'package:tagmevendor/presentation/screens/my_qr_screen/my_qr_screen.dart';
import 'package:tagmevendor/presentation/screens/pending_on_map_screen/pending_on_map_screen.dart';
import 'package:tagmevendor/presentation/screens/personal_info_screen/personal_info_screen.dart';
import 'package:tagmevendor/presentation/screens/profile_tab_screen/profile_tab_screen.dart';
import 'package:tagmevendor/presentation/screens/add_route_screen/add_route_screen.dart';
import 'package:tagmevendor/presentation/screens/add_stops_screen/add_stops_screen.dart';
import 'package:tagmevendor/presentation/screens/route_info_screen/route_info_screen.dart';
import 'package:tagmevendor/presentation/screens/route_on_map_screen/route_on_map_screen.dart';
import 'package:tagmevendor/presentation/screens/stop_map_screen/stop_map_screen.dart';
import 'package:tagmevendor/presentation/screens/stop_qr_screen.dart/stop_qr_screen.dart';

import '../screens/dashboard/dashboard.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/schedule_screen/schedule_screen.dart';
import '../screens/signup_company_info/signup_company_info.dart';
import '../screens/signup_screen/signup_screen.dart';
import '../screens/subscription_screen/subscription_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  // static const String login = "_logInScreen";
  static const String login = "/";
  static const String checkLoginStatus = "_checkLoginStatus";
  static const String signup = "_signup";
  static const String signupCompanyInfo = "_signupCompanyInfo";
  static const String scheduleScreen = "_scheduleScreen";
  static const String subscriptionScreen = "_subscriptionScreen";
  static const String homeScreen = "_homeScreen";
  static const String dashboard = "_dashboard";
  static const String addStopsScreen = "_addStopsScreen";
  static const String stopMapScreen = "_stopMapScreen";
  static const String stopQrScreen = "_stopQrScreen";
  static const String editRouteScreen = "_editRouteScreen";
  static const String addRouteScreen = "_addRouteScreen";
  static const String routeMapScreen = "_routeMapScreen";
  static const String profileTabScreen = "_profileTabScreen";
  static const String personalInfoScreen = "_personalInfoScreen";
  static const String myQrScreen = "_myQrScreen";
  static const String approvedOnMapScreen = "_approvedOnMapScreen";
  static const String pendingOnMapScreen = "_pendingOnMapScreen";
  static const String companyInfoScreen = "_companyInfoScreen";
  static const String routeOnMapScreen = "_routeOnMapScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _logInScreen(settings);
      case checkLoginStatus:
        return _checkLoginStatus(settings);
      case signup:
        return _signup(settings);
      case signupCompanyInfo:
        return _signupCompanyInfo(settings);
      case scheduleScreen:
        return _scheduleScreen(settings);
      case subscriptionScreen:
        return _subscriptionScreen(settings);
      case homeScreen:
        return _homeScreen(settings);
      case dashboard:
        return _dashboard(settings);
      case addStopsScreen:
        return _addStopsScreen(settings);
      case stopMapScreen:
        return _stopMapScreen(settings);
      case stopQrScreen:
        return _stopQrScreen(settings);
      case editRouteScreen:
        return _editRouteScreen(settings);
      case addRouteScreen:
        return _addRouteScreen(settings);
      case routeMapScreen:
        return _routeMapScreen(settings);
      case profileTabScreen:
        return _profileTabScreen(settings);
      case personalInfoScreen:
        return _personalInfoScreen(settings);
      case myQrScreen:
        return _myQrScreen(settings);
      case approvedOnMapScreen:
        return _approvedOnMapScreen(settings);
      case pendingOnMapScreen:
        return _pendingOnMapScreen(settings);
      case companyInfoScreen:
        return _companyInfoScreen(settings);
      case routeOnMapScreen:
        return _routeOnMapScreen(settings);
      default:
        throw Exception("Route was not found");
    }
  }

  static _logInScreen(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => const LogInScreen());
  }

  static _checkLoginStatus(RouteSettings settings) async {

    return MaterialPageRoute(
        settings: settings, builder: (context) =>  const CheckLoginStatus());
  }

  static _signup(RouteSettings settings) {
    var number = settings.arguments as String;
    return MaterialPageRoute(
        settings: settings, builder: (context) => SignupScreen(number: number));
  }

  static _signupCompanyInfo(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => const SignupCompanyInfo());
  }

  static _scheduleScreen(RouteSettings settings) {
    var isFirst = settings.arguments as bool;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => ScheduleScreen(
              isFirst: isFirst,
            ));
  }

  static _subscriptionScreen(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => const SubscriptionScreen());
  }

  static _homeScreen(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => const HomeScreen());
  }

  static _dashboard(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => const Dashboard());
  }



  static _addStopsScreen(RouteSettings settings) {
    var currentLocation = settings.arguments as LatLng;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => AddStopsScreen(currentLocation: currentLocation));
  }

  static _stopMapScreen(RouteSettings settings) {
    var data = settings.arguments as Data;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => StopMapScreen(
              data: data,
            ));
  }

  static _stopQrScreen(RouteSettings settings) {
    // var qrImage = settings.arguments as String;
    Data stopData = settings.arguments as Data;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => StopQrScreen(stopData: stopData));
  }

  static _editRouteScreen(RouteSettings settings) {
    var routeData = settings.arguments as RData;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => MultiBlocProvider(providers: [
          BlocProvider<EditRouteStopCubit>(
            create: (context) => EditRouteStopCubit()),
          BlocProvider<EditRouteMapCubit>(
            create: (context) => EditRouteMapCubit()),
        ],
              // create: (context) => EditRouteStopCubit(),
              child: EditRouteScreen(routeData: routeData),
            ));
  }

  static _addRouteScreen(RouteSettings settings) {
    var currentLocation = settings.arguments as LatLng;
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => MultiBlocProvider(providers: [
        BlocProvider<AddRouteCubit>(
            create: (context) => AddRouteCubit()),
        BlocProvider<AddRouteMapCubit>(
            create: (context) => AddRouteMapCubit()),
      ],
        
        child: AddRouteScreen(currentLocation: currentLocation),
      ),
    );
  }

  static _routeMapScreen(RouteSettings settings) {
    var data = settings.arguments as RData;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => RouteMapScreen(routeData: data));
  }

  static _profileTabScreen(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => ProfileTabScreen());
  }

  static _personalInfoScreen(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => PersonalInfoScreen());
  }

  static _myQrScreen(RouteSettings settings) {
    var data = settings.arguments as List<String>;
    return MaterialPageRoute(
        settings: settings, builder: (context) => MyQrScreen(data: data));
  }

  static _approvedOnMapScreen(RouteSettings settings) {
    var data = settings.arguments as DataR;
    return MaterialPageRoute(
        settings: settings, builder: (context) => ApprovedOnMapScreen(data: data));
  }

  static _pendingOnMapScreen(RouteSettings settings) {
    var reqData = settings.arguments as DataR;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => PendingOnMapScreen(reqData: reqData));
  }

  static _companyInfoScreen(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings, builder: (context) => CompanyInfoScreen());
  }

  static _routeOnMapScreen(RouteSettings settings) {
    var routeData = settings.arguments as StartRouteReqModel;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) => RouteOnMapScreen(routeDataa: routeData));
  }
}
 