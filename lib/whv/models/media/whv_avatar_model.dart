
class WhvAvatarModel {

  int? result;

  WhvAvatarModel({this.result});

  factory WhvAvatarModel.fromJson(Map<String, dynamic> json) {
    return WhvAvatarModel(
        result: json['result']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['result'] = this.result;

    return data;
  }
}
