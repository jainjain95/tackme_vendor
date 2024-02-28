class ComInfoReqModel {
  String? companyName;
  String? companyWebsite;
  String? companyAdditionalInfo;
  List<String>? businessCategory;
  String? image;


  ComInfoReqModel(
      {this.companyName,
      this.companyWebsite,
      this.companyAdditionalInfo,
      this.businessCategory,
      this.image,
  });
}