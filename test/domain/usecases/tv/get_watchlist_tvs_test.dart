import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv/tv_test_helper.mocks.dart';

void main() {
  late GetWatchlistTvs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTvs(mockTVRepository);
  });

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlistTvs())
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVList));
  });
}
