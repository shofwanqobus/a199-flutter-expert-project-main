import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tvs.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTVBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetWatchlistTvs getWatchlistTV;

  WatchlistTVBloc({
    required this.getWatchlistTV,
  }) : super(WatchlistTVEmpty()) {
    on<FetchWatchlistTV>(_fetchWatchlistTV);
  }

  void _fetchWatchlistTV(FetchWatchlistTV fetchWatchlistTV,
      Emitter<WatchlistTVState> emitter) async {
    emitter(WatchlistTVLoading());
    final hasil = await getWatchlistTV.execute();
    hasil.fold(
      (failure) => emitter(WatchlistTVError(failure.message)),
      (data) => data.isNotEmpty
          ? emitter(WatchlistTVData(data))
          : emitter(WatchlistTVEmpty()),
    );
  }
}
