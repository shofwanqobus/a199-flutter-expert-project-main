import 'package:core/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

void main() {
  late final MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistMoviesStateFake());

    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockWatchlistMoviesBloc>.value(
      value: mockWatchlistMoviesBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Popular Movie Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is WatchlistMoviesLoading',
        (WidgetTester tester) async {
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(WatchlistMoviesLoading());
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display ListView when state is WatchlistMoviesData',
        (WidgetTester tester) async {
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(WatchlistMoviesData(testMovieList));
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(list, findsOneWidget);
    });

    testWidgets(
        "Should display Text('Failed') when state is WatchlistMoviesError",
        (WidgetTester tester) async {
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(WatchlistMoviesError('Failed'));
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
      expect(errorText, findsOneWidget);
    });

    testWidgets(
        "Should display Text('You Don't Have Watchlist Movies') when state is WatchlistMovieEmpty",
        (WidgetTester tester) async {
      when(() => mockWatchlistMoviesBloc.state)
          .thenReturn(WatchlistMoviesEmpty());
      final empty = find.text("You Don't Have Watchlist Movies");

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
      expect(empty, findsOneWidget);
    });
  });
}
