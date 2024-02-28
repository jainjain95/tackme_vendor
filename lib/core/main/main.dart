import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bloc_and_repository_app.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';

///        flutter verton Channel stable, 3.10.5
Future<void> main() async {

  // set orientation of app.
  WidgetsFlutterBinding.ensureInitialized();  
  final isLoggedin = (await Helper.getUserIdData()) != "";
  var status = await Helper.getStatus();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await Future.delayed(const Duration(seconds: 2))
        .then((value) => FlutterNativeSplash.remove());
    runApp(BlocAndRepositoryApp(isLoggedin: isLoggedin, status: status));
  });
}
 