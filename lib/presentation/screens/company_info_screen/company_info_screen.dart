import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/data/repository/auth_repository.dart';
import 'package:tagmevendor/logic/cubits/company_info/comapny_info_state.dart';
import 'package:tagmevendor/logic/cubits/company_info/company_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/get_company_info/get_com_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/get_company_info/get_com_info_state.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_cubit.dart';
import 'package:tagmevendor/logic/cubits/personal_info/personal_info_state.dart';
import 'package:tagmevendor/logic/cubits/profile_tab/profile_tab_cubit.dart';
import 'package:tagmevendor/models/business_category_model.dart';
import 'package:tagmevendor/models/req_model/update_all_user_data_model.dart';
import 'package:tagmevendor/models/signup_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/personal_info_screen/widgets/enter_otp_bottom_sheet.dart';
import 'package:tagmevendor/presentation/screens/signup_company_info/widget/upload_image_bottom_sheet.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';

import '../../../core/constants/font_weight.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {

  TextEditingController compName = TextEditingController();
  TextEditingController compWebsite = TextEditingController();
  bool isLoading = false;
  SignupModel? userData;
  File? _image;
  String imgPath = "";
  BusinessCategoryModel? category;
  bool isDropdLoading = true;
  List<String> _selectedCategory =[];  //new selected items
  List<ValueItem> categoryList=[];
  final MultiSelectController _controller = MultiSelectController();
  List<ValueItem> _selectedOption = [];    // to show on dropdown
  GlobalKey<FormState> _companyFormKey = new GlobalKey<FormState>();
  bool isButtonEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
    BlocProvider.of<GetPersonalInfoCubit>(context).getPersonalInfo();
  }

    void getCategory() async {
    category = await AuthRepository.getCategory();
    // categoryList = category!.data!;
    for(int i=0; i<category!.data!.length; i++){
      categoryList.add(ValueItem(
        label: category!.data![i].name.toString(),
        value: category!.data![i].id.toString()
      ));
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
    // _selectedOption.addAll(_controller.selectedOptions);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteFFFFFFColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
                color: greyicon374151Color
            )),
        title: Text(
          "Company’s information",
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  fontSize: 20, fontWeight: semiBold, color: black111011Color)),
        ),
      ),
      body: BlocBuilder< InternetCubit, bool>(
        
        builder: (context, state) {
          if(state == false){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "$svgAssetsBasePath/robot_connection_error.svg"
              ),
              const SizedBox(height: 10,),
              Text(
                              "Connection failed, Please check your\nnetwork settings",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: black111011Color, fontWeight: semiBold))
                ),
            ],
          )
        );
      }
          return  BlocConsumer<GetPersonalInfoCubit, PersonalInfoState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is PersonalInfoResponseState) {
              compName = TextEditingController(
                  text: state.response.data!.companyInfo!.companyName.toString());
              compWebsite = TextEditingController(
                  text: state.response.data!.companyInfo!.companyWebsite
                      .toString());
              userData = state.response;
              // print()
              // categoryList.where((element) =>
              //                                 element.value.toString() == state.response.data!.companyInfo!.businessCategory![0].id.toString())
              //                             .first;
              for(int i=0; i< state.response.data!.companyInfo!.businessCategory!.length; i++){
                ValueItem data =state.categoryList.where((element) =>
                                              element.value.toString() == state.response.data!.companyInfo!.businessCategory![i].id.toString())
                                          .first;
                _selectedOption.add(data);
                _selectedCategory.add(data.value.toString());
              }
              _selectedOption.addAll(_controller.selectedOptions);
            }
          },
          builder: (context, state) {
            if (state is PersonalInfoResponseState) {
              return SingleChildScrollView(
                child: Form(
                  key: _companyFormKey,
                  onChanged: (){
                    setState(() {
                      isButtonEnable = true;
                    });
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 140,
                            child: 
                            imgPath != ""
                                ? 
                                // Center(
                                //     child: Icon(
                                //     Icons.image,
                                //     size: 80,
                                //   ))
                                Image.file(_image!, fit: BoxFit.fill)
                                  
                                : CachedNetworkImage(
                                    imageUrl: state
                                        .response.data!.companyInfo!.image
                                        .toString(),
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
                                      return Center(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              color: redCA1F27Color),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          Positioned(
                              bottom: 10,
                              right: 24,
                              child: GestureDetector(
                                onTap: () async {
                                  var image = await showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: UploadImageBottomSheet(),
                                      );
                                    },
                                  );
                                  setState(() {
                                    _image = image;
                                    imgPath = _image!.path.toString();
                         
                          isButtonEnable = true;
                   
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 21,
                                    backgroundColor: lightGreyF6F6F6Color,
                                    child: Center(
                                        child: SvgPicture.asset(
                                      "$svgAssetsBasePath/camera.svg",
                                      height: 27,
                                      width: 27,
                                    ))),
                              ))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24, bottom: 25),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            heading("Company Name"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFeild(
                              hintText: "Company Name",
                              controller: compName,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            heading("Company’s Website"),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFeild(
                              hintText: "Company’s Website",
                              controller: compWebsite,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            heading("Food Category"),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                                height: 48,
                                width: double.infinity,
                                child: MultiSelectDropDown(
                                            showClearIcon: false,
                                            controller: _controller,
                                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,color: greyicon374151Color,size: 27),
                                            onOptionSelected: (options) {
                                              
                                              List<String> items=[];
                                              for(var i=0; i<options.length; i++){
                                                items.add(options[i].value.toString());
                                              }
                                              _selectedCategory=items;
                                              setState(() {
                                                isButtonEnable = true;
                                              });
                                            },
                                            selectedOptions: _selectedOption,
                                            backgroundColor: lightGreyF6F6F6Color,
                                            borderWidth: 0.0,
                                            focusedBorderWidth: 0.0,
                                            focusedBorderColor: Colors.white,
                                            borderColor: Colors.white,
                                            alwaysShowOptionIcon: true,
                                            borderRadius: 10.0,
                                            selectedOptionBackgroundColor: Colors.white,
                                            options: state.categoryList,
                                            selectionType: SelectionType.multi,
                                            chipConfig: ChipConfig(
                                              backgroundColor: lightGreyF6F6F6Color,
                                              labelColor: Colors.black,
                                              padding:  EdgeInsets.all(0),
                                              spacing: 0,
                                              runSpacing: 0,
                                              radius: 0,
                                              deleteIcon: Icon(Icons.star, size: 0,),
                                              
                                            ),
                                            dropdownHeight: 200,
                                            hint: isDropdLoading ? 'Loading' : 'Business Category',
                                            
                                            hintStyle: GoogleFonts.openSans(
                                            textStyle:  TextStyle(
                                                fontSize: 16,
                                                fontWeight: normal,
                                                color: mediumGrey9CA3AFColor
                                                )),
                                            optionTextStyle: const TextStyle(fontSize: 16),
                                            selectedOptionTextColor: redCA1F27Color,
                                          ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is PersonalInfoErrorState) {
              return Center(child: Text(state.error.toString()));
            }
            return const Center(
              child: CircularProgressIndicator(color: redCA1F27Color),
            );
          },
        );
      }
      ),
      bottomNavigationBar: BlocConsumer<ComapnyInfoCubit, CompanyInfoState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is CompanyInfoResponseState){
            if(state.response.status == true){
              _selectedCategory.clear();
              BlocProvider.of<GetPersonalInfoCubit>(context).getPersonalInfo();
            } 
            setState(() {
                        isButtonEnable = false;
                      });

          }
          if(state is CompanyInfoErrorState){
            showDialog(
              context: context, 
              builder: (context){
                return AlertMessageDialog(error: state.error);
              }
            );
          }
        },
        builder: (context, state) {
          if (state is CompanyInfoLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: redCA1F27Color));
          }
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 35),
            child: CustomMainButton(
              color: isButtonEnable ? redCA1F27Color : lightRedFFE3E4Color,
              label: 'Save Changes',
              onTap: isButtonEnable == true ?
              () {
                print("ttttttttttttttttttttttttttttttttttt");
                // print(imgPath);
                print(userData!.data!.phoneNumber.toString(),);
                UpdateAllUserDataReqModel req = UpdateAllUserDataReqModel(
                    name: userData!.data!.name.toString(),
                    additionalInfo: userData!.data!.additionalInfo.toString(),
                    dialCode: '+91',
                    number: userData!.data!.phoneNumber.toString(),
                    foodTruckRego: userData!.data!.foodTruckRego.toString(),
                    companyName: compName.text.trim(),
                    companyWebsite: compWebsite.text.trim(),
                    companyAdditionalInfo:
                        userData!.data!.companyInfo!.companyAdditionalInfo,
                    image: userData!.data!.companyInfo!.image.toString(),
                    businessCategory: _selectedCategory
                  );
                  BlocProvider.of<ComapnyInfoCubit>(context).updateCompInfo(req, imgPath);
                  // _selectedCategory.clear();
              } :
              (){},
            ),
          );
        },
      ),
      
    );
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
}
