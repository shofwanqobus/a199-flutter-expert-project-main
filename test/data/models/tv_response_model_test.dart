import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2020-05-05',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
    name: 'Name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    popularity: 1.0,
    type: 'Type',
    originalName: 'Original Name',
  );
  final tTVResponseModel = TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now_playing.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2020-05-05",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "Name",
            "number_of_episodes": 1,
            "number_of_seasons": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "type": "Type",
            "vote_average": 1.0,
            "vote_count": 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
