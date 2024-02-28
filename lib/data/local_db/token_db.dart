import 'package:shared_preferences/shared_preferences.dart';

class Helper {

 
// Save token
static Future<bool> saveUserIdData(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("token", value);
  }
// Save uId
static Future<bool> saveUid(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("uid", value);
}
// Save status
static Future<bool> saveStatus(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("status", value);
}

static Future<bool> saveNumber(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("number", value);
}


   
// Read token
static Future<String> getUserIdData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? token = sharedPreferences.getString("token");
    String? token = await sharedPreferences.getString("token") ?? "";
    return token;
  }
// read uid
static Future<String> getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? token = sharedPreferences.getString("token");
    String? uid = await sharedPreferences.getString("uid") ?? "";
    return uid;
}
// read status
static Future<String> getStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? token = sharedPreferences.getString("token");
    String? status = await sharedPreferences.getString("status") ?? "";
    return status;
}

static Future<String> getNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? token = sharedPreferences.getString("token");
    String? status = await sharedPreferences.getString("number") ?? "";
    return status;
}


// delete token 
static Future<bool> deleteUserIdData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? tokenn = await sharedPreferences.getString("token");
    sharedPreferences.remove("token");
    return true;
  }
// delete uid 
static Future<bool> deleteUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? tokenn = await sharedPreferences.getString("token");
    sharedPreferences.remove("uid");
    return true;
  }
// delete status 
static Future<bool> deleteStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? tokenn = await sharedPreferences.getString("token");
    sharedPreferences.remove("status");
    return true;
  }

static Future<bool> deleteNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? tokenn = await sharedPreferences.getString("token");
    sharedPreferences.remove("number");
    return true;
  }


}


