import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tagmevendor/logic/cubits/internet/internet_cubit.dart';
import 'package:tagmevendor/presentation/screens/profile_tab_screen/profile_tab_screen.dart';
import 'package:tagmevendor/presentation/screens/home_screen/home_screen.dart';
import 'package:tagmevendor/presentation/screens/request_tab_screen/request_tab_screen.dart';
import 'package:tagmevendor/presentation/widgets/custom_snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/constants/assets_base_path.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const RequestTabScreen(),
    const ProfileTabScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, bool>(
      listener: (context, state) {
        // TODO: implement listener
        if (state == true) {
        } else {
          showTopSnackBar(
              Overlay.of(context), customErrorSnackBar(context, "Please check your internet connection and try again."));
        }
      },
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 2,
              child: Row(
                children: [
                  Expanded(
                      child: pageIndex == 0
                          ? Container(
                              decoration: BoxDecoration(
                                color: redCA1F27Color,
                                // borderRadius: BorderRadius.all(Radius.circular(100))
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 22),
                            )
                          : SizedBox.shrink()),
                  Expanded(
                      child: pageIndex == 1
                          ? Container(
                              decoration: BoxDecoration(
                                color: redCA1F27Color,
                                // borderRadius: BorderRadius.all(Radius.circular(100))
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 22),
                            )
                          : SizedBox.shrink()),
                  Expanded(
                      child: pageIndex == 2
                          ? Container(
                              decoration: BoxDecoration(
                                color: redCA1F27Color,
                                // borderRadius: BorderRadius.all(Radius.circular(100))
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 22),
                            )
                          : SizedBox.shrink()),
                ],
              ),
            ),
            BottomNavigationBar(
              backgroundColor: mediumDarkGreyF1F1F1Color,
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              selectedItemColor: redCA1F27Color,
              onTap: (int index) {
                setState(
                  () {
                    pageIndex = index;
                  },
                );
              },
              currentIndex: pageIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon:
                      // pageIndex == 0
                      //     ?
                      Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: redCA1F27Color,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                                "$svgAssetsBasePath/bottom1_fill.svg",
                                color: pageIndex == 0
                                    ? redCA1F27Color
                                    : grey6B7280Color),
                          )),
                  //: Icon(Icons.signal_cellular_alt,size: 30),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: redCA1F27Color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                            "$svgAssetsBasePath/bottom2_outline.svg",
                            color: pageIndex == 1
                                ? redCA1F27Color
                                : grey6B7280Color),
                      )),
                  label: 'Requests',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: redCA1F27Color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                            "$svgAssetsBasePath/bottom3_outline.svg",
                            color: pageIndex == 2
                                ? redCA1F27Color
                                : grey6B7280Color),
                      )),
                  label: 'Profile',
                ),
                // BottomNavigationBarItem(
                //   icon: selectedIndex == 1
                //       ? Container(
                //       height: 30,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: goldenEFC441Color,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: SvgPicture.asset(
                //           "$svgAssetsBasePath/mix_icon.svg",
                //           color: whiteFFFFFFColor,
                //         ),
                //       ))
                //       : SvgPicture.asset("$svgAssetsBasePath/mix_icon.svg"),
                //   label: 'Mix',
                // ),
                // BottomNavigationBarItem(
                //   icon: selectedIndex == 2
                //       ? Container(
                //       height: 30,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: goldenEFC441Color,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: SvgPicture.asset(
                //           "$svgAssetsBasePath/product.svg",
                //           color: whiteFFFFFFColor,
                //         ),
                //       ))
                //       : SvgPicture.asset("$svgAssetsBasePath/product.svg"),
                //   label: 'Product',
                // ),
                // BottomNavigationBarItem(
                //   icon: selectedIndex == 3
                //       ? Container(
                //       height: 30,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: goldenEFC441Color,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: SvgPicture.asset("$svgAssetsBasePath/cart.svg",
                //             color: whiteFFFFFFColor),
                //       ))
                //       : SvgPicture.asset("$svgAssetsBasePath/cart.svg"),
                //   label: 'Cart',
                // ),
                // BottomNavigationBarItem(
                //   icon: selectedIndex == 4
                //       ? Container(
                //       height: 30,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: goldenEFC441Color,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: SvgPicture.asset("$svgAssetsBasePath/account.svg",
                //             color: whiteFFFFFFColor),
                //       ))
                //       : SvgPicture.asset("$svgAssetsBasePath/account.svg"),
                //   label: 'Account',
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
