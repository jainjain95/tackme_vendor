import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_state.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_cubit.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class StopTab extends StatefulWidget {
  
  const StopTab({super.key});

  @override
  State<StopTab> createState() => _StopTabState();
}

class _StopTabState extends State<StopTab> {

  bool isOngoingRouteflag = false;

  @override
  void initState() {
    // getStop();
    BlocProvider.of<StopCubit>(context).getStop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
      
      BlocConsumer< InternetCubit, bool>(
        listener: (context, state) {
        if(state == true){
          BlocProvider.of<StopCubit>(context).getStop();
        }
      },
        builder: (context, state){
        if(state == false){
        // return Center(child: Container(height: 10, width: 10, color: Colors.green));
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
        return BlocBuilder<StopCubit, StopState>(builder: (context, state) {
          if (state is StopEmptyState) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  SvgPicture.asset("$svgAssetsBasePath/stop_image.svg"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Stops refer to the locations where the food truck stops to serve customers.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: black111011Color,
                              fontWeight: semiBold))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "To add a new stop click on the ‘+’ icon on the top right corner of your screen",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: mediumBlack6F6F6FColor,
                              fontWeight: semiBold))),
                ],
              ),
            );
          }
          if (state is StopErrorState) {
            return Center(child: Text("Something Went Wrong"));
          }
          if (state is StopResponseState) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      decoration: const BoxDecoration(
                          color: lightGreyF6F6F6Color,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ListView.separated(
                        itemCount: state.response.data!.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              AppRouter.navigatorKey.currentState?.pushNamed(
                                  AppRouter.stopMapScreen,
                                  arguments: state.response.data![index]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.response.data![index].location!
                                                .locationNickName ??
                                            "",
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: black111011Color,
                                                fontWeight: bold)),
                                      ),
                                      Text(
                                        state.response.data![index].location!
                                                .text ??
                                            "",
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontSize: 11,
                                                color: mediumGrey9CA3AFColor,
                                                fontWeight: normal)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 20, color: greyicon374151Color)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1,
                            height: 32,
                          );
                        },
                      )),
                  isOngoingRouteflag
                      ? const SizedBox(height: 100)
                      : const SizedBox()
                ],
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(
            color: redCA1F27Color,
          ));
        }
      );
        }
    );
  }
}
