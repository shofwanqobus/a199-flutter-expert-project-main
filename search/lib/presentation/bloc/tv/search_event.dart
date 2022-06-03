part of 'search_bloc.dart';

abstract class TVSearchEvent extends Equatable {}

class OnTVQueryChanged extends TVSearchEvent {
  final String query;

  OnTVQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
