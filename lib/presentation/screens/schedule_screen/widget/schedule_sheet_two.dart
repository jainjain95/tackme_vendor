import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_cubit.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_state.dart';
import 'package:tagmevendor/models/schedule_List_Model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/schedule_screen/widget/dropdown.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateScheduleSheet extends StatefulWidget {
  BuildContext? acontext;
  Datum schedulData;
  // int? index;
  bool isNew; ////////////////////    used to check bottom delete button
  UpdateScheduleSheet(
      {super.key,
      required this.isNew,
      this.acontext,
      required this.schedulData});

  @override
  State<UpdateScheduleSheet> createState() => _UpdateScheduleSheetState();
}

class _UpdateScheduleSheetState extends State<UpdateScheduleSheet> {
  DateTime? startSelectedDate = DateTime.now();
  DateTime? endSelectedDate = DateTime.now();
  bool startSelected = true;
  bool endSelected = false;
  List<String> _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thus', 'Fri', 'Sat'];
  List<String> selectedDays = [];
  GlobalKey<FormState> _addSchFormKey = new GlobalKey<FormState>();
  TextEditingController _schName = TextEditingController();

  String startTime = "";
  String endTime = "";
  bool liveLocation = true;
  List<String> _selectedItems = [];
  final List<ValueItem> _selectedOptions = [
    ValueItem(label: 'Mon', value: 'Monday'),
    ValueItem(label: 'Tue', value: 'Tuesday'),
    ValueItem(label: 'Wed', value: 'Wednesday'),
    ValueItem(label: 'Thurs', value: 'Thursday'),
    ValueItem(label: 'Fri', value: 'Friday'),
    ValueItem(label: 'Sat', value: 'Saturday'),
  ];

  List<ValueItem> _selectedOption = [];
  bool isInternet = true;

  @override
  void initState() {
    // TODO: implement initState
    startTime = widget.schedulData.startTime.toString();
    endTime = widget.schedulData.endTime.toString();
    liveLocation = widget.schedulData.liveLocation!;
    _selectedItems = widget.schedulData.days!;
    _schName =
        TextEditingController(text: widget.schedulData.scheduleName.toString());

    for (int i = 0; i < _selectedItems.length; i++) {
      switch (_selectedItems[i]) {
        case 'Monday':
          _selectedOption.add(ValueItem(label: 'Mon', value: 'Monday'));
          break;
        case 'Tuesday':
          _selectedOption.add(ValueItem(label: 'Tue', value: 'Tuesday'));
          break;
        case 'Wednesday':
          _selectedOption.add(ValueItem(label: 'Wed', value: 'Wednesday'));
          break;
        case 'Thursday':
          _selectedOption.add(ValueItem(label: 'Thurs', value: 'Thursday'));
          break;
        case 'Friday':
          _selectedOption.add(ValueItem(label: 'Fri', value: 'Friday'));
          break;
        case 'Saturday':
          _selectedOption.add(ValueItem(label: 'Sat', value: 'Saturday'));
          break;
        case 'Sunday':
          _selectedOption.add(ValueItem(label: 'Sun', value: 'Sunday'));
          break;
      }
    }

    setState(() {});

    super.initState();
  }

  void _onItemChecked(String item) {
    // setState(() {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
    // });
    // _controller.options.addAll(_selectedOptions);
    setState(() {});
  }

