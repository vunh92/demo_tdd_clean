import 'package:equatable/equatable.dart';

class Upcoming extends Equatable{
  final String posterArtUrl;
  final int id;
  final String originalTitle;

  Upcoming({
    this.posterArtUrl,
    this.id,
    this.originalTitle,
  });


  @override
  List<Object> get props => [posterArtUrl, id, originalTitle];

}