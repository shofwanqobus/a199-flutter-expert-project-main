import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatusTv])
void main() {
  late TVWatchlistStatusBloc tvWatchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    tvWatchlistStatusBloc =
        TVWatchlistStatusBloc(getTVWatchlistStatus: mockGetWatchListStatus);
  });

  final tId = 1;

  group(
    'Watchlist TV Status',
    () {
      test('initial state should be on page', () {
        expect(tvWatchlistStatusBloc.state, TVWatchlistStatusEmpty());
      });

      blocTest<TVWatchlistStatusBloc, TVWatchlistStatusState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvWatchlistStatusBloc;
        },
        act: (bloc) => bloc.add(FetchTVWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchTVWatchlistStatus(tId).props,
        expect: () => [TVStatusState(true)],
      );
    },
  );
}
