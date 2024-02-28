import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_state.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_cubit.dart';
import 'package:tagmevendor/models/req_model/update_all_user_data_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/personal_info_screen/widgets/enter_mobile_bottomsheet.dart';
import 'package:tagmevendor/presentation/screens/personal_info_screen/widgets/enter_otp_bottom_sheet.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';

import '../../../core/constants/font_weight.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _compName = TextEditingController();
  TextEditingController _truckRego = TextEditingController();
  GlobalKey<FormState> _personalformKey = new GlobalKey<FormState>();
  String number = "";
  TextEditingController? _bio;
  bool isLoading = false;
  bool isButtonEnable = false;
  SignupModel? userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPersonalInfoCubit>(context).getPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: greyicon374151Color)),
          ),
          title: Text(
            "Personal Information",
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: black111011Color)),
          ),
        ),
        body: BlocBuilder<InternetCubit, bool>(builder: (context, state) {
          if (state == false) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    "$svgAssetsBasePath/robot_connection_error.svg"),
                const SizedBox(
                  height: 10,
                ),
                Text("Connection failed, Please check your\nnetwork settings",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: black111011Color,
                            fontWeight: semiBold))),
              ],
            ));
          }
          return Padding(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 5),
              child: BlocConsumer<GetPersonalInfoCubit, PersonalInfoState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is PersonalInfoResponseState) {
                    _name = TextEditingController(
                        text: state.response.data!.name.toString());
                    _compName = TextEditingController(
                        text: state.response.data!.companyInfo!.companyName
                            .toString());
                    _truckRego = TextEditingController(
                        text: state.response.data!.foodTruckRego.toString());
                    number =
                        state.response.data!.phoneNumber!.number.toString();
                    _bio = TextEditingController(
                        text: state.response.data!.additionalInfo.toString());

                    userData = state.response;
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print(userData!.data!.companyInfo!.image.toString());
                  }
                },
                builder: (context, state) {
                  if (state is PersonalInfoResponseState) {
                    return SingleChildScrollView(
                      child: Form(
                        key: _personalformKey,
                        onChanged: () {
                          setState(() {
                            isButtonEnable = true;
                          });
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            heading("Name"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFeild(
                              hintText: "Your Name",
                              controller: _name,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            heading("Company Name"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFeild(
                              hintText: "Company Name",
                              controller: _compName,
                              // initialText: state.response.data!.companyInfo!.companyName.toString(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            heading("Food Tuck Rego"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFeild(
                              hintText: "Optional",
                              controller: _truckRego,
                              // initialText:
                              //     state.response.data!.foodTruckRego.toString(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            heading("Mobile Number"),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                                height: 48,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.fromLTRB(13, 14, 13, 14),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: lightGreyF6F6F6Color),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      number!,
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: normal,
                                        // color: mediumGrey9CA3AFColor
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return EnterMobileBottomSheet();
                                          },
                                        );
                                      },
                                      child: Text("Change",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: redCA1F27Color,
                                                  fontWeight: normal))),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            heading("Bio"),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                // focusNode: focusNode,
                                // keyboardType: TextInputType.number,
                                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                // initialValue: state.response.data!.additionalInfo.toString(),
                                maxLines: 4,
                                controller: _bio,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                keyboardType: TextInputType.multiline,
                                cursorColor: black111011Color,
                                decoration: InputDecoration(
                                  hintText: "Additional Text (50 chars max)",
                                  hintStyle: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                    color: mediumGrey9CA3AFColor,
                                  )),
                                  // labelText: labelText,
                                  // labelStyle: GoogleFonts.openSans(textStyle: const TextStyle(color: mediumGrey9CA3AFColor, )),
                                  floatingLabelStyle:
                                      MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                      final Color color = states
                                              .contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : black111011Color;
                                      return TextStyle(
                                          color: color, fontSize: 20);
                                    },
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(13, 14, 13, 14),
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
                                  // hintText: hintText,
                                  // hintStyle: GoogleFonts.openSans(
                                  //     textStyle: const TextStyle(
                                  //         color: mediumGrey9CA3AFColor, fontSize: 15)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is PersonalInfoErrorState) {
                    return Center(child: Text("Something Went Wrong"));
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: redCA1F27Color),
                  );
                },
              ));
        }),
        bottomNavigationBar: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: redCA1F27Color))
            : Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 35),
                child: CustomMainButton(
                    color:
                        isButtonEnable ? redCA1F27Color : redLightFFD6D8Color,
                    onTap: isButtonEnable == true
                        ? () async {
                            List<String> businesList = [];
                            for (int i = 0;
                                i <
                                    userData!.data!.companyInfo!
                                        .businessCategory!.length;
                                i++) {
                              businesList.add(userData!
                                  .data!.companyInfo!.businessCategory![i].id
                                  .toString());
                            }
                            UpdateAllUserDataReqModel req =
                                UpdateAllUserDataReqModel(
                                    name: _name.text.trim(),
                                    additionalInfo: _bio!.text.trim(),
                                    dialCode: '+91',
                                    number: userData!.data!.phoneNumber!.number
                                        .toString(),
                                    foodTruckRego: _truckRego.text.trim(),
                                    companyName: _compName.text.trim(),
                                    companyWebsite: userData!
                                        .data!.companyInfo!.companyWebsite,
                                    companyAdditionalInfo: userData!.data!
                                        .companyInfo!.companyAdditionalInfo,
                                    image: userData!.data!.companyInfo!.image
                                        .toString(),
                                    businessCategory: businesList);

                            setState(() async {
                              isLoading = true;
                              await AuthRepository.updateProfileData(req)
                                  .then((value) {
                                if (value.status == true) {
                                  isLoading = false;

                                  BlocProvider.of<GetPersonalInfoCubit>(context)
                                      .getPersonalInfo();
                                  BlocProvider.of<ProfileTabCubit>(context)
                                      .getProfileInfo();
                                  setState(() {
                                    isButtonEnable = false;
                                  });
                                } else {
                                  isLoading = false;
                                }
                              });
                            });
                          }
                        : () {},
                    label: "Save Changes")));
  }

  Widget heading(String headName) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(headName,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  fontSize: 12,
                  color: greyicon374151Color,
                  fontWeight: semiBold))),
    );
  }

  Widget WidgetTextfieldnewstop(String labelText,
      {required FocusNode focusNode}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextField(
        focusNode: focusNode,
        // keyboardType: TextInputType.number,
        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursorColor: black111011Color,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: GoogleFonts.openSans(
              textStyle: const TextStyle(
            color: mediumGrey9CA3AFColor,
          )),
          // labelText: labelText,
          // labelStyle: GoogleFonts.openSans(textStyle: const TextStyle(color: mediumGrey9CA3AFColor, )),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : black111011Color;
              return TextStyle(color: color, fontSize: 20);
            },
          ),
          contentPadding: const EdgeInsets.fromLTRB(13, 14, 13, 14),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: lightGreyF6F6F6Color),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: lightGreyF6F6F6Color),
          ),
          filled: true,
          fillColor: lightGreyF6F6F6Color,
          // hintText: hintText,
          // hintStyle: GoogleFonts.openSans(
          //     textStyle: const TextStyle(
          //         color: mediumGrey9CA3AFColor, fontSize: 15)),
        ),
      ),
    );
  }
}
