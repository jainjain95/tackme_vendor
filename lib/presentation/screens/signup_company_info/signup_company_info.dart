import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/add_com_info/add_com_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_com_info/add_com_info_state.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/models/business_category_model.dart';
import 'package:tagmevendor/models/req_model/com_info_req_model.dart';
import 'package:tagmevendor/presentation/screens/signup_company_info/widget/upload_image_bottom_sheet.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../router/app_router.dart';

class SignupCompanyInfo extends StatefulWidget {
  const SignupCompanyInfo({super.key});

  @override
  State<SignupCompanyInfo> createState() => _SignupCompanyInfoState();
}

class _SignupCompanyInfoState extends State<SignupCompanyInfo> {
  File? _image;
  FocusNode nameFocus = FocusNode();
  FocusNode webFocus = FocusNode();
  FocusNode additionalFocus = FocusNode();
  TextEditingController _cName = TextEditingController();
  TextEditingController _webName = TextEditingController();
  TextEditingController _addInfo = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  BusinessCategoryModel? category;
  bool isDropdLoading = true;
  bool isInternet = true;
  // List<BData> categoryList = [];
  List<ValueItem> categoryList = [];
  final MultiSelectController _controller = MultiSelectController();
  List<String> _selectedCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  void getCategory() async {
    category = await AuthRepository.getCategory();
    // categoryList = category!.data!;
    for (int i = 0; i < category!.data!.length; i++) {
      categoryList.add(ValueItem(
          label: category!.data![i].name.toString(),
          value: category!.data![i].id.toString()));
    }
    print(categoryList);

    setState(() {
      isDropdLoading = false;
      _controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final MultiSelectController _controller = MultiSelectController();
    _controller.setOptions(categoryList);
    return InkWell(
      onTap: () {
        nameFocus.unfocus();
        webFocus.unfocus();
        additionalFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteFFFFFFColor,
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 24),
          //   child: InkWell(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: const Icon(
          //         Icons.arrow_back_ios,
          //         size: 20,
          //           color: greyicon374151Color
          //       )),
          // ),
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: BlocListener<InternetCubit, bool>(
                      listener: (context, state){
                        if (state == true) {
                      isInternet = true;
                      getCategory();
                    } else {
                      isInternet = false;
                    }
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24),
                            child: FittedBox(
                              child: Text(
                                "Company's information",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: bold,
                                        color: black111011Color)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: _image != null
                                      ? Image.file(_image!, fit: BoxFit.cover)
                                      : Image.asset(
                                          "$pngAssetsBasePath/company_background.png",
                                          fit: BoxFit.cover)),
                              Positioned(
                                  bottom: 10,
                                  right: 24,
                                  child: InkWell(
                                    onTap: () async {
                                      var image = await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return UploadImageBottomSheet();
                                        },
                                      );
                                      setState(() {
                                        _image = image;
                                        print(_image);
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: whiteFFFFFFColor,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: grey374151Color,
                                        )),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24),
                            child: CustomTextFeild(
                                hintText: "Company name",
                                controller: _cName,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == "") {
                                    return "Invalid Name";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24),
                            child: CustomTextFeild(
                              hintText: "Company Website",
                              controller: _webName,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              child: MultiSelectDropDown(
                                showClearIcon: false,
                                controller: _controller,
                                onOptionSelected: (options) {
                                  List<String> items = [];
                                  for (var i = 0; i < options.length; i++) {
                                    items.add(options[i].value.toString());
                                  }
                                  _selectedCategory = items;
                                  print(_selectedCategory);
                                },
                                backgroundColor: lightGreyF6F6F6Color,
                                borderWidth: 0.0,
                                focusedBorderWidth: 0.0,
                                focusedBorderColor: Colors.white,
                                borderColor: Colors.white,
                                alwaysShowOptionIcon: true,
                                borderRadius: 10.0,
                                selectedOptionBackgroundColor: Colors.white,
                                 options: categoryList,
                                selectionType: SelectionType.multi,
                                chipConfig: ChipConfig(
                                  backgroundColor: lightGreyF6F6F6Color,
                                  labelColor: Colors.black,
                                  padding: EdgeInsets.all(0),
                                  spacing: 0,
                                  runSpacing: 0,
                                  radius: 0,
                                  deleteIcon: Icon(
                                    Icons.star,
                                    size: 0,
                                  ),
                                ),
                                dropdownHeight: 200,
                                // dropdo
                                hint: isDropdLoading
                                    ? 'Loading'
                                    : 'Business Category',
                    
                                hintStyle: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: normal,
                                        color: mediumGrey9CA3AFColor)),
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionTextColor: redCA1F27Color,
                                // selectedOptionIcon: Icon(Icons.check, size: 0,)
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextField(
                                controller: _addInfo,
                                maxLines: 4,
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
                          ),
                          const SizedBox(height: 20),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child:
                                  BlocConsumer<AddComInfoCubit, AddComInfoState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                  if (state is AddComInfoResponseState) {
                                    if (state.response.status == true) {
                                      Helper.saveStatus("company");
                                      showTopSnackBar(
                                          Overlay.of(context),
                                          customSuccessSnackBar(context,
                                              "Company Infomation Saved"));
                                      AppRouter.navigatorKey.currentState
                                          ?.pushNamedAndRemoveUntil(
                                              AppRouter.scheduleScreen,
                                              arguments: true,
                                              (route) => false);
                                    }
                                  }
                                  if (state is AddComInfoErrorState) {
                                    showTopSnackBar(
                                        Overlay.of(context),
                                        customErrorSnackBar(
                                            context, "Internal Server Error"));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AddComInfoLoadingState) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                            color: redCA1F27Color));
                                  }
                                  return CustomMainButton(
                                      color: redCA1F27Color,
                                      onTap: () {
                                        if (_formKey.currentState!.validate() &&
                                            _image != null &&
                                            _selectedCategory.length != 0) {

                                          ComInfoReqModel req = ComInfoReqModel(
                                              companyName: _cName.text.trim(),
                                              companyWebsite:
                                                  _webName.text.trim(),
                                              companyAdditionalInfo:
                                                  _addInfo.text.trim(),
                                              businessCategory: _selectedCategory,
                                              image: _image!.path.toString());
                                          // BlocProvider.of<AddComInfoCubit>(
                                          //         context)
                                          //     .addInfo(req);

                                          if(isInternet){
                                            BlocProvider.of<AddComInfoCubit>(
                                                  context)
                                              .addInfo(req);
                                          }else {
                                            showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                                          }
                                        } else if (_image == null) {
                                          showTopSnackBar(
                                              Overlay.of(context),
                                              customErrorSnackBar(context,
                                                  "Please Choose Company\'s Image"));
                                        } else if (_selectedCategory.length ==
                                            0) {
                                          showTopSnackBar(
                                              Overlay.of(context),
                                              customErrorSnackBar(context,
                                                  "Please Choose Business Category"));
                                        }
                                      },
                                      label: "SUBMIT");
                                },
                              )),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
