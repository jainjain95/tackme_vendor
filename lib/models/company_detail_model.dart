class CompanyDetailModel {
  bool? status;
  String? message;
  Data? data;

  CompanyDetailModel({this.status, this.message, this.data});

  CompanyDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  String? companyWebsite;
  String? companyAdditionalInfo;
  String? image;
  List<BusinessCategory>? businessCategory;

  Data(
      {this.companyName,
      this.companyWebsite,
      this.companyAdditionalInfo,
      this.image,
      this.businessCategory});

  Data.fromJson(Map<String, dynamic> json) {
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