import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv_seasons.dart';
import 'package:equatable/equatable.dart';

class TVDetail extends Equatable {
  TVDetail({
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<Genre>? genres;
  final int id;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<TVSeasons>? seasons;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        episodeRunTime,
        firstAirDate,
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        popularity,
        posterPath,
        seasons,
        type,
        voteAverage,
        voteCount,
      ];
}
