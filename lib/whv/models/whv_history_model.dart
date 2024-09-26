import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WhvHistoryModel {
  final int id;
  final String title;
  final String url;
  final DateTime date;

  WhvHistoryModel({
    required this.id,
    required this.title,
    required this.url,
    required this.date,
  });

  WhvHistoryModel copyWith({
    int? id,
    String? title,
    String? url,
    DateTime? date,
  }) {
    return WhvHistoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory WhvHistoryModel.fromMap(Map<String, dynamic> map) {
    return WhvHistoryModel(
      id: int.parse(map['id']),
      title: map['title'] as String,
      url: map['url'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory WhvHistoryModel.fromJson(String source) =>
      WhvHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WhvHistoryModel(id: $id, title: $title, url: $url, date: $date)';
  }

  @override
  bool operator ==(covariant WhvHistoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.url == url &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ url.hashCode ^ date.hashCode;
  }
}
