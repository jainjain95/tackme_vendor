
import 'dart:convert';

class ScheduleListModel {
    bool? status;
    String? message;
    List<Datum>? data;

    ScheduleListModel({
        this.status,
        this.message,
        this.data,
    });

    factory ScheduleListModel.fromRawJson(String str) => ScheduleListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ScheduleListModel.fromJson(Map<String, dynamic> json) => ScheduleListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? startTime;
    String? endTime;
    String? scheduleName;
    List<String>? days;
    bool? liveLocation;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.startTime,
        this.endTime,
        this.scheduleName,
        this.days,
        this.liveLocation,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        scheduleName: json["scheduleName"],
        days: json["days"] == null ? [] : List<String>.from(json["days"]!.map((x) => x)),
        liveLocation: json["liveLocation"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "scheduleName": scheduleName,
        "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
        "liveLocation": liveLocation,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

