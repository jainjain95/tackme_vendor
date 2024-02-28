import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/logic/cubits/edit_rote_stop/edit_rote_stop_cubit.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../models/stop_model.dart';

class StopDropdownTile extends StatefulWidget {
  final int index;   ///   index of dropdown listtile
  final int length;  ////    total length of dropdown
  final String selectedValue;     ////    selected dropdown value 
  final List<Data>? stopList;     ////    list of all stops for dropdown
  // final int stopsLength;

  StopDropdownTile({super.key, required this.index, required this.length, this.stopList, 
  required this.selectedValue, 
  // required this.stopsLength, 
  });

  @override
  State<StopDropdownTile> createState() => _StopDropdownTileState();
}

class _StopDropdownTileState extends State<StopDropdownTile> {


  
  String selectedItem = "";

  @override
  void initState() {
    // TODO: implement initState
    // selectedItem = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TimelineTile(
        isFirst: widget.index + 1 == 1 ? true : false,
        isLast: false,
        beforeLineStyle: LineStyle(thickness: 2, color: greylineCFD5DFColor),
        indicatorStyle: IndicatorStyle(
            width: 20,
            padding: EdgeInsets.symmetric(vertical: 3),
            indicator: 
                Container(
                    height: 20,
                    width: 20,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        '${widget.index + 1}',
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: bold,
                                color: whiteFFFFFFColor)),
                      ),
                    ),
                  )),
        endChild: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: SizedBox(
                height: 45,
                child: TextField(
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: normal)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
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
                    fillColor: whiteFFFFFFColor,
                    // hintText: "testing",
                    hintStyle: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: mediumGrey9CA3AFColor, fontSize: 15)),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.69),
                      child: 
                          DropdownButtonFormField(
                              icon: SvgPicture.asset(
                                  "$svgAssetsBasePath/Component 7.svg"),
                              decoration: const InputDecoration(
                                border: InputBorder
                                    .none, // Remove the bottom border
                              ),
                              value: widget.selectedValue,
                              onChanged: (newValue) {
                                    Data stop =widget.stopList!.where((element) => element.id.toString() ==  newValue).first;
                                    BlocProvider.of<EditRouteStopCubit>(context).updateStop(
                                      widget.index,
                                      LatLng(
                                        stop.location!.coordinates![1], 
                                        stop.location!.coordinates![0]
                                      ),
                                      newValue!,
                                      stop.id.toString()
                                    );
                              },
                              hint: Text("Add a stop"),
                              items: widget.stopList!.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.id.toString(),
                                  child: Text(
                                      e.location!.locationNickName.toString()),
                                );
                              }).toList())
                          
                  ),
                ),
              ),
            ),),
            SizedBox(
              width: 13,
            ),
            GestureDetector(
              onTap: () {
                if(widget.length > 1){
                  BlocProvider.of<EditRouteStopCubit>(context).cancleStop(widget.index);
                }
              },
              child: SvgPicture.asset("$svgAssetsBasePath/Component 8.svg"),
            )
          ],
        ),
      ),
    );
  }
}