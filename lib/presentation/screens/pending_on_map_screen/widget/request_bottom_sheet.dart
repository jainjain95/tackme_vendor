import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/approved/approved_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending/pending_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending_req_btmsheet_cubit.dart/pending_req_btmsheet_cubit.dart';
import 'package:tagmevendor/logic/cubits/pending_req_btmsheet_cubit.dart/pending_req_btmsheet_state.dart';
import 'package:tagmevendor/models/user_request_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';

class RequsetBottomSheet extends StatefulWidget {
  DataR reqData;
  RequsetBottomSheet({super.key, required this.reqData});

  @override
  State<RequsetBottomSheet> createState() => _RequsetBottomSheetState();
}

class _RequsetBottomSheetState extends State<RequsetBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: whiteFFFFFFColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 55,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: lightBlue3479EEColor),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Pending Request",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: semiBold,
                        color: darkBlack000000Color)),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          BlocConsumer<PendingReqBtmSheetCubit, PendingReqBtmSheetState>(
            listener: (context, state) {
              // TODO: implement listener
              if(state is PendingReqBtmSheetResponseState){
                if(state.response.status == true){
                  AppRouter.navigatorKey.currentState?.pop();
                  AppRouter.navigatorKey.currentState?.pop();
                  BlocProvider.of<ApprovedCubit>(context).getApprovedRequest();
                  BlocProvider.of<PendingCubit>(context).getPendingRequest();
                }
              }
              if(state is PendingReqBtmSheetErrorState){
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertMessageDialog(error: state.error);
                  }
                );
              }
            },
            builder: (context, state) {
              if(state is PendingReqBtmSheetLoadingState){
                return const Center(child: CircularProgressIndicator(color: redCA1F27Color),);
              }
              return Row(
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<PendingReqBtmSheetCubit>(context).rejectRequest(widget.reqData.id.toString());
                      },
                      child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: lightGreyF6F6F6Color),
                          child: Center(
                            child: Text(
                              "REJECT",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 12.90,
                                      fontWeight: bold,
                                      color: redCA1F27Color)),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        BlocProvider.of<PendingReqBtmSheetCubit>(context).updateRequestStatus("approved",widget.reqData.id.toString());
                      },
                      child: Container(
                          height: 40,
                          // width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: redCA1F27Color),
                          child: Center(
                            child: Text(
                              "ACCEPT",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 12.90,
                                      fontWeight: bold,
                                      color: whiteFFFFFFColor)),
                            ),
                          )),
                    ),
                  )
                ],
              );
              
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                AppRouter.navigatorKey.currentState?.pop();
              },
              child: Text("Ignore",
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: bold,
                          color: mediumBlack6F6F6FColor))),
            ),
          )
        ],
      ),
    );
  }
}
