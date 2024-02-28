import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagmevendor/logic/cubits/add_com_info/add_com_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_route/add_route_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_route_map/add_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_route_poly/add_route_poly_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_stop/add_stop_cubit.dart';
import 'package:tagmevendor/logic/cubits/approved/approved_cubit.dart';
import 'package:tagmevendor/logic/cubits/company_info/company_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/edit_route_map/edit_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/get_company_info/get_com_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/get_polyline/get_polyline_cubit.dart';
import 'package:tagmevendor/logic/cubits/login/login_cubit.dart';
import 'package:tagmevendor/logic/cubits/new_number/new_number_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending_req_btmsheet_cubit.dart/pending_req_btmsheet_cubit.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_cubit.dart';
import 'package:tagmevendor/logic/cubits/resend_otp/resend_otp_cubit.dart';
import 'package:tagmevendor/logic/cubits/route/route_cubit.dart';
import 'package:tagmevendor/logic/cubits/route_info/route_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_cubit.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_cubit.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_cubit.dart';
import 'package:tagmevendor/logic/cubits/verify_otp/verify_otp_cubit.dart';
import '../../data/repository/auth_repository.dart';
import '../../logic/cubits/internet/internet_cubit.dart';
import 'app.dart';

/// Add app level repositories and cubits.
class BlocAndRepositoryApp extends StatelessWidget {
  final bool isLoggedin;
  final String status;
  const BlocAndRepositoryApp({Key? key,  required this.isLoggedin, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      
      child: MultiBlocProvider(providers: [
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit()),
        BlocProvider<VOtpCubit>(
            create: (context) => VOtpCubit()),
        BlocProvider<ScheduleCubit>(
            create: (context) => ScheduleCubit()),
        BlocProvider<SignupCubit>(
            create: (context) => SignupCubit()),
        BlocProvider<LoginCubit>(
            create: (context) => LoginCubit()),
        BlocProvider<StopCubit>(
            create: (context) => StopCubit()),
        BlocProvider<AddStopCubit>(
            create: (context) => AddStopCubit()),
        BlocProvider<AddComInfoCubit>(
            create: (context) => AddComInfoCubit()),
        BlocProvider<RouteCubit>(
            create: (context) => RouteCubit()),
        BlocProvider<RouteInfoCubit>(
            create: (context) => RouteInfoCubit()),
        BlocProvider<AddRoutePolyCubit>(
            create: (context) => AddRoutePolyCubit()),
        BlocProvider<ProfileTabCubit>(
            create: (context) => ProfileTabCubit()),
        BlocProvider<GetComInfoCubit>(
            create: (context) => GetComInfoCubit()),
        BlocProvider<GetPersonalInfoCubit>(
            create: (context) => GetPersonalInfoCubit()),
        BlocProvider<NewNumberCubit>(
            create: (context) => NewNumberCubit()),
        BlocProvider<PendingCubit>(
            create: (context) => PendingCubit()),
        BlocProvider<ApprovedCubit>(
            create: (context) => ApprovedCubit()),
        BlocProvider<PendingReqBtmSheetCubit>(
            create: (context) => PendingReqBtmSheetCubit()),
        BlocProvider<ResendOtpCubit>(
            create: (context) => ResendOtpCubit()),
        BlocProvider<StartRouteMapCubit>(
            create: (context) => StartRouteMapCubit()),
        BlocProvider<GetPolylineCubit>(
            create: (context) => GetPolylineCubit()),
        BlocProvider<ComapnyInfoCubit>(
            create: (context) => ComapnyInfoCubit()),
      ], child: App(isLoggedin: isLoggedin, status: status,)),
    );
  }
}













