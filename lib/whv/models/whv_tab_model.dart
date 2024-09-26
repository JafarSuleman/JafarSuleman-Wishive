// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

class WhvTabModel {
  final int id;
  final String title;
  final String url;
  final Uint8List? preview;

  WhvTabModel({
    required this.id,
    required this.title,
    required this.url,
    required this.preview,
  });

  WhvTabModel copyWith({
    int? id,
    String? title,
    String? url,
    Uint8List? preview,
  }) {
    return WhvTabModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      preview: preview ?? this.preview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
      'preview': preview ?? [],
    };
  }

  factory WhvTabModel.fromMap(Map<String, dynamic> map) {
    var preview = _getImageBinary(map['preview']);
    return WhvTabModel(
      id: int.parse(map['id'].toString()),
      title: map['title'] as String,
      url: map['url'] as String,
      preview: preview,
    );
  }

  String toJson() => json.encode(toMap());

  factory WhvTabModel.fromJson(String source) =>
      WhvTabModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WhvTabModel(id: $id, title: $title, url: $url)';

  @override
  bool operator ==(covariant WhvTabModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ url.hashCode;

  static Uint8List? _getImageBinary(List<dynamic> dynamicList) {
    if (dynamicList.isEmpty) {
      return null;
    }
    List<int> intList =
        dynamicList.cast<int>().toList(); //This is the magical line.
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }
}
