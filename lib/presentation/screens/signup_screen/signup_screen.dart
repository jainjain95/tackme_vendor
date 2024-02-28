import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_cubit.dart';
import 'package:tagmevendor/logic/cubits/signup/signup_state.dart';
import 'package:tagmevendor/models/req_model/sign_up_req_model.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/message_Error_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/message_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/constants/font_weight.dart';
import '../../router/app_router.dart';

class SignupScreen extends StatefulWidget {
  String number;
  SignupScreen({super.key, required this.number});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FocusNode additionalFocus = FocusNode();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _regoController = TextEditingController();
  TextEditingController _addtionalController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isInternet = true;

  @override
  void initState() {
    _mobileController = TextEditingController(text: widget.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SignupCubit sign_cubit = BlocProvider.of<SignupCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteFFFFFFColor,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 24),
        //   child: InkWell(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: const Icon(Icons.arrow_back_ios,
        //           size: 20, color: greyicon374151Color)),
        // ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: BlocListener<InternetCubit, bool>(
                  listener: (context, state) {
                    if (state == true) {
                      isInternet = true;
                    } else {
                      isInternet = false;
                    }
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            "Create New Profile",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: bold,
                                    color: black111011Color)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "If you are the customer, please download the Customer Tack Me App.",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                  color: grey374151Color)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFeild(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          hintText: "Your name",
                          fontsize: 16,
                          validator: (value) {
                            if (value!.length < 2) {
                              return "Invalid Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFeild(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                          fontsize: 16,
                          validator: (value) {
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value!)) {
                              return "Invalid email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFeild(
                          enable: false,
                          // hintText: widget.number,
                          controller: _mobileController,
                          fontsize: 16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFeild(
                          controller: _regoController,
                          keyboardType: TextInputType.text,
                          hintText: "Food Truck Rego (optional)",
                          fontsize: 16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          // height: 48,
                          child: TextField(
                            controller: _addtionalController,
                            focusNode: additionalFocus,
                            maxLines: 5,
                            cursorColor: black111011Color,
                            decoration: InputDecoration(
                              floatingLabelStyle:
                                  MaterialStateTextStyle.resolveWith(
                                (Set<MaterialState> states) {
                                  final Color color =
                                      states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : black111011Color;
                                  return TextStyle(color: color, fontSize: 20);
                                },
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 13.11, right: 13.11, top: 14.4),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: lightGreyF6F6F6Color),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 1, color: lightGreyF6F6F6Color),
                              ),
                              filled: true,
                              fillColor: lightGreyF6F6F6Color,
                              hintText: "Additional Text (50 chars max)",
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color: mediumGrey9CA3AFColor,
                                      fontSize: 16,
                                      fontWeight: normal)),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        const SizedBox(height: 20),
                        BlocConsumer<SignupCubit, SignupState>(
                          listener: (context, state) {
                            if (state is SignupResponseState) {
                              if (state.response.status == true) {
                                Helper.saveStatus("company");
                                showTopSnackBar(
                                    Overlay.of(context),
                                    customSuccessSnackBar(
                                        context, "User Created"));
                                AppRouter.navigatorKey.currentState
                                    ?.pushNamedAndRemoveUntil(
                                        AppRouter.signupCompanyInfo,
                                        (route) => false);
                              }
                            }
                            if (state is SignupErrorState) {
                              showTopSnackBar(Overlay.of(context),
                                  customErrorSnackBar(context, state.error));
                            }
                          },
                          builder: (context, state) {
                            if (state is SignupLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: redCA1F27Color));
                            }

                            return CustomMainButton(
                                color: redCA1F27Color,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("Valid");
                                    // SignupReqModel req = SignupReqModel(
                                    //     name: _nameController.text.trim(),
                                    //     email: _emailController.text.trim(),
                                    //     dialCode: "+91",
                                    //     number: widget.number,
                                    //     additionalInfo:
                                    //         _addtionalController.text.trim(),
                                    //     foodTruckRego:
                                    //         _regoController.text.trim());
                                    // sign_cubit.signup(req);

                                    if(isInternet){
                                      SignupReqModel req = SignupReqModel(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        dialCode: "+91",
                                        number: widget.number,
                                        additionalInfo:
                                            _addtionalController.text.trim(),
                                        foodTruckRego:
                                            _regoController.text.trim());
                                    sign_cubit.signup(req);
                                    } else {
                                      showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                                    }
                                  }
                                },
                                label: "Sign Up");
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
