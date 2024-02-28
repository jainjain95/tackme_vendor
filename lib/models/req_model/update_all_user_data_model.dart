class UpdateAllUserDataReqModel {
  String? name;
  String? additionalInfo;
  String? dialCode;
  String? number;
  String? foodTruckRego;

  String? companyName;
  String? companyWebsite;
  String? companyAdditionalInfo;
  List<String>? businessCategory;
  String? image;



  UpdateAllUserDataReqModel(
  {   
      this.name,
      this.additionalInfo,
      this.dialCode,
      this.number,
      this.foodTruckRego,

      this.companyName,
      this.companyWebsite,
      this.companyAdditionalInfo,
      this.businessCategory,
      this.image
  });
}