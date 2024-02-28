
class RouteModel {
  bool? status;
  String? message;
  List<RData>? data;

  RouteModel({this.status, this.message, this.data});

  RouteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RData>[];
      json['data'].forEach((v) {
        data!.add(new RData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RData {
  String? id;
  String? routeNickName;
  List<Stops>? stops;
  Schedule? schedule;
  List<PolyLine>? polyLine;
  String? createdAt;
  String? updatedAt;

  RData(
      {this.id,
      this.routeNickName,
      this.stops,
      this.schedule,
      this.polyLine,
      this.createdAt,
      this.updatedAt});

  RData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeNickName = json['routeNickName'];
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(new Stops.fromJson(v));
      });
    }
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
    if (json['polyLine'] != null) {
      polyLine = <PolyLine>[];
      json['polyLine'].forEach((v) {
        polyLine!.add(new PolyLine.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['routeNickName'] = this.routeNickName;
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.toJson();
    }
    if (this.polyLine != null) {
      data['polyLine'] = this.polyLine!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Stops {
  String? sid;
  Location? location;
  String? vendorId;
  String? createdAt;
  String? updatedAt;

  Stops(
      {this.sid, this.location, this.vendorId, this.createdAt, this.updatedAt});

  Stops.fromJson(Map<String, dynamic> json) {
    sid = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    vendorId = json['vendorId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sid;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['vendorId'] = this.vendorId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Location {
  String? locationNickName;
  List<double>? coordinates;
  String? text;
  String? type;

  Location({this.locationNickName, this.coordinates, this.text, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    locationNickName = json['locationNickName'];
    coordinates = json['coordinates'].cast<double>();
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationNickName'] = this.locationNickName;
    data['coordinates'] = this.coordinates;
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}

class Schedule {
  String? id;
  String? startTime;
  String? endTime;
  String? scheduleName;
  String? vendorId;
  List<String>? days;
  bool? liveLocation;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;

  Schedule(
      {this.id,
      this.startTime,
      this.endTime,
      this.scheduleName,
      this.vendorId,
      this.days,
      this.liveLocation,
      this.createdAt,
      this.updatedAt,
      this.isDeleted});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    scheduleName = json['scheduleName'];
    vendorId = json['vendorId'];
    days = json['days'].cast<String>();
    liveLocation = json['liveLocation'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['scheduleName'] = this.scheduleName;
    data['vendorId'] = this.vendorId;
    data['days'] = this.days;
    data['liveLocation'] = this.liveLocation;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}

class PolyLine {
  double? longitude;
  double? latitude;

  PolyLine({this.longitude, this.latitude});

  PolyLine.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}