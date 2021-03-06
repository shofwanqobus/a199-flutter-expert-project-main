import 'dart:convert';

import 'package:core/data/models/tv/seasons_detail_model.dart';
import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:core/core.dart';
import 'package:http/io_client.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getNowPlayingTVs();
  Future<List<TVModel>> getPopularTVs();
  Future<List<TVModel>> getTopRatedTvs();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TVModel>> getTvRecommendations(int id);
  Future<List<TVModel>> searchTVs(String query);
  Future<SeasonsDetailModel> getDetailSeasons(int idTv, int season);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  final IOClient client;

  TVRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<TVModel>> getNowPlayingTVs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTVs() async {
    final response =
        await client.get(Uri.parse(BASE_URL + '/tv/popular?' + API_KEY));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTVs(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonsDetailModel> getDetailSeasons(int idTv, int season) async {
    final response = await client
        .get(Uri.parse(BASE_URL + '/tv/$idTv/season/$season?' + API_KEY));

    if (response.statusCode == 200) {
      return SeasonsDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
