import 'package:core/domain/usecases/movies/get_watchlist_status.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late WatchListStatusBloc watchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    watchlistStatusBloc =
        WatchListStatusBloc(getWatchListStatus: mockGetWatchListStatus);
  });

  final tId = 1;

  group(
    'Watchlist Movies Status',
    () {
      test('initial state should be on page', () {
        expect(watchlistStatusBloc.state, WatchListStatusEmpty());
      });

      blocTest<WatchListStatusBloc, WatchListStatusState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistStatusBloc;
        },
        act: (bloc) => bloc.add(FetchWatchListStatus(tId)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => FetchWatchListStatus(tId).props,
        expect: () => [MovieStatusState(true)],
      );
    },
  );
}
