import 'dart:convert';

class WhvMessageReponseModel {
  String? status;
  String? error;

  WhvMessageReponseModel({this.status, this.error});

  @override
  String toString() {
    return 'WhvMessageReponseModel(status: $status, error: $error)';
  }

  factory WhvMessageReponseModel.fromMap(Map<String, dynamic> data) {
    return WhvMessageReponseModel(
      status: data['status'] as String?,
      error: data['error'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'error': error,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WhvMessageReponseModel].
  factory WhvMessageReponseModel.fromJson(String data) {
    return WhvMessageReponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WhvMessageReponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WhvMessageReponseModel copyWith({
    String? status,
    String? error,
  }) {
    return WhvMessageReponseModel(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
