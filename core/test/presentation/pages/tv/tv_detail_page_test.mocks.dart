import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';

class MockTVDetailBloc extends MockBloc<TVDetailEvent, TVDetailState>
    implements TVDetailBloc {}

class TVDetailStateFake extends Fake implements TVDetailState {}

class TVDetailEventFake extends Fake implements TVDetailEvent {}

class MockWatchlistTVModifyBloc
    extends MockBloc<WatchListTVModifyEvent, WatchListTVModifyState>
    implements WatchListTVModifyBloc {}

class WatchlistTVModifyStateFake extends Fake
    implements WatchListTVModifyState {}

class WatchlistTVModifyEventFake extends Fake
    implements WatchListTVModifyEvent {}

class MockWatchlistTVStatusBloc
    extends MockBloc<TVWatchlistStatusEvent, TVWatchlistStatusState>
    implements TVWatchlistStatusBloc {}

class WatchlistStatusStateFake extends Fake implements TVWatchlistStatusState {}

class WatchlistStatusEventFake extends Fake implements TVWatchlistStatusEvent {}
