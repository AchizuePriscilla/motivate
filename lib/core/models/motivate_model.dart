class MotivateModel {
  String affirmation;

  MotivateModel({this.affirmation});

  MotivateModel.fromJson(Map<String, dynamic> json) {
    affirmation = json['affirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affirmation'] = this.affirmation;
    return data;
  }
}