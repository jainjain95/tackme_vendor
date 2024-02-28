import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_cubit.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';




import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';
import 'package:multiselect/multiselect.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddScheduleSheet extends StatefulWidget {
    

  AddScheduleSheet({super.key,});

  @override
  State<AddScheduleSheet> createState() => _AddScheduleSheetState();
}

class _AddScheduleSheetState extends State<AddScheduleSheet> {


  DateTime? startSelectedDate = DateTime.now();
  DateTime? endSelectedDate = DateTime.now();
  bool startSelected = true;
  bool endSelected = false;
  bool liveLocation = true;
  TextEditingController _schName = TextEditingController();
  List<String> _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thus', 'Fri', 'Sat'];
  List<String> _selectedItems = [];
  Datum? schedulData;
  bool isLoading = false;
  GlobalKey<FormState> _addSchFormKey = new GlobalKey<FormState>();
  bool isInternet = true;
  // final List<ValueItem> _selectedOptions = [];
  
  

   void _onItemChecked(String item) {

      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        selected.add(item);
      }
    setState(() {
      
    });
  }

  List<String> selected = [];
  List<String> showselected = ['jhbdh', 'bjbc'];

  @override
  Widget build(BuildContext acontext) {

    final MultiSelectController _controller = MultiSelectController();
    final ScheduleCubit cubit = BlocProvider.of<ScheduleCubit>(acontext);
    // _controller.addSelectedOption();
    return BlocListener< InternetCubit, bool>(
      listener: (context, state){
            if(state == true){
              isInternet = true;
            } else {
              isInternet = false;
            }
          },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRouter.navigatorKey.currentState?.pop();
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: semiBold,
                              color: redCA1F27Color)),
                    ),
                  ),
                  Text(
                    "Schedule",
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: bold,
                            color: darkBlack000000Color)),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(_addSchFormKey.currentState!.validate() && _selectedItems.isNotEmpty){
                        isLoading = true;
                        schedulData = Datum(
                        startTime: '${startSelectedDate!.hour.toString().padLeft(2, '0')}:'
                                  '${startSelectedDate!.minute.toString().padLeft(2, '0')}',
                        endTime: '${endSelectedDate!.hour.toString().padLeft(2, '0')}:'
                                  '${endSelectedDate!.minute.toString().padLeft(2, '0')}',
                        days: _selectedItems,
                        liveLocation: liveLocation,
                        scheduleName: _schName.text.trim()
                      );
                      // var a = cubit.addSchedule(schedulData!);
                      // cubit.getSchedule();
                      // AppRouter.navigatorKey.currentState?.pop(true);
                      
                      if(isInternet){
                        var a = cubit.addSchedule(schedulData!);
                      cubit.getSchedule();
                      AppRouter.navigatorKey.currentState?.pop(true);
                      }else {
                        showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                      }

                      } else if(_selectedItems.isEmpty){
                        showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Please select some days")
                    );
                      }
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: semiBold,
                              color: redCA1F27Color)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30, 
              ),
              Form(
                key: _addSchFormKey,
                child: CustomTextFeild(
                  controller: _schName,
                  hintText: "Schedule Name  (Max. 10 char)",
                  maxLength: 10,
                  validator: (value) {
                          if (value == "") {
                            return "Empty schedule name";
                          } else if(value!.length >10) {
                            return "Schedule name is too long";
                          } else {
                            return null;
                          }
                        },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: lightGreyF6F6F6Color),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Starts",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: normal,
                                    color: grey374151Color)),
                          ),
                          const SizedBox(width: 43),
                          Text(
                            "Ends",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: normal,
                                    color: grey374151Color)),
                          ),
                          const Spacer(),
                          Text(
                            "Days",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                    color: grey374151Color)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                          thickness: 1, height: 0, color: lightBlackC9C9C9Color),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                startSelected = true;
                                endSelected = false;
                              });
                            },
                            child: Container(
                                height: 32,
                                width: 73,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: whiteFFFFFFColor),
                                child: Center(
                                  child: Text(
                                    '${startSelectedDate!.hour.toString().padLeft(2, '0')}:'
                                  '${startSelectedDate!.minute.toString().padLeft(2, '0')}',
                                    style: GoogleFonts.openSans(
                                        textStyle:  TextStyle(
                                            fontSize: 18,
                                            fontWeight: normal,
                                            color: startSelected ?  redCA1F27Color : grey374151Color
                                            )),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                startSelected = false;
                                endSelected = true;
                              });
                            },
                            child: Container(
                                height: 32,
                                width: 73,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: whiteFFFFFFColor),
                                child: Center(
                                  child: Text(
                                    '${endSelectedDate!.hour.toString().padLeft(2, '0')}:'
                                  '${endSelectedDate!.minute.toString().padLeft(2, '0')}',
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: normal,
                                            color: endSelected ? redCA1F27Color : grey374151Color
                                            )),
                                  ),
                                )),
                          ),
                          const Spacer(),
                          // Container(
                          //   height: 32,
                          //   width: 73,
                          //   decoration: const BoxDecoration(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //       color: whiteFFFFFFColor),
                          //   child: DropdownButtonFormField<String>(
                          //     hint: Text(
                          //       "Days",
                          //       style: GoogleFonts.openSans(
                          //           textStyle: const TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: normal,
                          //               color: grey374151Color)),
                          //     ),
                          //     decoration: InputDecoration(
                          //       border: const OutlineInputBorder(
                          //         borderSide: BorderSide.none
                          //       ),
                          //       hintText: "Days",
                          //       hintStyle: GoogleFonts.openSans(
                          //           textStyle: const TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: normal,
                          //               color: grey374151Color)),
                          //     ),
                          //     isDense: true,
                          //     value: _selectedItems.isNotEmpty
                          //         ? _selectedItems.first
                          //         : null,
                          //     // value: "Days",
                          //     onChanged: (value) {
                          //       _onItemChecked(value!);
                          //       setState(() {
                                  
                          //       });
                          //     },
                          //     items: _days.map((String option) {
                          //       return DropdownMenuItem<String>(
                          //         // onTap: (){
    
                          //         // },
                          //         value: option,
                          //         child: GestureDetector(
                          //           onTap: (){
                          //             _onItemChecked(option);
                          //             setState(() {
                                        
                          //             });
                          //           },
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             children: <Widget>[
                          //               Text(
                          //                 option,
                          //                 style: TextStyle(fontSize: 12),
                          //               ),
                          //               // Checkbox(
                          //               //   shape: StadiumBorder(),
                          //               //   value: _selectedItems.contains(option),
                          //               //   // value: true,
                          //               //   onChanged: (bool? value) {
                          //               //     _onItemChecked(option);
                          //               //   },
                          //               // ),
                          //               Icon(Icons.check, color: _selectedItems.contains(option) ? redCA1F27Color : Colors.white)
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
    
                          Container(
                            height: 32,
                            width: 120,
                            child: MultiSelectDropDown(
                                        showClearIcon: false,
                                        controller: _controller,
                                        onOptionSelected: (options) {
                                          
                                          List<String> items=[];
                                          for(var i=0; i<options.length; i++){
                                            items.add(options[i].value.toString());
                                          }
                                          _selectedItems=items;
                                        },
                                        borderWidth: 0.0,
                                        focusedBorderWidth: 0.0,
                                        focusedBorderColor: Colors.white,
                                        borderColor: Colors.white,
                                        alwaysShowOptionIcon: true,
                                        borderRadius: 10.0,
                                        selectedOptionBackgroundColor: Colors.white,
                                        options: <ValueItem>[
                                          ValueItem(label: 'Sun', value: 'Sunday'
                                          
                                          ),
                                          ValueItem(label: 'Mon', value: 'Monday'),
                                          ValueItem(label: 'Tue', value: 'Tuesday'),
                                          ValueItem(label: 'Wed', value: 'Wednesday'),
                                          ValueItem(label: 'Thurs', value: 'Thursday'),
                                          ValueItem(label: 'Fri', value: 'Friday'),
                                          ValueItem(label: 'Sat', value: 'Saturday'),
                                        ],
                                        maxItems: 7,
                                        
                                        // disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                                        selectionType: SelectionType.multi,
                                        chipConfig: ChipConfig(
                                          // wrapType: WrapType.wrap,
                                          labelColor: Colors.black,
                                          padding:  EdgeInsets.all(0),
                                          spacing: 0,
                                          runSpacing: 0,
                                          radius: 0,
                                          deleteIcon: Icon(Icons.star, size: 0,),
                                          
                                        ),
                                        dropdownHeight: 300,
                                        // dropdo
                                        hint: 'Days',
                                        
                                        hintStyle: GoogleFonts.openSans(
                                        textStyle:  TextStyle(
                                            fontSize: 18,
                                            fontWeight: normal,
                                            color: grey374151Color
                                            )),
                                        optionTextStyle: const TextStyle(fontSize: 16),
                                        selectedOptionTextColor: redCA1F27Color,
                                        // selectedOptionIcon: Icon(Icons.check, size: 0,)
                                      ),
                          ),
    
    
            //               Container(
            //                 height: 32,
            //                 width: 120,
            //                 child: DropDownMultiSelect(
            //                   readOnly: true,
            //     // selected_values_style: TextStyle(color: Colors.black),
            //     onChanged: (List<String> x) {
            //       setState(() {
            //         selected =x;
            //         // showselected=x[0];
            //       });
            //     },
            //     decoration: InputDecoration(
            //       // border: InputBorder.none,
            //       prefix: Text("abcdef"),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10.0),
    
            //       ),
                  
            //     ),
            //     filled: true,
            //     fillColor: Colors.transparent
            //     ),
            //     options: ['Sun', 'Mon', 'Tue', 'Wed', 'Thus', 'Fri', 'Sat'],
            //     selectedValues: selected,
            //     // whenEmpty: 'Days',
            //     // hint: Text("nscmn"),
            //   ),
            // ),
                          // ),
                        ],
                      ),
                      Visibility(
                          // visible: isSelected == index
                          //     ? isExp
                          //     : false || secondDateIndex == index
                          //         ? secondDate
                          //         : false,
                          child: SizedBox(
                        height: 200,
                        // Set a suitable height for the DatePicker
                        child: CupertinoDatePicker(
                          use24hFormat: true,
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: startSelected ? startSelectedDate : endSelectedDate,
                          // backgroundColor: Colors.green,
                          onDateTimeChanged: (date) {
                            if(startSelected == true){
                              startSelectedDate = date;
                                  setState(() {
                                    
                                  });
    
                            }else if(endSelected == true){
                              endSelectedDate = date;
                              setState(() {
                                    
                                  });
                            }
                          },
                        ),
                        //                       child: CupertinoTimerPicker(
                        //   mode: CupertinoTimerPickerMode.hm,
                        //   initialTimerDuration: Duration(
                        //     hours: selectedTime.hour,
                        //     minutes: selectedTime.minute,
                        //   ),
                        //   onTimerDurationChanged: (Duration value) {
                        //     setState(() {
                        //       selectedTime = TimeOfDay.fromDateTime(
                        //         DateTime(2000, 1, 1, value.inHours, value.inMinutes % 60),
                        //       );
                        //     });
                        //   },
                        // ),
                        // child: CupertinoPicker(
                        //   onSelectedItemChanged: (int value) {  },
                        //   itemExtent: null,
                        //   children: [],
    
                        // )
                      )),
                    ],
                  )),
              const SizedBox(height: 12),
              Container(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: lightGreyF6F6F6Color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Live Location",
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: semiBold,
                                color: normalblack0D1F3CColor)),
                    ),
                    CupertinoSwitch(
                      value: liveLocation,
                      onChanged: (value) {
                        setState(() {
                          liveLocation=value;
                        });
                      },
                    ),
                  ],
                )
              ),
              // if (widget.isNew) const SizedBox() else const SizedBox(height: 12),
              // widget.isNew ? const SizedBox() :
              // GestureDetector(
              //   onTap: () {
              //       AppRouter.navigatorKey.currentState?.pop(false);
              //   },
              //   child: Container(
              //       width: double.infinity,
              //       height: 48,
              //       decoration: const BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(10)),
              //           color: lightGreyF6F6F6Color),
              //       child: Center(
              //         child: Text(
              //           "Delete Schedule",
              //           style: GoogleFonts.openSans(
              //               textStyle: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: normal,
              //                   color: redCA1F27Color)),
              //         ),
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}