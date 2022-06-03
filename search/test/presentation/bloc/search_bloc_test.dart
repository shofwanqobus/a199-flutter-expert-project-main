import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:search/domain/search_domain.dart';
import 'package:search/presentation/bloc/movies/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTV])
void main() {
  late MoviesSearchBloc moviesSearchBloc;
  late TVSearchBloc tvSearchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTV = MockSearchTV();
    moviesSearchBloc = MoviesSearchBloc(movies: mockSearchMovies);
    tvSearchBloc = TVSearchBloc(tv: mockSearchTV);
  });

  final tMovieModel = Movie(
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
  final tMovieList = <Movie>[tMovieModel];
  const tQueryMovie = 'spiderman';

  final tTVModel = TV(
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
  final tTVList = <TV>[tTVModel];
  const tQueryTV = 'Game of Thrones';

  group('search movies', () {
    test('initial state should be empty', () {
      expect(moviesSearchBloc.state, MoviesSearchEmpty());
    });
    blocTest<MoviesSearchBloc, MoviesSearchState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(tQueryMovie))
              .thenAnswer((_) async => Right(tMovieList));
          return moviesSearchBloc;
        },
        act: (bloc) => bloc.add(OnMoviesQueryChanged(tQueryMovie)),
        wait: const Duration(milliseconds: 500),
        expect: () => [MoviesSearchLoading(), SearchMoviesData(tMovieList)],
        verify: (bloc) => verify(mockSearchMovies.execute(tQueryMovie)));

    blocTest<MoviesSearchBloc, MoviesSearchState>(
        'should emit [Loading, Error] when data search is unsuccessful',
        build: () {
          when(mockSearchMovies.execute(tQueryMovie))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return moviesSearchBloc;
        },
        act: (bloc) => bloc.add(OnMoviesQueryChanged(tQueryMovie)),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [MoviesSearchLoading(), MoviesSearchError('Server Failure')],
        verify: (bloc) => verify(mockSearchMovies.execute(tQueryMovie)));
  });

  group('search tv', () {
    test('initial state should be empty', () {
      expect(tvSearchBloc.state, TVSearchEmpty());
    });
    blocTest<TVSearchBloc, TVSearchState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockSearchTV.execute(tQueryTV))
              .thenAnswer((_) async => Right(tTVList));
          return tvSearchBloc;
        },
        act: (bloc) => bloc.add(OnTVQueryChanged(tQueryTV)),
        wait: const Duration(milliseconds: 500),
        expect: () => [TVSearchLoading(), SearchTVData(tTVList)],
        verify: (bloc) => verify(mockSearchTV.execute(tQueryTV)));

    blocTest<TVSearchBloc, TVSearchState>(
        'should emit [Loading, Error] when data search is unsuccessful',
        build: () {
          when(mockSearchTV.execute(tQueryTV))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvSearchBloc;
        },
        act: (bloc) => bloc.add(OnTVQueryChanged(tQueryTV)),
        wait: const Duration(milliseconds: 500),
        expect: () => [TVSearchLoading(), TVSearchError('Server Failure')],
        verify: (bloc) => verify(mockSearchTV.execute(tQueryTV)));
  });
}
