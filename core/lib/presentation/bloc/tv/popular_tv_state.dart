part of 'popular_tv_bloc.dart';

abstract class PopularTVState extends Equatable {}

class PopularTVEmpty extends PopularTVState {
  @override
  List<Object> get props => [];
}

class PopularTVLoading extends PopularTVState {
  @override
  List<Object> get props => [];
}

class PopularTVError extends PopularTVState {
  final String message;
  PopularTVError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVData extends PopularTVState {
  final List<TV> tv;
  PopularTVData(this.tv);

  @override
  List<Object> get props => [tv];
}
