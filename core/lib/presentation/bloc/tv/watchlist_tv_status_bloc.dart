import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';

part 'watchlist_tv_status_event.dart';
part 'watchlist_tv_status_state.dart';

class TVWatchlistStatusBloc
    extends Bloc<TVWatchlistStatusEvent, TVWatchlistStatusState> {
  final GetWatchListStatusTv getTVWatchlistStatus;

  TVWatchlistStatusBloc({
    required this.getTVWatchlistStatus,
  }) : super(TVWatchlistStatusEmpty()) {
    on<FetchTVWatchlistStatus>(_fetchTVWatchlistStatus);
  }

  void _fetchTVWatchlistStatus(FetchTVWatchlistStatus fetchTVWatchlistStatus,
      Emitter<TVWatchlistStatusState> emitter) async {
    final hasil = await getTVWatchlistStatus.execute(fetchTVWatchlistStatus.id);
    emitter(TVStatusState(hasil));
  }
}
