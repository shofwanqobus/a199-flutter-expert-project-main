import 'package:core/core.dart';
import 'package:core/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

void main() {
  late MockWatchlistTVStatusBloc mockWatchlistTVStatusBloc;
  late MockWatchlistTVModifyBloc mockWatchlistTVModifyBloc;
  late MockTVDetailBloc mockTVDetailBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistStatusStateFake());
    registerFallbackValue(WatchlistStatusEventFake());
    registerFallbackValue(WatchlistTVModifyStateFake());
    registerFallbackValue(WatchlistTVModifyEventFake());
    registerFallbackValue(TVDetailStateFake());
    registerFallbackValue(TVDetailEventFake());
  });

  setUp(() {
    mockWatchlistTVStatusBloc = MockWatchlistTVStatusBloc();
    mockWatchlistTVModifyBloc = MockWatchlistTVModifyBloc();
    mockTVDetailBloc = MockTVDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVWatchlistStatusBloc>.value(
      value: mockWatchlistTVStatusBloc,
      child: BlocProvider<WatchListTVModifyBloc>.value(
        value: mockWatchlistTVModifyBloc,
        child: BlocProvider<TVDetailBloc>.value(
          value: mockTVDetailBloc,
          child: MaterialApp(
            home: body,
            theme: ThemeData.dark().copyWith(
              primaryColor: kRichBlack,
              scaffoldBackgroundColor: kRichBlack,
              textTheme: kTextTheme,
              colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
            ),
          ),
        ),
      ),
    );
  }

  const id = 1;

  group('Detail TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is TVDetailLoading',
        (WidgetTester tester) async {
      when(() => mockTVDetailBloc.state).thenReturn(TVDetailLoading());
      when(() => mockWatchlistTVStatusBloc.state)
          .thenReturn(TVWatchlistStatusEmpty());
      when(() => mockWatchlistTVModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());

      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: id)));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display Text when state is TVDetailError',
        (WidgetTester tester) async {
      when(() => mockTVDetailBloc.state).thenReturn(TVDetailError('Failed'));
      when(() => mockWatchlistTVStatusBloc.state)
          .thenReturn(TVWatchlistStatusEmpty());
      when(() => mockWatchlistTVModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());

      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: id)));

      expect(errorText, findsOneWidget);
    });

    testWidgets(
        'Should display Icon Check when state is TVDetailData and TVStatusState(true)',
        (WidgetTester tester) async {
      when(() => mockTVDetailBloc.state)
          .thenReturn(TVDetailData(testTVDetail, testTVList));
      when(() => mockWatchlistTVStatusBloc.state)
          .thenReturn(TVStatusState(true));
      when(() => mockWatchlistTVModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());
      final iconCheck = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: id)));

      expect(iconCheck, findsOneWidget);
    });

    testWidgets(
        'Should display Icon Add when state is TVDetailData and TVStatusState(false)',
        (WidgetTester tester) async {
      when(() => mockTVDetailBloc.state)
          .thenReturn(TVDetailData(testTVDetail, testTVList));
      when(() => mockWatchlistTVStatusBloc.state)
          .thenReturn(TVStatusState(false));
      when(() => mockWatchlistTVModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());
      final iconAdd = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: id)));

      expect(iconAdd, findsOneWidget);
    });
  });
}
