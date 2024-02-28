import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import '../../logic/debug/app_bloc_observer.dart';
import '../../presentation/router/app_router.dart';
import '../themes/app_theme.dart';

/// used to set theme and navigations.
class App extends StatefulWidget {
  final bool isLoggedin;
  final String status;
  const App({Key? key, required this.isLoggedin, required this.status}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}
 
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return kReleaseMode ? _releaseWidget() : _debugWidget();
  }
 
  /// release mode material app.
  _releaseWidget() => MaterialApp(
        title: "Tack Me Vendor",
        theme: appLightTheme(context),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRouter.navigatorKey,
        // initialRoute: widget.isLoggedin ? AppRouter.dashboard : AppRouter.login ,
        initialRoute: widget.isLoggedin ? 
              widget.status == "company" ? AppRouter.signupCompanyInfo :
                  widget.status == "schedule" ? AppRouter.scheduleScreen :
                      widget.status == "complete" ? AppRouter.dashboard : AppRouter.login
          : AppRouter.login,
        
        onGenerateRoute: AppRouter.onGenerateRoute,
        builder: (context, child) {
          child = _responsiveWrapperWidget(child!);
          return EasyLoading.init()(context, child);
        },
      );

  /// debug mode material app.
  _debugWidget() => BlocOverrides.runZoned(
      () => DevicePreview(
            enabled: true,
            builder: (context) => MaterialApp(
              title: "Tack Me Vendor",
              theme: appLightTheme(context),
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              navigatorKey: AppRouter.navigatorKey,
              // initialRoute: widget.isLoggedin ? AppRouter.dashboard : AppRouter.login,
              initialRoute: widget.isLoggedin ? 
              widget.status == "company" ? AppRouter.signupCompanyInfo :
                  widget.status == "schedule" ? AppRouter.scheduleScreen :
                      widget.status == "complete" ? AppRouter.dashboard : AppRouter.login
          : AppRouter.login,
              onGenerateRoute: AppRouter.onGenerateRoute,
              useInheritedMediaQuery: true,
              builder: (context, child) {
                child = _responsiveWrapperWidget(child!);
                child = DevicePreview.appBuilder(context, child);
                return EasyLoading.init()(context, child);
              },
            ), // Wrap your app
          ),
      blocObserver: AppBlocObserver()
  );

  /// used to make responsive. set breakpoint here.
  _responsiveWrapperWidget(Widget child) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, child),
        breakpoints: const [
          ResponsiveBreakpoint.resize(320, name: MOBILE),
          ResponsiveBreakpoint.autoScale(450, name: TABLET),
        ],
      );
}
