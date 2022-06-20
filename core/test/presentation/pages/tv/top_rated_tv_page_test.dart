import 'package:core/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

void main() {
  late final MockTopRatedTVBloc mockTopRatedTVBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTVEventFake());
    registerFallbackValue(TopRatedTVStateFake());

    mockTopRatedTVBloc = MockTopRatedTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVBloc>.value(
      value: mockTopRatedTVBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Top Rated TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is TopRatedTVLoading',
        (WidgetTester tester) async {
      when(() => mockTopRatedTVBloc.state).thenReturn(TopRatedTVLoading());
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTVsPage()));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display ListView when state is TopRatedTVData',
        (WidgetTester tester) async {
      when(() => mockTopRatedTVBloc.state)
          .thenReturn(TopRatedTVData(testTVList));
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTVsPage()));

      expect(list, findsOneWidget);
    });

    testWidgets("Should display Text('Failed') when state is TopRatedTVError",
        (WidgetTester tester) async {
      when(() => mockTopRatedTVBloc.state)
          .thenReturn(TopRatedTVError('Failed'));
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTVsPage()));

      expect(errorText, findsOneWidget);
    });
  });
}
