part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTVState extends Equatable {}

class TopRatedTVEmpty extends TopRatedTVState {
  @override
  List<Object> get props => [];
}

class TopRatedTVLoading extends TopRatedTVState {
  @override
  List<Object> get props => [];
}

class TopRatedTVError extends TopRatedTVState {
  final String message;
  TopRatedTVError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVData extends TopRatedTVState {
  final List<TV> tv;
  TopRatedTVData(this.tv);

  @override
  List<Object> get props => [tv];
}
