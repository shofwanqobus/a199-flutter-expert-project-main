import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetNowPlayingTvs {
  final TVRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
