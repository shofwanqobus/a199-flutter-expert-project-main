import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class SaveWatchlistTV {
  final TVRepository tvRepository;

  SaveWatchlistTV(this.tvRepository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return tvRepository.saveWatchlist(tv);
  }
}
