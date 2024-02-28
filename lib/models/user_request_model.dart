class UserRequestModel {
  bool? status;
  String? message;
  List<DataR>? data;

  UserRequestModel({this.status, this.message, this.data});

  UserRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataR>[];
      json['data'].forEach((v) {
        data!.add(new DataR.fromJson(v));
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

class DataR {
  String? id;
  Customer? customer;
  Stop? stop;
  String? status;
  List<PolyLine>? polyLine;
  String? createdAt;
  String? updatedAt;

  DataR(
      {this.id,
      this.customer,
      this.stop,
      this.status,
      this.polyLine,
      this.createdAt,
      this.updatedAt});

  DataR.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    stop = json['stop'] != null ? new Stop.fromJson(json['stop']) : null;
    status = json['status'];
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
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.stop != null) {
      data['stop'] = this.stop!.toJson();
    }
    data['status'] = this.status;
    if (this.polyLine != null) {
      data['polyLine'] = this.polyLine!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Customer {
  String? id;
  String? name;
  String? lastName;
  Location? location;

  Customer({this.id, this.name, this.lastName, this.location});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  List<double>? coordinates;
  String? address;
  String? type;

  Location({this.coordinates, this.address, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['address'] = this.address;
    data['type'] = this.type;
    return data;
  }
}

class Stop {
  String? id;
  LocationR? location;
  String? createdAt;
  String? updatedAt;

  Stop({this.id, this.location, this.createdAt, this.updatedAt});

  Stop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'] != null
        ? new LocationR.fromJson(json['location'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class LocationR {
  String? locationNickName;
  List<double>? coordinates;
  String? text;
  String? type;

  LocationR({this.locationNickName, this.coordinates, this.text, this.type});

  LocationR.fromJson(Map<String, dynamic> json) {
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