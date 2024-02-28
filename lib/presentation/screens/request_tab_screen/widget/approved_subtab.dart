import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/approved/approved_cubit.dart';
import 'package:tagmevendor/logic/cubits/approved/approved_state.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class ApprovedSubTab extends StatefulWidget {
  const ApprovedSubTab({super.key});

  @override
  State<ApprovedSubTab> createState() => _ApprovedSubTabState();
}

 
class _ApprovedSubTabState extends State<ApprovedSubTab> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ApprovedCubit>(context).getApprovedRequest();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer< InternetCubit, bool>(
      listener: (context, state) {
        if(state == true){
          BlocProvider.of<ApprovedCubit>(context).getApprovedRequest();
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
      return BlocBuilder< ApprovedCubit, ApprovedState>(
        builder: (context, state) {
          if(state is ApprovedEmptyState){
            return Center(child: Column(
                        children: [
                          const SizedBox(height: 80,),
                          SvgPicture.asset("$svgAssetsBasePath/undraw_confirmation_re_b6q5.svg"),
                          const SizedBox(height: 40,),
                          Text(
                              "No Approved Requests",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18, color: black111011Color, fontWeight: semiBold))
                          ),
                          const SizedBox(height: 10,),
                          Text(
                              "To approve requests go the pending requests section",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 16, color: mediumBlack6F6F6FColor, fontWeight: normal))
                          ),
                        ],
                      ),);
          }
          if(state is ApprovedErrorState){
            return Center(child: Text("Something Went Wrong"),);
          }
          if(state is ApprovedResponseState){
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                        AppRouter.navigatorKey.currentState
                            ?.pushNamed(AppRouter.approvedOnMapScreen, arguments: state.response.data![index]);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image.asset(
                                  "$pngAssetsBasePath/unsplash_a6PMA5JEmWE.png",
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.response.data![index].customer!.name ?? "",
                                    style: GoogleFonts.robotoFlex(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: fontGrey0E0E0EColor,
                                            fontWeight: semiBold)),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    state.response.data![index].customer!.location!.address ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.robotoFlex(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: lightGrey717171Color,
                                            fontWeight: light)),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 24, color: greyicon374151Color)
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                              thickness: 1,
                              height: 0,
                              color: lightBlackC9C9C9Color)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                )),
          ); 
          }
          return const Center(child: CircularProgressIndicator(color: redCA1F27Color,),);   
        },
        
      );
      }
    );
  }
}
