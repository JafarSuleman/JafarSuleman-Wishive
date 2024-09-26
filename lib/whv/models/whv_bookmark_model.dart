import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WhvBookmarkModel {
  final int id;
  final String title;
  final String url;
  final DateTime date;

  WhvBookmarkModel({
    required this.id,
    required this.title,
    required this.url,
    required this.date,
  });

  WhvBookmarkModel copyWith({
    int? id,
    String? title,
    String? url,
    DateTime? date,
  }) {
    return WhvBookmarkModel(
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

  factory WhvBookmarkModel.fromMap(Map<String, dynamic> map) {
    return WhvBookmarkModel(
      id: int.parse(map['id']),
      title: map['title'] as String,
      url: map['url'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory WhvBookmarkModel.fromJson(String source) =>
      WhvBookmarkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WhvBookmarkModel(id: $id, title: $title, url: $url, date: $date)';
  }

  @override
  bool operator ==(covariant WhvBookmarkModel other) {
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
