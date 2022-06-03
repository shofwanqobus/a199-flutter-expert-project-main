import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tvs.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';

part 'watchlist_tv_modify_event.dart';
part 'watchlist_tv_modify_state.dart';

class WatchListTVModifyBloc
    extends Bloc<WatchListTVModifyEvent, WatchListTVModifyState> {
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  WatchListTVModifyBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchListTVModifyEmpty()) {
    on<AddTV>(_addWatchlist);
    on<RemoveTV>(_removeWatchlist);
  }

  void _addWatchlist(AddTV tv, Emitter<WatchListTVModifyState> emitter) async {
    emitter(WatchListTVModifyLoading());
    final result = await saveWatchlist.execute(tv.tvDetail);

    result.fold(
      (failure) => emitter(WatchListTVModifyError(failure.message)),
      (success) => emitter(TVAdd(success)),
    );
  }

  void _removeWatchlist(
      RemoveTV tv, Emitter<WatchListTVModifyState> emitter) async {
    emitter(WatchListTVModifyLoading());
    final result = await removeWatchlist.execute(tv.tvDetail);

    result.fold(
      (failure) => emitter(WatchListTVModifyError(failure.message)),
      (success) => emitter(TVRemove(success)),
    );
  }
}
