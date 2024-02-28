import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_cubit.dart';
import 'package:tagmevendor/logic/cubits/schedule/schedule_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/screens/schedule_screen/widget/empty_data_widget.dart';
import 'package:tagmevendor/presentation/screens/schedule_screen/widget/schedule_sheet.dart';
import 'package:tagmevendor/presentation/screens/schedule_screen/widget/schedule_sheet_two.dart';
import 'package:tagmevendor/presentation/screens/schedule_screen/widget/schedule_tile.dart';
import 'package:tagmevendor/presentation/widgets/custom_main_button.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/font_weight.dart';

class ScheduleScreen extends StatefulWidget {
  bool isFirst;
  ScheduleScreen({super.key, required this.isFirst});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  int? scheduleLength;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ScheduleCubit>(context).getSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScheduleCubit cubit = BlocProvider.of<ScheduleCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteFFFFFFColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: widget.isFirst ? SizedBox()
          :          
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                  color: greyicon374151Color
              )),
        ),
        title: Text(
          "My Schedule",
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  fontSize: 20, fontWeight: semiBold, color: black111011Color)),
        ),
        actions: [
          (widget.isFirst && scheduleLength != 0)  ? 
          
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: InkWell(
                onTap: () async {
                  await Helper.saveStatus("complete");
                  AppRouter.navigatorKey.currentState?.pushNamed(AppRouter.subscriptionScreen);
                },
                child: Text(
                  "Next",
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: semiBold,
                          color: redCA1F27Color)),
                ),
              ),
            ),
          ) : SizedBox()
        ],
      ),
      body: BlocBuilder< InternetCubit, bool>(
        
        builder: (context, state){
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
          return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: BlocConsumer<ScheduleCubit, ScheduleState>(
            listener: (context, state){
              if(state is ScheduleResponseState){
                // int scheduleCount = state.response.data!.length + 1;
                scheduleLength = state.response.data!.length;
                // schedulName= "Schedule "+scheduleCount.toString();
                setState(() {
                  
                });
              }
            },
            builder: (context, state) {
      
              if(state is ScheduleLoadingState){
                return const Center(
                  child: CircularProgressIndicator(
                    color: redCA1F27Color,
                  )
                );
              }
              if(state is ScheduleEmptyState){
                return EmptyDataWidget();
              }
              if(state is ScheduleResponseState){
                return 
                state.response.data!.length != 0 ?
                SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 12,right: 12,top: 20,bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyF6F6F6Color,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Schedule",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: normal,
                                          color: grey374151Color)),
                                ),
                                Text(
                                  "Live Location",
                                  style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: normal,
                                          color: grey374151Color)),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                                thickness: 1,
                                height: 0,
                                color: lightBlackC9C9C9Color),
                            // const SizedBox(height: 12),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: state.response.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return UpdateScheduleSheet(
                                              isNew: false,
                                              schedulData: state.response.data![index],
                                              // index: index+1,
                                            );
                                          },
                                        );
                                      },
                                      child: ScheduleTile(
                                        schedulData: state.response.data![index],                                     
                                        location: state.response.data![index].liveLocation ?? true,
                                        index: index+1,
                                      )
                                  );
                                }, separatorBuilder: (BuildContext context, int index) { 
                                  return const Divider(
                thickness: 1,
                height: 0,
                color: lightBlackC9C9C9Color,
              );
                                 },),
                            // const SizedBox(height: 12),
                          ],
                        )),
                    // const SizedBox(height: 50),
                  ],
                ),
              ) :
              EmptyDataWidget();
              }
      
              /////////
              return const Center(
                child: Text("An Error Occure")
              );
            },
          ),
        );}
      ),
 
      bottomNavigationBar: BlocBuilder< InternetCubit, bool>(

        builder: (context, state) {
          if(state == false){
            return SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 35),
            child: CustomMainButton(
              color: redCA1F27Color,
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return AddScheduleSheet();
                    },
                  );
                },
                label: "Add New Schedule"));}
      ),
    );
  }
}
