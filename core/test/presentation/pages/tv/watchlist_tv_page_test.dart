import 'package:core/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_page_test.mocks.dart';

void main() {
  late final MockWatchlistTVBloc mockWatchlistTVBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistTVEventFake());
    registerFallbackValue(WatchlistTVStateFake());

    mockWatchlistTVBloc = MockWatchlistTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockWatchlistTVBloc>.value(
      value: mockWatchlistTVBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Popular TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is WatchlistTVLoading',
        (WidgetTester tester) async {
      when(() => mockWatchlistTVBloc.state).thenReturn(WatchlistTVLoading());
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTVsPage()));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display ListView when state is WatchlistTVData',
        (WidgetTester tester) async {
      when(() => mockWatchlistTVBloc.state)
          .thenReturn(WatchlistTVData(testTVList));
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTVsPage()));

      expect(list, findsOneWidget);
    });

    testWidgets("Should display Text('Failed') when state is WatchlistTVError",
        (WidgetTester tester) async {
      when(() => mockWatchlistTVBloc.state)
          .thenReturn(WatchlistTVError('Failed'));
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTVsPage()));
      expect(errorText, findsOneWidget);
    });

    testWidgets(
        "Should display Text('You Don't Have Watchlist TV') when state is WatchlistTVEmpty",
        (WidgetTester tester) async {
      when(() => mockWatchlistTVBloc.state).thenReturn(WatchlistTVEmpty());
      final empty = find.text("You Don't Have Watchlist TV");

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTVsPage()));
      expect(empty, findsOneWidget);
    });
  });
}
