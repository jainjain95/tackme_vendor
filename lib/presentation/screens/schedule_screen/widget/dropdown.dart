import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {


  bool startSelected = true;
  bool endSelected = false;
  List<String> _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thus', 'Fri', 'Sat'];
  List<String> selectedDays = [];
  GlobalKey<FormState> _addSchFormKey = new GlobalKey<FormState>();
  TextEditingController _schName = TextEditingController();
   List<String> _selectedItems = [];

   void _onItemChecked(String item) {
    // setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    // });
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                          height: 32,
                          width: 73,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: whiteFFFFFFColor),
                          child: DropdownButtonFormField<String>(
                            hint: Text(
                              "Days",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: normal,
                                      color: grey374151Color)),
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none
                              ),
                            ),
                            isDense: true,
                            value: _selectedItems.isNotEmpty
                                ? _selectedItems.first
                                : null,
                            // value: "Days",
                            onChanged: (value) {
                              _onItemChecked(value!);
                              print("bbbbbbbbbbbbb");
                              setState(() {
      
    });
                            },
                            // items: [
                            //   DropdownMenuItem(
                            //     child: Text("a")
                            //   ),
                            //   DropdownMenuItem(
                            //     child: Text("a")
                            //   ),
                            //   DropdownMenuItem(
                            //     child: Text("a")
                            //   ),
                            //   DropdownMenuItem(
                            //     child: Text("a")
                            //   ),
                            //   DropdownMenuItem(
                            //     child: Text("a")
                            //   ),
                            //   DropdownMenuItem(
                            //     child: Text("a")
                            //   ),
                            // ],
                            items: _days.map((String option) {
                              return DropdownMenuItem<String>(
                                onTap: (){
setState(() {
      
    });
                                },
                                value: option,
                                child: GestureDetector(
                                  onTap: (){
                                    _onItemChecked(option);
                                    print("AAAAAAAAAAAAAa");
                                    setState(() {
      
    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        option,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      // Checkbox(
                                      //   shape: StadiumBorder(),
                                      //   value: _selectedItems.contains(option),
                                      //   // value: true,
                                      //   onChanged: (bool? value) {
                                      //     _onItemChecked(option);
                                      //   },
                                      // ),
                                      Icon(Icons.check, color: _selectedItems.contains(option) ? redCA1F27Color : Colors.white)
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
  }
}