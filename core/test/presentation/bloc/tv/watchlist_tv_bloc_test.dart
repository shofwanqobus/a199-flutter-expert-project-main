import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTVBloc watchlistTVBloc;
  late MockGetWatchlistTV mockGetWatchlistTV;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    watchlistTVBloc = WatchlistTVBloc(getWatchlistTV: mockGetWatchlistTV);
  });

  group(
    'Watchlist TV',
    () {
      test('initial state should be on page', () {
        expect(watchlistTVBloc.state, WatchlistTVEmpty());
      });

      blocTest<WatchlistTVBloc, WatchlistTVState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTV.execute())
              .thenAnswer((_) async => Right(testTVList));
          return watchlistTVBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchWatchlistTV().props,
        expect: () => [WatchlistTVLoading(), WatchlistTVData(testTVList)],
      );

      blocTest<WatchlistTVBloc, WatchlistTVState>(
        'should emit [Loading, Error] when data is gotten is unsuccessful',
        build: () {
          when(mockGetWatchlistTV.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return watchlistTVBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTV()),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchWatchlistTV().props,
        expect: () => [WatchlistTVLoading(), WatchlistTVError('Failed')],
      );
    },
  );
}
