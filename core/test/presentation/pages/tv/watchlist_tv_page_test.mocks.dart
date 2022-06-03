import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';

class MockWatchlistTVBloc extends MockBloc<WatchlistTVEvent, WatchlistTVState>
    implements WatchlistTVBloc {}

class WatchlistTVStateFake extends Fake implements WatchlistTVState {}

class WatchlistTVEventFake extends Fake implements WatchlistTVEvent {}
