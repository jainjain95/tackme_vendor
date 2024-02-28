
class SignupModel {
  bool? status;
  String? message;
  Data? data;

  SignupModel({this.status, this.message, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? email;
  String? additionalInfo;
  String? profileImage;
  PhoneNumber? phoneNumber;
  String? foodTruckRego;
  String? createdAt;
  String? updatedAt;
  CompanyInfo? companyInfo;
  String? qrCode;
  bool? notification;

  Data(
      {this.sId,
      this.name,
      this.email,
      this.additionalInfo,
      this.profileImage,
      this.phoneNumber,
      this.foodTruckRego,
      this.createdAt,
      this.updatedAt,
      this.companyInfo,
      this.qrCode,
      this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    additionalInfo = json['additionalInfo'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'] != null
        ? new PhoneNumber.fromJson(json['phoneNumber'])
        : null;
    foodTruckRego = json['foodTruckRego'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    companyInfo = json['companyInfo'] != null
        ? new CompanyInfo.fromJson(json['companyInfo'])
        : null;
    qrCode = json['qrCode'];
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['additionalInfo'] = this.additionalInfo;
    data['profileImage'] = this.profileImage;
    if (this.phoneNumber != null) {
      data['phoneNumber'] = this.phoneNumber!.toJson();
    }
    data['foodTruckRego'] = this.foodTruckRego;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.companyInfo != null) {
      data['companyInfo'] = this.companyInfo!.toJson();
    }
    data['qrCode'] = this.qrCode;
    data['notification'] = this.notification;
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

class CompanyInfo {
  String? companyName;
  String? companyWebsite;
  String? companyAdditionalInfo;
  String? image;
  List<BusinessCategory>? businessCategory;

  CompanyInfo(
      {this.companyName,
      this.companyWebsite,
      this.companyAdditionalInfo,
      this.image,
      this.businessCategory});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyWebsite = json['companyWebsite'];
    companyAdditionalInfo = json['companyAdditionalInfo'];
    image = json['image'];
    if (json['businessCategory'] != null) {
      businessCategory = <BusinessCategory>[];
      json['businessCategory'].forEach((v) {
        businessCategory!.add(new BusinessCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['companyWebsite'] = this.companyWebsite;
    data['companyAdditionalInfo'] = this.companyAdditionalInfo;
    data['image'] = this.image;
    if (this.businessCategory != null) {
      data['businessCategory'] =
          this.businessCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessCategory {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;

  BusinessCategory(
      {this.id, this.name, this.createdAt, this.updatedAt, this.isDeleted});

  BusinessCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}