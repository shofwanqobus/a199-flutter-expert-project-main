import 'package:search/presentation/bloc/movies/search_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';

class MockMoviesSearchBloc
    extends MockBloc<MoviesSearchEvent, MoviesSearchState>
    implements MoviesSearchBloc {}

class MoviesSearchStateFake extends Fake implements MoviesSearchState {}

class MoviesSearchEventFake extends Fake implements MoviesSearchEvent {}

class MockTVSearchBloc extends MockBloc<TVSearchEvent, TVSearchState>
    implements TVSearchBloc {}

class TVSearchStateFake extends Fake implements TVSearchState {}

class TVSearchEventFake extends Fake implements TVSearchEvent {}