  @override
  Widget build(BuildContext acontext) {
    final ScheduleCubit cubit = BlocProvider.of<ScheduleCubit>(acontext);
    final MultiSelectController _controller = MultiSelectController();

    // _controller.setSelectedOptions(_selectedOptions);
    _selectedOption.addAll(_controller.selectedOptions);

    void test() {
      print("test complete");
    }

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
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
                    widget.schedulData.scheduleName.toString(),
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: bold,
                            color: darkBlack000000Color)),
                  ),
                  BlocListener<ScheduleCubit, ScheduleState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if(state is ScheduleResponseState){
                        // showTopSnackBar(
                        //       Overlay.of(context),
                        //       customSuccessSnackBar(
                        //           context, "Schedule Updated Successfully"));
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (_addSchFormKey.currentState!.validate() &&
                            _selectedItems.isNotEmpty) {
                          // isLoading = true;
                          Datum req = Datum(
                              id: widget.schedulData.id.toString(),
                              startTime: startTime,
                              endTime: endTime,
                              days: _selectedItems,
                              liveLocation: liveLocation,
                              scheduleName: _schName.text.trim());
                          cubit.updateSchedule(req);
                          // showTopSnackBar(
                          //     Overlay.of(context),
                          //     customSuccessSnackBar(
                          //         context, "Schedule Updated Successfully"));
                          // cubit.getSchedule();
                          // AppRouter.navigatorKey.currentState?.pop(true);
                        
                          if(isInternet){
                            showTopSnackBar(
                              Overlay.of(context),
                              customSuccessSnackBar(
                                  context, "Schedule Updated Successfully"));
                          cubit.getSchedule();
                          AppRouter.navigatorKey.currentState?.pop(true);
                          } else {
                            showTopSnackBar(
                        Overlay.of(context),
                        customErrorSnackBar(context, "Connection failed, Please check your\nnetwork settings")
                    );
                          }
                        
                        } else if (_selectedItems.isEmpty) {
                          showTopSnackBar(
                              Overlay.of(context),
                              customErrorSnackBar(
                                  context, "Please select some days"));
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
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
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
                    } else if (value!.length > 10) {
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                            onTap: () {
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
                                    //   '${startSelectedDate!.hour.toString().padLeft(2, '0')}:'
                                    // '${startSelectedDate!.minute.toString().padLeft(2, '0')}',
                                    startTime,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: normal,
                                            color: startSelected
                                                ? redCA1F27Color
                                                : grey374151Color)),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
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
                                    //   '${endSelectedDate!.hour.toString().padLeft(2, '0')}:'
                                    // '${endSelectedDate!.minute.toString().padLeft(2, '0')}',
                                    endTime,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: normal,
                                            color: endSelected
                                                ? redCA1F27Color
                                                : grey374151Color)),
                                  ),
                                )),
                          ),
                          const Spacer(),
                          // Dropdown()
                          Container(
                            height: 32,
                            width: 120,
                            child: MultiSelectDropDown(
                              showClearIcon: false,
                              controller: _controller,
                              onOptionSelected: (options) {
                                print("MMMMMMMMMMMMMMMMMM");
                                debugPrint(options.toString());
                                List<String> items = [];
                                for (var i = 0; i < options.length; i++) {
                                  items.add(options[i].value.toString());
                                }
                                _selectedItems = items;
                                print(_selectedItems);
                              },
                              selectedOptions: _selectedOption,
                              borderWidth: 0.0,
                              focusedBorderWidth: 0.0,
                              focusedBorderColor: Colors.white,
                              borderColor: Colors.white,
                              alwaysShowOptionIcon: true,
                              borderRadius: 10.0,
                              selectedOptionBackgroundColor: Colors.white,
                              options:
                                  //  _selectedOptions,
                                  [
                                ValueItem(label: 'Sun', value: 'Sunday'),
                                ValueItem(label: 'Mon', value: 'Monday'),
                                ValueItem(label: 'Tue', value: 'Tuesday'),
                                ValueItem(label: 'Wed', value: 'Wednesday'),
                                ValueItem(label: 'Thurs', value: 'Thursday'),
                                ValueItem(label: 'Fri', value: 'Friday'),
                                ValueItem(label: 'Sat', value: 'Saturday'),
                              ],
                              maxItems: 7,
    
                              selectionType: SelectionType.multi,
    
                              dropdownHeight: 350,
                              // dropdo
                              hint: 'Days',
                              chipConfig: ChipConfig(
                                // wrapType: WrapType.wrap,
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
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: normal,
                                      color: grey374151Color)),
                              optionTextStyle: const TextStyle(fontSize: 16),
                              selectedOptionTextColor: redCA1F27Color,
                              // selectedOptionIcon: Icon(Icons.check, size: 0,)
                            ),
                          ),
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
                          initialDateTime:
                              startSelected ? startSelectedDate : endSelectedDate,
                          // backgroundColor: Colors.green,
                          onDateTimeChanged: (date) {
                            if (startSelected == true) {
                              // startSelectedDate = date;
                              startTime =
                                  '${date!.hour.toString().padLeft(2, '0')}:'
                                  '${date!.minute.toString().padLeft(2, '0')}';
                              setState(() {});
                            } else if (endSelected == true) {
                              // endSelectedDate = date;
                              endTime =
                                  '${date!.hour.toString().padLeft(2, '0')}:'
                                  '${date!.minute.toString().padLeft(2, '0')}';
                              setState(() {});
                            }
                          },
                        ),
                      )),
                    ],
                  )),
              const SizedBox(height: 12),
              Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: lightGreyF6F6F6Color),
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
                            liveLocation = value;
                          });
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
