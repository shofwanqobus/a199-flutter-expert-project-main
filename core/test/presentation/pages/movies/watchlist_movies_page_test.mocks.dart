import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_bloc.dart';

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMoviesState {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMoviesEvent {}
