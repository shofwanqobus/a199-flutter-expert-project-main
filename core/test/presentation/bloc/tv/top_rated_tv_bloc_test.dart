import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTVBloc topRatedTVBloc;
  late MockGetTopRatedTV mockTopRatedTV;

  setUp(() {
    mockTopRatedTV = MockGetTopRatedTV();
    topRatedTVBloc = TopRatedTVBloc(getTopRatedTV: mockTopRatedTV);
  });

  group(
    'Top Rated TV',
    () {
      test('initial state should be on page', () {
        expect(topRatedTVBloc.state, TopRatedTVEmpty());
      });

      blocTest<TopRatedTVBloc, TopRatedTVState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockTopRatedTV.execute())
              .thenAnswer((_) async => Right(testTVList));
          return topRatedTVBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchTopRatedTV().props,
        expect: () => [TopRatedTVLoading(), TopRatedTVData(testTVList)],
      );

      blocTest<TopRatedTVBloc, TopRatedTVState>(
        'should emit [Loading, Error] when data is gotten is unsuccessful',
        build: () {
          when(mockTopRatedTV.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return topRatedTVBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchTopRatedTV().props,
        expect: () => [TopRatedTVLoading(), TopRatedTVError('Failed')],
      );
    },
  );
}
