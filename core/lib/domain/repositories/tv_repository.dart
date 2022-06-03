import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv_seasons_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingTvs();
  Future<Either<Failure, List<TV>>> getPopularTvs();
  Future<Either<Failure, List<TV>>> getTopRatedTvs();
  Future<Either<Failure, TVDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTvs(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TVDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTvs();
  Future<Either<Failure, SeasonsDetail>> getSeasonsDetail(int idTv, int season);
}
