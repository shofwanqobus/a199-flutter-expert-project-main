import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_popular_tvs.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTVBloc popularTVsBloc;
  late MockGetPopularTV mockPopularTVs;

  setUp(() {
    mockPopularTVs = MockGetPopularTV();
    popularTVsBloc = PopularTVBloc(getPopularTV: mockPopularTVs);
  });

  group(
    'Popular TVs',
    () {
      test('initial state should be on page', () {
        expect(popularTVsBloc.state, PopularTVEmpty());
      });

      blocTest<PopularTVBloc, PopularTVState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockPopularTVs.execute())
              .thenAnswer((_) async => Right(testTVList));
          return popularTVsBloc;
        },
        act: (bloc) => bloc.add(FetchPopularTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchPopularTV().props,
        expect: () => [PopularTVLoading(), PopularTVData(testTVList)],
      );

      blocTest<PopularTVBloc, PopularTVState>(
        'should emit [Loading, Error] when data is gotten is unsuccessful',
        build: () {
          when(mockPopularTVs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return popularTVsBloc;
        },
        act: (bloc) => bloc.add(FetchPopularTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchPopularTV().props,
        expect: () => [PopularTVLoading(), PopularTVError('Failed')],
      );
    },
  );
}
