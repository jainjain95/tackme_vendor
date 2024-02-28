
class StartRouteModel {
  bool? status;
  String? message;
  Route? route;

  StartRouteModel({this.status, this.message, this.route});

  StartRouteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.route != null) {
      data['route'] = this.route!.toJson();
    }
    return data;
  }
}

class Route {
  String? id;
  String? routeId;
  RouteName? routeName;
  String? startTime;
  String? endTime;
  String? vendorId;
  String? distance;
  String? duration;
  PolyLines? polyLines;
  List<Stops>? stops;
  StartingLocation? startingLocation;

  Route(
      {this.id,
      this.routeId,
      this.routeName,
      this.startTime,
      this.endTime,
      this.vendorId,
      this.distance,
      this.duration,
      this.polyLines,
      this.stops,
      this.startingLocation});

  Route.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['routeId'];
    routeName = json['routeName'] != null
        ? new RouteName.fromJson(json['routeName'])
        : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
    vendorId = json['vendorId'];
    distance = json['distance'];
    duration = json['duration'];
    polyLines = json['polyLines'] != null
        ? new PolyLines.fromJson(json['polyLines'])
        : null;
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(new Stops.fromJson(v));
      });
    }
    startingLocation = json['startingLocation'] != null
        ? new StartingLocation.fromJson(json['startingLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['routeId'] = this.routeId;
    if (this.routeName != null) {
      data['routeName'] = this.routeName!.toJson();
    }
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['vendorId'] = this.vendorId;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    if (this.polyLines != null) {
      data['polyLines'] = this.polyLines!.toJson();
    }
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    if (this.startingLocation != null) {
      data['startingLocation'] = this.startingLocation!.toJson();
    }
    return data;
  }
}

class RouteName {
  String? routeNickName;

  RouteName({this.routeNickName});

  RouteName.fromJson(Map<String, dynamic> json) {
    routeNickName = json['routeNickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routeNickName'] = this.routeNickName;
    return data;
  }
}

class PolyLines {
  String? startPointType;
  String? startPointStopId;
  String? endPointStopId;
  List<PolyLine>? polyLine;

  PolyLines(
      {this.startPointType,
      this.startPointStopId,
      this.endPointStopId,
      this.polyLine});

  PolyLines.fromJson(Map<String, dynamic> json) {
    startPointType = json['startPointType'];
    startPointStopId = json['startPointStopId'];
    endPointStopId = json['endPointStopId'];
    if (json['polyLine'] != null) {
      polyLine = <PolyLine>[];
      json['polyLine'].forEach((v) {
        polyLine!.add(new PolyLine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPointType'] = this.startPointType;
    data['startPointStopId'] = this.startPointStopId;
    data['endPointStopId'] = this.endPointStopId;
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
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Stops {
  String? sid;
  Location? location;
  String? qrCode;
  String? arrivedTime;
  String? status;
  bool? isArrived;

  Stops(
      {this.sid,
      this.location,
      this.qrCode,
      this.arrivedTime,
      this.status,
      this.isArrived});

  Stops.fromJson(Map<String, dynamic> json) {
    sid = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    qrCode = json['qrCode'];
    arrivedTime = json['arrivedTime'];
    status = json['status'];
    isArrived = json['isArrived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sid;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['qrCode'] = this.qrCode;
    data['arrivedTime'] = this.arrivedTime;
    data['status'] = this.status;
    data['isArrived'] = this.isArrived;
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

class StartingLocation {
  String? startAddress;
  PolyLine? coordinates;
  String? type;

  StartingLocation({this.startAddress, this.coordinates, this.type});

  StartingLocation.fromJson(Map<String, dynamic> json) {
    startAddress = json['start_address'];
    coordinates = json['coordinates'] != null
        ? new PolyLine.fromJson(json['coordinates'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_address'] = this.startAddress;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}