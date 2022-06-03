part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVState extends Equatable {}

class WatchlistTVEmpty extends WatchlistTVState {
  @override
  List<Object> get props => [];
}

class WatchlistTVLoading extends WatchlistTVState {
  @override
  List<Object> get props => [];
}

class WatchlistTVError extends WatchlistTVState {
  final String message;
  WatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVData extends WatchlistTVState {
  final List<TV> tv;
  WatchlistTVData(this.tv);

  @override
  List<Object> get props => [tv];
}
