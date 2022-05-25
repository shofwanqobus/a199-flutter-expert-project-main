import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TVSearchNotifier provider;
  late MockSearchTVs mockSearchTVs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTVs = MockSearchTVs();
    provider = TVSearchNotifier(searchTVs: mockSearchTVs)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVModel = TV(
    backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
    firstAirDate: '2011-04-17',
    genreIds: [
      10765,
      18,
      10759,
      9648,
    ],
    id: 1399,
    name: 'Game of Thrones',
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originalName: 'Game of Thrones',
    overview:
        'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night'
        's Watch, is all that stands between the realms of men and icy horrors beyond.',
    popularity: 369.594,
    posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
    type: 'Scripted',
    voteAverage: 8.3,
    voteCount: 11504,
  );
  final tTVList = <TV>[tTVModel];
  final tQuery = 'spiderman';

  group('search tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
