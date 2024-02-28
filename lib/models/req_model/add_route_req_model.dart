class AddRouteReqModel {
  String? routeNickName;
  List<String>? stops;
  String? vendorId;
  String? schedule;
  List<PolyLine>? polyLine;
  String? routeId;

  AddRouteReqModel(
      {this.routeNickName,
      this.stops,
      this.vendorId,
      this.schedule,
      this.polyLine,
      this.routeId
      });

  AddRouteReqModel.fromJson(Map<String, dynamic> json) {
    routeNickName = json['routeNickName'];
    stops = json['stops'].cast<String>();
    vendorId = json['vendorId'];
    schedule = json['schedule'];
    if (json['polyLine'] != null) {
      polyLine = <PolyLine>[];
      json['polyLine'].forEach((v) {
        polyLine!.add(new PolyLine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routeNickName'] = this.routeNickName;
    data['stops'] = this.stops;
    data['vendorId'] = this.vendorId;
    data['schedule'] = this.schedule;
    if (this.polyLine != null) {
      data['polyLine'] = this.polyLine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PolyLine {
  double? longitude;
  double? latitude;

  PolyLine({this.longitude, this.latitude});

  PolyLine.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}