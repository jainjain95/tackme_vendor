import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/new_number/new_number_cubit.dart';
import 'package:tagmevendor/logic/cubits/new_number/new_number_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/personal_info_screen/widgets/enter_otp_bottom_sheet.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EnterMobileBottomSheet extends StatefulWidget {
  const EnterMobileBottomSheet({super.key});

  @override
  State<EnterMobileBottomSheet> createState() => _EnterMobileBottomSheetState();
}

class _EnterMobileBottomSheetState extends State<EnterMobileBottomSheet> {
  TextEditingController number = TextEditingController();
  GlobalKey<FormState> _formKeyN = new GlobalKey<FormState>();
  bool isInternet = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          // You can customize the content of the bottom sheet here
          // height: double.infinity,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enter new number",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: bold,
                                color: darkBlack000000Color)),
                      ),
                      InkWell(
                          onTap: () {
                            AppRouter.navigatorKey.currentState?.pop();
                          },
                          child: SvgPicture.asset(
                              "$svgAssetsBasePath/cancel_icon.svg"))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKeyN,
                      child: SizedBox(
                        width: double.infinity,
                        // height: 45,
                        child: TextFormField(
                          controller: number,
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
                  const SizedBox(height: 24),
                  BlocConsumer<NewNumberCubit, NewNumberState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is NewNumberResponseState) {
                        if (state.response.status == true) {
                          AppRouter.navigatorKey.currentState?.pop();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).viewInsets.bottom),
                                child: EnterOtpBottomSheetWidget(
                                  number: number.text,
                                ),
                              );
                            },
                          );
                        }
                      }
                      if (state is NewNumberErrorState) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertMessageDialog(error: state.error);
                            });
                      }
                    },
                    builder: (context, state) {
                      if (state is NewNumberLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: redCA1F27Color,
                          ),
                        );
                      }
                      return CustomMainButton(
                          color: redCA1F27Color,
                          onTap: () {
                            if (_formKeyN.currentState!.validate()) {
                              

                              if(isInternet){
                                BlocProvider.of<NewNumberCubit>(context)
                                  .getNewNumberOtp(number.text.trim());
                              } else {
                                showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                              }
                            }
                          },
                          label: "SEND OTP");
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
