import 'package:uuid/uuid.dart';

class NasaPicture {
  String date;
  String explanation;
  String title;
  String url;
  String id;

  NasaPicture({
    required this.date,
    required this.explanation,
    required this.title,
    required this.url,
    required this.id
  });

  factory NasaPicture.fromMap(Map<String, dynamic> json) {
    return NasaPicture(
      date: json['date'] as String,
      explanation: json['explanation'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      id: json['id'] ?? const Uuid().v4()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'explanation': explanation,
      'title': title,
      'url': url,
      'id': id
    };
  }
}
