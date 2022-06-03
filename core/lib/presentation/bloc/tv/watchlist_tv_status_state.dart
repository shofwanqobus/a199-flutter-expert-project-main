part of 'watchlist_tv_status_bloc.dart';

abstract class TVWatchlistStatusState extends Equatable {}

class TVWatchlistStatusEmpty extends TVWatchlistStatusState {
  @override
  List<Object> get props => [];
}

class TVStatusState extends TVWatchlistStatusState {
  final bool isAddedToWatchlist;

  TVStatusState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
