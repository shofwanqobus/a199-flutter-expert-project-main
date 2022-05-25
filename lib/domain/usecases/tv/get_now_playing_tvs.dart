import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingTvs {
  final TVRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
