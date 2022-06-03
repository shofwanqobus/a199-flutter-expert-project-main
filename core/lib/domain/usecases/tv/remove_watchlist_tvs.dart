import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TVRepository tvRepository;

  RemoveWatchlistTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return tvRepository.removeWatchlist(tv);
  }
}
