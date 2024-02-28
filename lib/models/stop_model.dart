class StopModel {
  bool? status;
  String? message;
  List<Data>? data;

  StopModel({this.status, this.message, this.data});

  StopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? id;
  Location? location;
  String? createdAt;
  String? updatedAt;
  String? qrCode;

  Data({this.id, this.location, this.createdAt, this.updatedAt, this.qrCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['qrCode'] = this.qrCode;
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