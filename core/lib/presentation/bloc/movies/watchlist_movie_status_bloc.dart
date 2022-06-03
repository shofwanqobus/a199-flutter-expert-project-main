import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status.dart';

part 'watchlist_movie_status_event.dart';
part 'watchlist_movie_status_state.dart';

class WatchListStatusBloc
    extends Bloc<WatchListStatusEvent, WatchListStatusState> {
  final GetWatchListStatus getWatchListStatus;

  WatchListStatusBloc({
    required this.getWatchListStatus,
  }) : super(WatchListStatusEmpty()) {
    on<FetchWatchListStatus>(_fetchWatchListStatus);
  }

  void _fetchWatchListStatus(FetchWatchListStatus fetchWatchListStatus,
      Emitter<WatchListStatusState> emitter) async {
    final hasil = await getWatchListStatus.execute(fetchWatchListStatus.id);
    emitter(MovieStatusState(hasil));
  }
}
