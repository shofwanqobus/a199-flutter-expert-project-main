import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TVTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TVTable.fromEntity(TVDetail tv) => TVTable(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory TVTable.fromDTO(TVModel tvModel) => TVTable(
        id: tvModel.id,
        name: tvModel.name,
        posterPath: tvModel.posterPath,
        overview: tvModel.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TV toEntity() => TV.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}
