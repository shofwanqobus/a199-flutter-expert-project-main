part of 'watchlist_tv_modify_bloc.dart';

abstract class WatchListTVModifyState extends Equatable {}

class WatchListTVModifyEmpty extends WatchListTVModifyState {
  @override
  List<Object> get props => [];
}

class WatchListTVModifyLoading extends WatchListTVModifyState {
  @override
  List<Object> get props => [];
}

class WatchListTVModifyError extends WatchListTVModifyState {
  final String message;
  WatchListTVModifyError(this.message);

  @override
  List<Object> get props => [message];
}

class TVAdd extends WatchListTVModifyState {
  final String message;
  TVAdd(this.message);

  @override
  List<Object> get props => [message];
}

class TVRemove extends WatchListTVModifyState {
  final String message;
  TVRemove(this.message);

  @override
  List<Object> get props => [message];
}
