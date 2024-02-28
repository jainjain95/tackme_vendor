import 'package:flutter/material.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/presentation/screens/dashboard/dashboard.dart';
import 'package:tagmevendor/presentation/screens/home_screen/home_screen.dart';
import 'package:tagmevendor/presentation/screens/login_screen/login_screen.dart';
import 'package:tagmevendor/presentation/screens/schedule_screen/schedule_screen.dart';
import 'package:tagmevendor/presentation/screens/signup_company_info/signup_company_info.dart';

class CheckLoginStatus extends StatefulWidget {
  const CheckLoginStatus({super.key});

  @override
  State<CheckLoginStatus> createState() => _CheckLoginStatusState();
}

class _CheckLoginStatusState extends State<CheckLoginStatus> {

  String? status;

  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  void getToken() async {
    // var token = Helper.getUserIdData();
    // if(token != null){
    //   isLoggedin = true;
    // } else {
    //   isLoggedin = false;
    // }
    status = await Helper.getStatus();
  }

  late bool isLoggedin;
  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    switch (status) {
            case "signup":
              // return SignupScreen(number: "1111111111");
              return SignupCompanyInfo();
            case "company":
              return SignupCompanyInfo();
            case "schedule":
              return ScheduleScreen(isFirst: true);
            case "complete":
              return Dashboard();
            case "":
              return LogInScreen();
            default:
              throw Exception("Route was not found");
            }
          }
}