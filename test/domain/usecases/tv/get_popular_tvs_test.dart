import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv/tv_test_helper.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTVRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTVRepository();
    usecase = GetPopularTvs(mockTVRpository);
  });

  final tTVs = <TV>[];

  group('GetPopularTVs Tests', () {
    group('execute', () {
      test(
          'should get list of tvs from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRpository.getPopularTvs())
            .thenAnswer((_) async => Right(tTVs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTVs));
      });
    });
  });
}
