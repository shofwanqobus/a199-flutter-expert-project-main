import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tvs.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_modify_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTV, RemoveWatchlistTv])
void main() {
  late WatchListTVModifyBloc watchListTVModifyBloc;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;

  setUp(() {
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    watchListTVModifyBloc = WatchListTVModifyBloc(
      saveWatchlist: mockSaveWatchlistTV,
      removeWatchlist: mockRemoveWatchlistTV,
    );
  });

  const saveMessage = 'Added to Watchlist';
  const removeMessage = 'Removed from Watchlist';
  const failedMessage = 'Failed';

  group(
    'Modify Watchlist TV',
    () {
      test('initial state should be on page', () {
        expect(watchListTVModifyBloc.state, WatchListTVModifyEmpty());
      });

      blocTest<WatchListTVModifyBloc, WatchListTVModifyState>(
        'should emit [Loading, Data] when save tv is gotten successfully',
        build: () {
          when(mockSaveWatchlistTV.execute(testTVDetail))
              .thenAnswer((_) async => Right(saveMessage));
          return watchListTVModifyBloc;
        },
        act: (bloc) => bloc.add(AddTV(testTVDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddTV(testTVDetail).props,
        expect: () => [WatchListTVModifyLoading(), TVAdd(saveMessage)],
      );

      blocTest<WatchListTVModifyBloc, WatchListTVModifyState>(
        'should emit [Loading, Data] when save tv is gotten unsuccessfully',
        build: () {
          when(mockSaveWatchlistTV.execute(testTVDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failedMessage)));
          return watchListTVModifyBloc;
        },
        act: (bloc) => bloc.add(AddTV(testTVDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddTV(testTVDetail).props,
        expect: () =>
            [WatchListTVModifyLoading(), WatchListTVModifyError(failedMessage)],
      );

      blocTest<WatchListTVModifyBloc, WatchListTVModifyState>(
        'should emit [Loading, Data] when remove tv is gotten successfully',
        build: () {
          when(mockRemoveWatchlistTV.execute(testTVDetail))
              .thenAnswer((_) async => Right(removeMessage));
          return watchListTVModifyBloc;
        },
        act: (bloc) => bloc.add(RemoveTV(testTVDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveTV(testTVDetail).props,
        expect: () => [WatchListTVModifyLoading(), TVRemove(removeMessage)],
      );

      blocTest<WatchListTVModifyBloc, WatchListTVModifyState>(
        'should emit [Loading, Data] when remove tv is gotten unsuccessfully',
        build: () {
          when(mockRemoveWatchlistTV.execute(testTVDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failedMessage)));
          return watchListTVModifyBloc;
        },
        act: (bloc) => bloc.add(RemoveTV(testTVDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveTV(testTVDetail).props,
        expect: () =>
            [WatchListTVModifyLoading(), WatchListTVModifyError(failedMessage)],
      );
    },
  );
}
