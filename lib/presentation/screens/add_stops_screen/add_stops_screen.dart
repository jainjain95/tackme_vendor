import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/assets_base_path.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/repository/network_util.dart';
import 'package:tagmevendor/logic/cubits/add_stop/add_stop_cubit.dart';
import 'package:tagmevendor/logic/cubits/add_stop/add_stop_state.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/logic/cubits/stops/stops_cubit.dart';
import 'package:tagmevendor/models/place_autocomplete_model.dart';
import 'package:tagmevendor/models/req_model/add_stop_req_model.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tagmevendor/presentation/widgets/alert_message_dialog.dart';
import 'package:tagmevendor/presentation/widgets/customTextFeild.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/map_button.dart';
import 'package:tagmevendor/presentation/widgets/message_Error_snackbar.dart';
import 'package:tagmevendor/presentation/widgets/message_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddStopsScreen extends StatefulWidget {
  LatLng currentLocation;
  AddStopsScreen({super.key, 
  required this.currentLocation
      // required this.lng
      });

  @override
  State<AddStopsScreen> createState() => _AddStopsScreenState();
}

class _AddStopsScreenState extends State<AddStopsScreen> {
  GlobalKey<FormState> _addStopFormKey = new GlobalKey<FormState>();
  List<dynamic>? placelist = [];
  List<Prediction> _predictionList = [];
  String _latitude = '';
  String _longitude = '';
  GoogleMapController? _controller;
  final TextEditingController _typeAheadController =
      TextEditingController(); ///// *
  late String _address;
  LatLng _center = LatLng(25.989463, 70.706913);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // method();
    setState(() {
      _center = widget.currentLocation;
    });
    method();
  }

  void method() async {
    // await Geolocator.checkPermission();
    // await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position);
    // _center = {'lat': position.latitude, 'lng': position.longitude};
    // var position = await _determinePosition();
    // print(position);
    print("current lat long fetched");
    _center = LatLng(position.latitude, position.longitude);
    setState(() {});
  }

  void _onCameraMove(CameraPosition position) async {
    //  getAddressFromLatLng(position.target.latitude, position.target.longitude);
    setState(() {
      _center = position.target;
      print("///////////////////////////////////////////////////////");
      print(_center);
      // _typeAheadController.text=_address;
    });
  }

  void _onCameraIdle() {
    print("camera idle run");
    getAddressFromLatLng(_center.latitude, _center.longitude);
  }

  void _animateToTarget() async {
    if (_controller != null) {
      await _controller!.animateCamera(CameraUpdate.newLatLng(_center));
    }
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      _address =
          "${place.name}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
      print(_address);
      setState(() {
        _typeAheadController.text = _address;
      });
    } catch (e) {
      return null;
    }
  }

  TextEditingController _stopName = TextEditingController(); ////*

  @override
  Widget build(BuildContext context) {
    final StopCubit cubit = BlocProvider.of<StopCubit>(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: whiteFFFFFFColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,
                      size: 20, color: greyicon374151Color)),
            ),
            title: Text(
              "New Stop",
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: semiBold,
                      color: black111011Color)),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: BlocBuilder< InternetCubit, bool> (
              builder: (context, state) {
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
              return Column(
                children: [
                  Form(
                    key: _addStopFormKey,
                    child: CustomTextFeild(
                      controller: _stopName,
                      hintText: "Enter a nickname",
                      validator: (value) {
                        if (value == "") {
                          return "Invalid Nickname";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      cursorColor: black111011Color,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: mediumGrey9CA3AFColor,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _typeAheadController.clear();
                          },
                          // child: SvgPicture.asset("$svgAssetsBasePath/cancel_icon.svg", height: 5, width: 5)
                          child: const Icon(Icons.cancel_outlined,
                              size: 20, color: greyicon374151Color),
                        ),
                        hintText: "Search",
                        hintStyle: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                          color: mediumGrey9CA3AFColor,
                        )),
                        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : black111011Color;
                            return TextStyle(color: color, fontSize: 20);
                          },
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
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
                        fillColor: lightGreyF6F6F6Color,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await placeAutoComplete(pattern);
                    },
                    itemBuilder: (context, Prediction suggestion) => ListTile(
                      title: 
                      Text(suggestion.description)
                    ),
                    itemSeparatorBuilder: (context, index) => const Divider(),
                    onSuggestionSelected: (Prediction suggestion) async {
                      _typeAheadController.text = suggestion.description;
                      await _getCoordinates();
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a city' : null,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 350,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: [
                            GoogleMap(
                              myLocationButtonEnabled: false,
                              onMapCreated: (GoogleMapController controller) {
                                setState(() {
                                  _controller = controller;
                                  _animateToTarget();
                                });
                              },
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 12.0,
                              ),
                              onCameraMove: _onCameraMove,
                              onCameraIdle: _onCameraIdle,
                            ),
                            Center(
                              child: Image.asset(
                                "$pngAssetsBasePath/marker.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 25,
                              child: BlocConsumer<AddStopCubit, AddStopState>(
                                listener: (context, state) {
                                  if (state is AddStopResponseState) {
                                    cubit.getStop();
                                    showTopSnackBar(
                                        Overlay.of(context),
                                        customSuccessSnackBar(
                                            context, "New Stop Added"));
                                    Navigator.pop(context);
                                  }
                                  if (state is AddStopErrorState) {
                                    showTopSnackBar(
                                        Overlay.of(context),
                                        customErrorSnackBar(
                                            context, "Internal Server Error"));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AddStopLoadingState) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                            color: redCA1F27Color));
                                  }
                                  return GestureDetector(
                                      onTap: () async {
                                        if(await Geolocator.isLocationServiceEnabled()){
                                        if (_addStopFormKey.currentState!
                                              .validate()) {
                                            print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
                                            print(_center.latitude.toString());
                                            print(_center.longitude.toString());
                                            
                                            AddStopReqModel req = AddStopReqModel(
                                                locationNickName:
                                                    _stopName.text.trim(),
                                                
                                                longitude:
                                                    _center.longitude.toString(),
                                                    
                                                latitude:
                                                    _center.latitude.toString(),
                                                address: _typeAheadController.text
                                                    .toString());
                                            print("aaaaaaaaaaaaaaaaaaaaaaaa");
                                            print(req.address);
                                            BlocProvider.of<AddStopCubit>(context)
                                                .addStop(req);
                                          }
                                        } else{
                                          await Geolocator.getCurrentPosition();
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            //width: 80,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            // constraints: BoxConstraints.loose(),
                                            decoration: BoxDecoration(
                                                color: redCA1F27Color,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 12,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.add,
                                                    color: whiteFFFFFFColor,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Text(
                                                    "Add",
                                                    style: GoogleFonts.openSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                whiteFFFFFFColor,
                                                            fontWeight: bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                },
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              );}
            ),
          )),
    );
  }

  // }

  Future<List<Prediction>> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        "maps/api/place/autocomplete/json",
        {"input": query, "key": "AIzaSyAfT02pJTjvN2wj4dRjfIqOm-EuaPKcDYs"});
    String? response = await NetworkUtil.fetchdata(uri);
    var data = jsonDecode(response.toString());
    _predictionList = [];
    data['predictions'].forEach(
        (prediction) => _predictionList.add(Prediction.fromJson(prediction)));
    setState(() {
      print(placelist);
    });
    return _predictionList;
  }

  Future<void> _getCoordinates() async {
    final apiKey = 'AIzaSyAfT02pJTjvN2wj4dRjfIqOm-EuaPKcDYs';
    final address = _typeAheadController.text;
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        setState(() {
          _latitude = location['lat'].toString();
          _longitude = location['lng'].toString();
          _center = LatLng(location['lat'], location['lng']);
          _animateToTarget();
        });
      } else {
        setState(() {
          _latitude = 'Not found';
          _longitude = 'Not found';
        });
      }
    } else {
      setState(() {
        _latitude = 'Error';
        _longitude = 'Error';
      });
    }
  }
}
