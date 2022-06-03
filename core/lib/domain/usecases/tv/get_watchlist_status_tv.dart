import 'package:core/domain/repositories/tv_repository.dart';

class GetWatchListStatusTv {
  final TVRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
