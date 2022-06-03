part of 'watchlist_tv_modify_bloc.dart';

abstract class WatchListTVModifyEvent extends Equatable {}

class AddTV extends WatchListTVModifyEvent {
  final TVDetail tvDetail;
  AddTV(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveTV extends WatchListTVModifyEvent {
  final TVDetail tvDetail;
  RemoveTV(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
