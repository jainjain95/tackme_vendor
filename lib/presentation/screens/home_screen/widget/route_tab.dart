import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/route/route_cubit.dart';
import 'package:tagmevendor/logic/cubits/route/route_state.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_cubit.dart';
import 'package:tagmevendor/logic/cubits/start_route_map/start_route_map_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class RouteTab extends StatefulWidget {
  const RouteTab({super.key});

  @override
  State<RouteTab> createState() => _RouteTabState();
}

class _RouteTabState extends State<RouteTab> {

  @override
  void initState() {
    BlocProvider.of<RouteCubit>(context).getRoute();
    super.initState();
  }

  bool isOngoingRouteflag = false;


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer< InternetCubit, bool>(
        listener: (context, state) {
        if(state == true){
          // BlocProvider.of<StopCubit>(context).getStop();
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
        return BlocBuilder<RouteCubit,RouteState>(
          builder: (context, state){
            if(state is RouteEmptyState){
              return Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            SvgPicture.asset("$svgAssetsBasePath/route_image.svg"),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Routes encompass a food truck's travel path, including stops and schedules.",
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
                                "To add a new route click on the ‘+’ icon on the top right corner of your screen",
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
            if(state is RouteResponseState){
              return SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                                // height: 100,
                                // width: 300,
                                decoration: const BoxDecoration(
                                    color: lightGreyF6F6F6Color,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: ListView.separated(
                                  itemCount: state.response.data!.length,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        print("(((((((((((((((((((((((((((((((((((((((((((((((");
                                        print(state.response.data![0].stops![0].sid);
                                        AppRouter.navigatorKey.currentState?.pushNamed(AppRouter.routeMapScreen, arguments: state.response.data![index]);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // "vhv",
                                            state.response.data![index].routeNickName.toString(),
                                            style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: black111011Color,
                                                    fontWeight: bold)),
                                          ),
                                          Text(
                                            // "hjvhjv",
                                            state.response.data![index].stops!.first.location!.locationNickName.toString()+" to "+state.response.data![index].stops!.last.location!.locationNickName.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: mediumGrey9CA3AFColor,
                                                    fontWeight: normal)),
                                          ),
                                        ],
                                      ),
                                      const Icon(Icons.arrow_forward_ios, size: 20, color: greyicon374151Color)
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider(
                                      thickness: 1,
                                      height: 38,
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
            if(state is RouteErrorState){
              return Center(child: Text("Something Went Wrong"));
            }
            return const Center(
              child: CircularProgressIndicator(color: redCA1F27Color,)
            );
          }
        );}
    );            
  }
}