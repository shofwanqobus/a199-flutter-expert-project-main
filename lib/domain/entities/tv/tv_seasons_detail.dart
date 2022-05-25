import 'package:ditonton/domain/entities/tv/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonsDetail extends Equatable {
  SeasonsDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonsDetailModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  String? id;
  DateTime? airDate;
  List<Episode>? episodes;
  String? name;
  String? overview;
  int? seasonsDetailModelId;
  String? posterPath;
  int? seasonNumber;

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonsDetailModelId,
        posterPath,
        seasonNumber,
      ];
}
