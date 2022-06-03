part of 'tv_detail_bloc.dart';

abstract class TVDetailState extends Equatable {}

class TVDetailEmpty extends TVDetailState {
  @override
  List<Object> get props => [];
}

class TVDetailLoading extends TVDetailState {
  @override
  List<Object> get props => [];
}

class TVDetailError extends TVDetailState {
  final String message;
  TVDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVDetailData extends TVDetailState {
  final TVDetail tvDetail;
  final List<TV> tv;
  TVDetailData(this.tvDetail, this.tv);

  @override
  List<Object> get props => [tvDetail, tv];
}
