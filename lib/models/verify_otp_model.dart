// import 'dart:convert';

// class UserDataModel {
//     bool status;
//     String message;
//     Data data;
//     Schedule schedule;
//     String token;

//     UserDataModel({
//         required this.status,
//         required this.message,
//         required this.data,
//         required this.schedule,
//         required this.token,
//     });

//     factory UserDataModel.fromRawJson(String str) => UserDataModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//         schedule: Schedule.fromJson(json["schedule"]),
//         token: json["token"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//         "schedule": schedule.toJson(),
//         "token": token,
//     };
// }

// class Data {
//     String id;
//     String name;
//     String email;
//     String additionalInfo;
//     PhoneNumber phoneNumber;
//     String foodTruckRego;
//     DateTime createdAt;
//     DateTime updatedAt;
//     CompanyInfo companyInfo;

//     Data({
//         required this.id,
//         required this.name,
//         required this.email,
//         required this.additionalInfo,
//         required this.phoneNumber,
//         required this.foodTruckRego,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.companyInfo,
//     });

//     factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         name: json["name"],
//         email: json["email"],
//         additionalInfo: json["additionalInfo"],
//         phoneNumber: PhoneNumber.fromJson(json["phoneNumber"]),
//         foodTruckRego: json["foodTruckRego"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         companyInfo: CompanyInfo.fromJson(json["companyInfo"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "email": email,
//         "additionalInfo": additionalInfo,
//         "phoneNumber": phoneNumber.toJson(),
//         "foodTruckRego": foodTruckRego,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "companyInfo": companyInfo.toJson(),
//     };
// }

// class CompanyInfo {
//     String companyName;
//     String companyWebsite;
//     String companyAdditionalInfo;
//     String image;
//     dynamic businessCategory;

//     CompanyInfo({
//         required this.companyName,
//         required this.companyWebsite,
//         required this.companyAdditionalInfo,
//         required this.image,
//         required this.businessCategory,
//     });

//     factory CompanyInfo.fromRawJson(String str) => CompanyInfo.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
//         companyName: json["companyName"],
//         companyWebsite: json["companyWebsite"],
//         companyAdditionalInfo: json["companyAdditionalInfo"],
//         image: json["image"],
//         businessCategory: json["businessCategory"],
//     );

//     Map<String, dynamic> toJson() => {
//         "companyName": companyName,
//         "companyWebsite": companyWebsite,
//         "companyAdditionalInfo": companyAdditionalInfo,
//         "image": image,
//         "businessCategory": businessCategory,
//     };
// }

// class PhoneNumber {
//     String dialCode;
//     String number;

//     PhoneNumber({
//         required this.dialCode,
//         required this.number,
//     });

//     factory PhoneNumber.fromRawJson(String str) => PhoneNumber.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
//         dialCode: json["dialCode"],
//         number: json["number"],
//     );

//     Map<String, dynamic> toJson() => {
//         "dialCode": dialCode,
//         "number": number,
//     };
// }

// class Schedule {
//     String id;
//     String startTime;
//     String endTime;
//     String scheduleName;
//     List<String> days;
//     bool liveLocation;
//     DateTime createdAt;
//     DateTime updatedAt;

//     Schedule({
//         required this.id,
//         required this.startTime,
//         required this.endTime,
//         required this.scheduleName,
//         required this.days,
//         required this.liveLocation,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory Schedule.fromRawJson(String str) => Schedule.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
//         id: json["id"],
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         scheduleName: json["scheduleName"],
//         days: List<String>.from(json["days"].map((x) => x)),
//         liveLocation: json["liveLocation"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "startTime": startTime,
//         "endTime": endTime,
//         "scheduleName": scheduleName,
//         "days": List<dynamic>.from(days.map((x) => x)),
//         "liveLocation": liveLocation,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//     };
// }