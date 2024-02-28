import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/login/login_cubit.dart';
import 'package:tagmevendor/logic/cubits/login/login_state.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/bottomsheet_widget.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/constants/assets_base_path.dart';
import '../../../core/constants/font_weight.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {


  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  late final Connectivity _connectivity;
  bool isInternet = true;
  Future<bool> _isInternetAvailable() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener< InternetCubit, bool>(
          listener: (context, state){
            if(state == true) {
              isInternet = true;
            } else {
              isInternet = false;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Image.asset("$pngAssetsBasePath/bus.png", fit: BoxFit.fill,),
                      SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    left: 24,
                    bottom: 0,
                    child: Image.asset(
                      "$pngAssetsBasePath/first_logo.png",
                      height: 150,
                      width: 180,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  "Tack Me Notification app allows food trucks to notify customers when they are onsite.",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 21,
                          fontWeight: normal,
                          color: grey374151Color)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  "We incorporate technology to optimise sales and facilitates seamless communication with customers",
                  // textAlign: TextAlign.left,
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: normal,
                          color: grey374151Color)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  // child: CustomTextFeild(
                  //   // focusNode: _focusNode,
                  //   controller: _mobileController,
                  //   hintText: "Enter mobile number",
                  //   fontsize: 18,
                  //   maxLength: 10,
                  //   keyboardType: TextInputType.phone,
                  //   validator: (value) {
                  //     if (value!.length != 10) {
                  //       return "Empty mobile number";
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  child: SizedBox(
                        width: double.infinity,
                        // height: 45,
                        child: TextFormField(
                          controller: _mobileController,
                          maxLength: 10,
                          validator: (value) {
                            if (value!.length != 10) {
                              return "Empty mobile number";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: normal,
                            // color: mediumGrey9CA3AFColor
                          )),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: black111011Color,
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: "", //// to show the counter remove it
                            isCollapsed: true,
                            // errorText: "Wrong No.",
        
                            labelStyle: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: mediumGrey9CA3AFColor)),
                            hintText: "Enter mobile number",
                            hintStyle: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: mediumGrey9CA3AFColor,
                                    fontSize: 16,
                                    fontWeight: normal)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13.11, vertical: 12.5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: lightGreyF6F6F6Color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, color: lightGreyF6F6F6Color),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, color: lightGreyF6F6F6Color),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, color: lightGreyF6F6F6Color),
                            ),
                            errorBorder: OutlineInputBorder(
                              // gapPadding: 2,
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 1, color: redCA1F27Color),
                            ),
        
                            filled: true,
                            fillColor: lightGreyF6F6F6Color,
                          ),
                        ),
                      )
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if(state is LoginResponseState){
                    if(state.response.status == true){
                      showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: LoginOtpBottomSheet(
                                      number: _mobileController.text
                                          .toString()),
                                );
                              },
                            );
                    }
                    
                  }
                  if(state is LoginErrorState){
                      showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, state.error)
                    );
                  }
                },
                builder: (context, state) {
                  if(state is LoginLoadingState){
                    return const Center(child: CircularProgressIndicator(color: redCA1F27Color,),);
                  }
                  return 
              Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: CustomMainButton(
                        color: redCA1F27Color,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // BlocProvider.of<LoginCubit>(context).getLoginOtp(_mobileController.text.trim());
                            // if(await _isInternetAvailable()){
                            //   BlocProvider.of<LoginCubit>(context).getLoginOtp(_mobileController.text.trim());
                            if(isInternet){
                              BlocProvider.of<LoginCubit>(context).getLoginOtp(_mobileController.text.trim());
                            }
                            else{
                              showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                            }
                          } 
                          // else if(await _isInternetAvailable()){
        
                          // }
                        },
                        label: "Send OTP",
                      ));
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
