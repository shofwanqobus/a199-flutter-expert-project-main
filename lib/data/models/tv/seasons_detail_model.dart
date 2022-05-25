import 'package:ditonton/data/models/tv/episode_model.dart';
import 'package:ditonton/domain/entities/tv/tv_seasons_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonsDetailModel extends Equatable {
  SeasonsDetailModel({
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
  List<EpisodeModel>? episodes;
  String? name;
  String? overview;
  int? seasonsDetailModelId;
  String? posterPath;
  int? seasonNumber;

  factory SeasonsDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonsDetailModel(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonsDetailModelId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes!.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonsDetailModelId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  SeasonsDetail toEntity() {
    return SeasonsDetail(
      id: id,
      airDate: airDate,
      episodes: episodes!.map((e) => e.toEntity()).toList(),
      name: name,
      overview: overview,
      seasonsDetailModelId: seasonsDetailModelId,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

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
