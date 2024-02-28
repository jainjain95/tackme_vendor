import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/new_number/new_number_cubit.dart';
import 'package:tagmevendor/logic/cubits/new_number/new_number_state.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/verify_otp/verify_otp_cubit.dart';
import 'package:tagmevendor/logic/cubits/verify_otp/verify_otp_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EnterOtpBottomSheetWidget extends StatefulWidget {
  String number;
  EnterOtpBottomSheetWidget({super.key, required this.number});

  @override
  State<EnterOtpBottomSheetWidget> createState() =>
      _EnterOtpBottomSheetWidgetState();
}

class _EnterOtpBottomSheetWidgetState extends State<EnterOtpBottomSheetWidget> {
  FocusNode focusNode = FocusNode();
  String? otp;
  bool check = false;
  bool isInternet = true;

  @override
  Widget build(BuildContext context) {
    final VOtpCubit cubit = BlocProvider.of<VOtpCubit>(context);
    return InkWell(
      onTap: () {
        focusNode.unfocus();
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener< InternetCubit, bool>(
            listener: (context, state){
            if(state == true){
              isInternet = true;
            } else {
              isInternet = false;
            }
          },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Enter OTP",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: bold,
                              color: darkBlack000000Color)),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          AppRouter.navigatorKey.currentState?.pop();
                        },
                        child: SvgPicture.asset(
                            "$svgAssetsBasePath/cancel_icon.svg"))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Please enter the OTP sent on mobile",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: normal,
                          color: mediumBlack6F6F6FColor)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "+61-" +
                          widget.number.substring(0, 2) +
                          "XXXX" +
                          widget.number.substring(6, 9),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: normal,
                              color: mediumBlack6F6F6FColor)),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "(Change number)",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: bold,
                                color: mediumBlack6F6F6FColor)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: PinCodeTextField(
                    focusNode: focusNode,
                    // controller: otpController,
                    textStyle: TextStyle(fontSize: 15),
                    appContext: context,
                    // pastedTextStyle: TextStyle(
                    //   color: Colors.green.shade600,
                    //   fontWeight: medium,
                    // ),
                    length: 6,
                    // obscureText: true,
                    // obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        activeFillColor: mediumDarkGreyF1F1F1Color,
                        inactiveColor: mediumDarkGreyF1F1F1Color,
                        inactiveFillColor: mediumDarkGreyF1F1F1Color,
                        selectedFillColor: mediumDarkGreyF1F1F1Color,
                        selectedColor: mediumDarkGreyF1F1F1Color,
                        activeColor: mediumDarkGreyF1F1F1Color),
                    cursorColor: black111011Color,
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      setState(() {
                        otp = v;
                        check = true;
                      });
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      // setState(() {
                      // currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
                BlocConsumer<VOtpCubit, VOtpState>(
                  listener: (context, state) {
                    if (state is VOtpAndUpdateNumberResponseState) {
                      showTopSnackBar(
                        Overlay.of(context),
                        customSuccessSnackBar(context, "Mobile Number Updated")
                    );                    
                      AppRouter.navigatorKey.currentState?.pop();
                      BlocProvider.of<GetPersonalInfoCubit>(context)
                          .getPersonalInfo();
                    }
                    if( state is VOtpErrorState){
                      showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, state.error)
                    );
                    }
                  },
                  builder: (context, state) {
                    if (state is VOtpLoadingState) {
                      return Center(
                          child:
                              CircularProgressIndicator(color: redCA1F27Color));
                    }
                    return CustomMainButton(
                      color: redCA1F27Color,
                      onTap: check
                          ? () {
                              
                              if(isInternet){
                                cubit.verifyOtpAndUpdateNumber(widget.number, otp!);
                              } else {
                                showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                              }
                            
                            }
                          : () {
                            showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Enter Valid OTP")
                    );
                          },
                      label: "SUBMIT",
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  const Expanded(
                      child: Divider(
                    thickness: 1,
                    color: lightBlackC9C9C9Color,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Didn't receive the code",
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: normal,
                            color: mediumBlack6F6F6FColor)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                      child: Divider(
                    thickness: 1,
                    color: lightBlackC9C9C9Color,
                  )),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: BlocConsumer<NewNumberCubit, NewNumberState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is NewNumberResponseState) {
                        if (state.response.status == true) {
                          // showDialog(context: context, 
                          // builder: (context){
                          //   return AlertMessageDialog(error: "OTP Sent",);
                          // }
                          // );
                          showTopSnackBar(
                        Overlay.of(context),
                        customSuccessSnackBar(context, state.response.message.toString())
                    );
                        }
                      }
                      if(state is NewNumberErrorState){
                        showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, state.error)
                    );
                      }
                    },
                    builder: (context, state) {
                      if (state is NewNumberLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: redCA1F27Color,
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          if(isInternet){
                            BlocProvider.of<NewNumberCubit>(context)
                              .getNewNumberOtp(widget.number);
                          } else {
                            
                            showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                          }
                        },
                        child: Text(
                          "Resend OTP",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: bold,
                                  color: mediumBlack6F6F6FColor)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
