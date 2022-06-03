import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';

class MockPopularTVBloc extends MockBloc<PopularTVEvent, PopularTVState>
    implements PopularTVBloc {}

class PopularTVEventFake extends Fake implements PopularTVEvent {}

class PopularTVStateFake extends Fake implements PopularTVState {}
