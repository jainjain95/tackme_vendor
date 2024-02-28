import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagmevendor/core/colors/app_colors.dart';
import 'package:tagmevendor/core/constants/font_weight.dart';
import 'package:tagmevendor/data/local_db/token_db.dart';
import 'package:tagmevendor/presentation/router/app_router.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: GestureDetector(
            onTap: () {},
            child: Container(
              height: 200,
              width: 230,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Sign out of\nTack Me ?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: darkBlack000000Color,
                              fontWeight: semiBold))),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Helper.deleteUserIdData().then((value) => {
                        print("token delete"),
                        
                        print(value),
                        
                        Helper.deleteUid().then((value) async => {
                          print("uid delete"),
                          print(await Helper.getUid()),
                          print(value),
                          // AppRouter.navigatorKey.currentState
                          //           ?.pushNamed(AppRouter.login)
                          await Helper.deleteStatus(),
                          AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRouter.login, (route) => false)

                        })
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: redCA1F27Color),
                      child: Center(
                          child: Text("SIGN OUT",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 12.90,
                                      color: whiteFFFFFFColor,
                                      fontWeight: bold)))),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.navigatorKey.currentState?.pop();
                    },
                    child: Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: lightGreyF6F6F6Color),
                      child: Center(
                          child: Text("CANCEL",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 12.90,
                                      color: redCA1F27Color,
                                      fontWeight: bold)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}