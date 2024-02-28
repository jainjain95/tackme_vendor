class ApprovedRequestlModel {
  bool? status;
  String? message;
  List<Data>? data;

  ApprovedRequestlModel({this.status, this.message, this.data});

  ApprovedRequestlModel.fromJson(Map<String, dynamic> json) {
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
  Customer? customer;
  Stop? stop;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.customer,
      this.stop,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    stop = json['stop'] != null ? new Stop.fromJson(json['stop']) : null;
    status = json['status'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Customer {
  String? id;
  String? name;
  String? lastName;
  PhoneNumber? phoneNumber;
  Location? location;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.lastName,
      this.phoneNumber,
      this.location,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'] != null
        ? new PhoneNumber.fromJson(json['phoneNumber'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    if (this.phoneNumber != null) {
      data['phoneNumber'] = this.phoneNumber!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class PhoneNumber {
  String? dialCode;
  String? number;

  PhoneNumber({this.dialCode, this.number});

  PhoneNumber.fromJson(Map<String, dynamic> json) {
    dialCode = json['dialCode'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dialCode'] = this.dialCode;
    data['number'] = this.number;
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
  Location? location;
  String? createdAt;
  String? updatedAt;

  Stop({this.id, this.location, this.createdAt, this.updatedAt});

  Stop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
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

class LocationS{
  String? locationNickName;
  List<double>? coordinates;
  String? text;
  String? type;

  LocationS({this.locationNickName, this.coordinates, this.text, this.type});

  LocationS.fromJson(Map<String, dynamic> json) {
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