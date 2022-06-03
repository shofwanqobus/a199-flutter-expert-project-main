part of 'search_bloc.dart';

abstract class TVSearchState extends Equatable {}

class TVSearchEmpty extends TVSearchState {
  @override
  List<Object> get props => [];
}

class TVSearchLoading extends TVSearchState {
  @override
  List<Object> get props => [];
}

class TVSearchError extends TVSearchState {
  final String pesan;

  TVSearchError(this.pesan);

  @override
  List<Object> get props => [pesan];
}

class SearchTVData extends TVSearchState {
  final List<TV> hasil;

  SearchTVData(this.hasil);

  @override
  List<Object> get props => [hasil];
}
