part of 'watchlist_tv_status_bloc.dart';

abstract class TVWatchlistStatusEvent extends Equatable {}

class FetchTVWatchlistStatus extends TVWatchlistStatusEvent {
  final int id;
  FetchTVWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
