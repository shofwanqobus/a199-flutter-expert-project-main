import 'package:core/domain/entities/movies/movie.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/movies/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';

import 'search_page_test_mocks.dart';

void main() {
  late final MockMoviesSearchBloc mockMoviesSearchBloc;
  late final MockTVSearchBloc mockTVSearchBloc;

  setUpAll(() {
    registerFallbackValue(MoviesSearchStateFake());
    registerFallbackValue(MoviesSearchEventFake());
    registerFallbackValue(TVSearchStateFake());
    registerFallbackValue(TVSearchEventFake());
  });

  setUp(() {
    mockMoviesSearchBloc = MockMoviesSearchBloc();
    mockTVSearchBloc = MockTVSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviesSearchBloc>.value(
      value: mockMoviesSearchBloc,
      child: BlocProvider<TVSearchBloc>.value(
        value: mockTVSearchBloc,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

  final testTV = TV(
    backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
    firstAirDate: '2011-04-17',
    genreIds: const [
      10765,
      18,
      10759,
      9648,
    ],
    id: 1399,
    name: 'Game of Thrones',
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originalName: 'Game of Thrones',
    overview:
        'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night'
        's Watch, is all that stands between the realms of men and icy horrors beyond.',
    popularity: 369.594,
    posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
    type: 'Scripted',
    voteAverage: 8.3,
    voteCount: 11504,
  );

  final testTVList = [testTV];

  group('search page', () {
    testWidgets(
        'should display CircularProgressIndicator when states is MoviesSearchLoading and TVSearchLoading',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state).thenReturn(MoviesSearchLoading());
      when(() => mockTVSearchBloc.state).thenReturn(TVSearchLoading());

      final circular = find.byType(CircularProgressIndicator);
      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      final textField = find.byKey(const Key('search-textfield'));
      final queryText = find.text('superman');

      await test.enterText(textField, 'superman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(circular, findsOneWidget);
      expect(queryText, findsOneWidget);
    });

    testWidgets('should display ListView when result is not empty',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state)
          .thenReturn(SearchMoviesData(testMovieList));
      when(() => mockTVSearchBloc.state).thenReturn(SearchTVData(testTVList));

      final listView = find.byType(ListView);
      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(listView, findsOneWidget);
    });

    testWidgets(
        'should display Cannot Found Movies and TV when result is empty',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state)
          .thenReturn(SearchMoviesData(const []));
      when(() => mockTVSearchBloc.state).thenReturn(SearchTVData(const []));

      final errorText = find.text('Cannot Found Movies and TV');
      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      final textField = find.byKey(const Key('search-textfield'));
      final queryText = find.text('superman');

      await test.enterText(textField, 'superman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(errorText, findsOneWidget);
      expect(queryText, findsOneWidget);
    });

    testWidgets(
        'should not display anything when states is MoviesSearchError and TVSearchError',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state).thenReturn(MoviesSearchError(''));
      when(() => mockTVSearchBloc.state).thenReturn(TVSearchError(''));

      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      final errorText = find.byKey(const Key('search-error'));
      final textField = find.byKey(const Key('search-textfield'));
      final queryText = find.text('superman');

      await test.enterText(textField, 'superman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(errorText, findsOneWidget);
      expect(queryText, findsOneWidget);
    });
  });
}
