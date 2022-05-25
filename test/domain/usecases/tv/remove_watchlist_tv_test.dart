import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv/tv_test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlistTv(mockTVRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
