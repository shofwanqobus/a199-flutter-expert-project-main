import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/bloc/movies/top_rated_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

void main() {
  late final MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMoviesEventFake());
    registerFallbackValue(TopRatedMoviesStateFake());

    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockTopRatedMoviesBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Top Rated Movie Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is TopRatedMoviesLoading',
        (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesLoading());
      final title = find.text('Top Rated Movies');
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(circular, findsOneWidget);
      expect(title, findsOneWidget);
    });

    testWidgets('Should display ListView when state is TopRatedMoviesData',
        (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesData(testMovieList));
      final title = find.text('Top Rated Movies');
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(title, findsOneWidget);
      expect(list, findsOneWidget);
    });

    testWidgets(
        "Should display Text('Failed') when state is TopRatedMoviesError",
        (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesError('Failed'));
      final title = find.text('Top Rated Movies');
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(title, findsOneWidget);
      expect(errorText, findsOneWidget);
    });
  });
}
