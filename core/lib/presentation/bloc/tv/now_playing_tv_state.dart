part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTVState extends Equatable {}

class NowPlayingTVEmpty extends NowPlayingTVState {
  @override
  List<Object> get props => [];
}

class NowPlayingTVLoading extends NowPlayingTVState {
  @override
  List<Object> get props => [];
}

class NowPlayingTVError extends NowPlayingTVState {
  final String message;
  NowPlayingTVError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTVData extends NowPlayingTVState {
  final List<TV> tv;
  NowPlayingTVData(this.tv);

  @override
  List<Object> get props => [tv];
}
