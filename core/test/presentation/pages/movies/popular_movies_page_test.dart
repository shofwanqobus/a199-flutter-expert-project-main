import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/bloc/movies/popular_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

void main() {
  late final MockPopularMoviesBloc mockPopularMoviesBloc;

  setUpAll(() {
    registerFallbackValue(PopularMoviesEventFake());
    registerFallbackValue(PopularMoviesStateFake());

    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockPopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Popular Movie Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is PopularMoviesLoading',
        (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesLoading());
      final title = find.text('Popular Movies');
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(circular, findsOneWidget);
      expect(title, findsOneWidget);
    });

    testWidgets('Should display ListView when state is PopularMoviesData',
        (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesData(testMovieList));
      final title = find.text('Popular Movies');
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(title, findsOneWidget);
      expect(list, findsOneWidget);
    });

    testWidgets(
        "Should display Text('Failed') when state is PopularMoviesError",
        (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesError('Failed'));
      final title = find.text('Popular Movies');
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(title, findsOneWidget);
      expect(errorText, findsOneWidget);
    });
  });
}
