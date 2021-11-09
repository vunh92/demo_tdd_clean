
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';

class UpcomingModel extends Upcoming{

  UpcomingModel({
    String posterArtUrl,
    int id,
    String originalTitle,
  }) : super (posterArtUrl: posterArtUrl, id: id, originalTitle: originalTitle);

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      posterArtUrl: 'https://image.tmdb.org/t/p/original' + json['poster_path'],
      id: json['id'],
      originalTitle: json['original_title'],
    );
  }

  factory UpcomingModel.fromJsonLocal(Map<String, dynamic> json) {
    return UpcomingModel(
      posterArtUrl: json['posterArtUrl'],
      id: json['id'],
      originalTitle: json['original_title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posterArtUrl': posterArtUrl,
      'id': id,
      'originalTitle': originalTitle,
    };
  }

  static Map<String, dynamic> toJsonList({Upcoming upcoming}) {
    return {
      'posterArtUrl': upcoming.posterArtUrl,
      'id': upcoming.id,
      'originalTitle': upcoming.originalTitle,
    };
  }
}