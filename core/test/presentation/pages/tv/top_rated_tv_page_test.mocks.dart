import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';

class MockTopRatedTVBloc extends MockBloc<TopRatedTVEvent, TopRatedTVState>
    implements TopRatedTVBloc {}

class TopRatedTVStateFake extends Fake implements TopRatedTVState {}

class TopRatedTVEventFake extends Fake implements TopRatedTVEvent {}
