import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late NowPlayingTVBloc nowPlayingTVBloc;
  late MockGetNowPlayingTVs mockGetNowPlayingTV;

  setUp(() {
    mockGetNowPlayingTV = MockGetNowPlayingTVs();
    nowPlayingTVBloc = NowPlayingTVBloc(getNowPlayingTV: mockGetNowPlayingTV);
  });

  group(
    'Now Playing TV',
    () {
      test('initial state should be on page', () {
        expect(nowPlayingTVBloc.state, NowPlayingTVEmpty());
      });

      blocTest<NowPlayingTVBloc, NowPlayingTVState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingTV.execute())
              .thenAnswer((_) async => Right(testTVList));
          return nowPlayingTVBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchNowPlayingTV().props,
        expect: () => [NowPlayingTVLoading(), NowPlayingTVData(testTVList)],
      );

      blocTest<NowPlayingTVBloc, NowPlayingTVState>(
        'should emit [Loading, Error] when data is gotten is unsuccessful',
        build: () {
          when(mockGetNowPlayingTV.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return nowPlayingTVBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchNowPlayingTV().props,
        expect: () => [NowPlayingTVLoading(), NowPlayingTVError('Failed')],
      );
    },
  );
}
