class PredictionResultModel {
  dynamic result;
  dynamic precent;

  PredictionResultModel({required this.result, required this.precent});

  factory PredictionResultModel.fromJson(Map<String, dynamic> json) {
    return PredictionResultModel(
        result: json['prediction'], precent: json['Risk Rate']);
  }
}
