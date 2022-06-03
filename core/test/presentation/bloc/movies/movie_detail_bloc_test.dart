import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movies/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  final tId = 1;

  group(
    'Get Movie Detail',
    () {
      test('initial state should be on page', () {
        expect(movieDetailBloc.state, MovieDetailEmpty());
      });

      blocTest<MovieDetailBloc, MovieDetailState>(
        ' should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(testMovieList));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchMovieDetail(tId).props,
        expect: () => [
          MovieDetailLoading(),
          MovieDetailData(testMovieDetail, testMovieList)
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        ' should emit [Loading, Error] when movie detail data is gotten unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(testMovieList));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchMovieDetail(tId).props,
        expect: () => [
          MovieDetailLoading(),
          MovieDetailError('Failed'),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        ' should emit [Loading, Error] when movie recommendation is gotten is unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchMovieDetail(tId).props,
        expect: () => [MovieDetailLoading(), MovieDetailError('Failed')],
      );
    },
  );
}
