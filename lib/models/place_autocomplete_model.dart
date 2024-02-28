class PlaceAutocomplete {
  String? status;
  List<Prediction> predictions;

  PlaceAutocomplete({required this.predictions});

  factory PlaceAutocomplete.fromJson(Map<String, dynamic> json) {
    var predictionList = json['predictions'] as List;
    List<Prediction> predictions =
        predictionList.map((e) => Prediction.fromJson(e)).toList();

    return PlaceAutocomplete(predictions: predictions);
  }
}




class Prediction {
  String description;
  String placeId;

  Prediction({required this.description, required this.placeId});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}