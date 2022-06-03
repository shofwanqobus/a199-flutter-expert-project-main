import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/movies/remove_watchlist.dart';
import 'package:core/domain/usecases/movies/save_watchlist.dart';
import 'package:core/presentation/bloc/movies/watchlist_movie_modify_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_modify_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchListMoviesModifyBloc watchListMoviesModifyBloc;
  late MockSaveWatchlistMovies mockSaveWatchlistMovies;
  late MockRemoveWatchlistMovies mockRemoveWatchlistMovies;

  setUp(() {
    mockSaveWatchlistMovies = MockSaveWatchlistMovies();
    mockRemoveWatchlistMovies = MockRemoveWatchlistMovies();
    watchListMoviesModifyBloc = WatchListMoviesModifyBloc(
      saveWatchlist: mockSaveWatchlistMovies,
      removeWatchlist: mockRemoveWatchlistMovies,
    );
  });

  const saveMessage = 'Added to Watchlist';
  const removeMessage = 'Removed from Watchlist';
  const failedMessage = 'Failed';

  group(
    'Modify Watchlist Movies',
    () {
      test('initial state should be on page', () {
        expect(watchListMoviesModifyBloc.state, WatchListMoviesModifyEmpty());
      });

      blocTest<WatchListMoviesModifyBloc, WatchListMoviesModifyState>(
        'should emit [Loading, Data] when save movie is gotten successfully',
        build: () {
          when(mockSaveWatchlistMovies.execute(testMovieDetail))
              .thenAnswer((_) async => Right(saveMessage));
          return watchListMoviesModifyBloc;
        },
        act: (bloc) => bloc.add(AddMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddMovie(testMovieDetail).props,
        expect: () => [WatchListMoviesModifyLoading(), MovieAdd(saveMessage)],
      );

      blocTest<WatchListMoviesModifyBloc, WatchListMoviesModifyState>(
        'should emit [Loading, Data] when save movie is gotten unsuccessfully',
        build: () {
          when(mockSaveWatchlistMovies.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failedMessage)));
          return watchListMoviesModifyBloc;
        },
        act: (bloc) => bloc.add(AddMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddMovie(testMovieDetail).props,
        expect: () => [
          WatchListMoviesModifyLoading(),
          WatchListMoviesModifyError(failedMessage)
        ],
      );

      blocTest<WatchListMoviesModifyBloc, WatchListMoviesModifyState>(
        'should emit [Loading, Data] when remove movie is gotten successfully',
        build: () {
          when(mockRemoveWatchlistMovies.execute(testMovieDetail))
              .thenAnswer((_) async => Right(removeMessage));
          return watchListMoviesModifyBloc;
        },
        act: (bloc) => bloc.add(RemoveMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveMovie(testMovieDetail).props,
        expect: () =>
            [WatchListMoviesModifyLoading(), MovieRemove(removeMessage)],
      );

      blocTest<WatchListMoviesModifyBloc, WatchListMoviesModifyState>(
        'should emit [Loading, Data] when remove movie is gotten unsuccessfully',
        build: () {
          when(mockRemoveWatchlistMovies.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failedMessage)));
          return watchListMoviesModifyBloc;
        },
        act: (bloc) => bloc.add(RemoveMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveMovie(testMovieDetail).props,
        expect: () => [
          WatchListMoviesModifyLoading(),
          WatchListMoviesModifyError(failedMessage)
        ],
      );
    },
  );
}
