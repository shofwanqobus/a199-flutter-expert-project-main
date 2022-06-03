import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendation.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
])
void main() {
  late TVDetailBloc tvDetailBloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    tvDetailBloc = TVDetailBloc(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
    );
  });

  final tId = 1;

  group(
    'Get TV Detail',
    () {
      test('initial state should be on page', () {
        expect(tvDetailBloc.state, TVDetailEmpty());
      });

      blocTest<TVDetailBloc, TVDetailState>(
        ' should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockGetTVDetail.execute(tId))
              .thenAnswer((_) async => Right(testTVDetail));
          when(mockGetTVRecommendations.execute(tId))
              .thenAnswer((_) async => Right(testTVList));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTVDetail(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchTVDetail(tId).props,
        expect: () =>
            [TVDetailLoading(), TVDetailData(testTVDetail, testTVList)],
      );

      blocTest<TVDetailBloc, TVDetailState>(
        ' should emit [Loading, Error] when tv detail data is gotten unsuccessful',
        build: () {
          when(mockGetTVDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          when(mockGetTVRecommendations.execute(tId))
              .thenAnswer((_) async => Right(testTVList));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTVDetail(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchTVDetail(tId).props,
        expect: () => [
          TVDetailLoading(),
          TVDetailError('Failed'),
        ],
      );

      blocTest<TVDetailBloc, TVDetailState>(
        ' should emit [Loading, Error] when tv recommendation is gotten is unsuccessful',
        build: () {
          when(mockGetTVDetail.execute(tId))
              .thenAnswer((_) async => Right(testTVDetail));
          when(mockGetTVRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTVDetail(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchTVDetail(tId).props,
        expect: () => [TVDetailLoading(), TVDetailError('Failed')],
      );
    },
  );
}
