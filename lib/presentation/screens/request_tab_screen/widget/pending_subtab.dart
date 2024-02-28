import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_state.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class PendingSubtab extends StatefulWidget {
  const PendingSubtab({super.key});

  @override
  State<PendingSubtab> createState() => _PendingSubtabState();
}

class _PendingSubtabState extends State<PendingSubtab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PendingCubit>(context).getPendingRequest();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer< InternetCubit, bool>(
      listener: (context, state) {
        if(state == true){
          BlocProvider.of<PendingCubit>(context).getPendingRequest();
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
      return BlocBuilder<PendingCubit, PendingState>(
        builder: (context, state) {
          if (state is PendingEmptyState) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 68,
                  ),
                  SvgPicture.asset("$svgAssetsBasePath/Frame 1000002289.svg"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Pending Requests",
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
                      "When people ask to add you, you’ll see their requests here",
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
          if (state is PendingResponseState) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: const BoxDecoration(
                      color: lightGreyF6F6F6Color,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListView.separated(
                    itemCount: state.response.data!.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AppRouter.navigatorKey.currentState?.pushNamed(
                              AppRouter.pendingOnMapScreen,
                              arguments: state.response.data![index]);
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
                                      state.response.data![index].customer!
                                              .name ??
                                          "",
                                      style: GoogleFonts.robotoFlex(
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: fontGrey0E0E0EColor,
                                              fontWeight: semiBold)),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      state.response.data![index].customer!
                                              .location!.address ??
                                          "",
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
                                Spacer(),
                                Icon(Icons.arrow_forward_ios,
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
                      return SizedBox(
                        height: 10,
                      );
                    },
                  )),
            );
          }
          if(state is PendingErrorState){
            return Center(child: Text("Something Went Wrong"));
          }
          return const Center(
            child: CircularProgressIndicator(
              color: redCA1F27Color,
            ),
          );
        },
      );
      }
    );
  }
}
