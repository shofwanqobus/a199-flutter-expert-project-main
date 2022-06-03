import 'package:core/presentation/pages/tv/popular_tvs_page.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

void main() {
  late final MockPopularTVBloc mockPopularTVBloc;

  setUpAll(() {
    registerFallbackValue(PopularTVEventFake());
    registerFallbackValue(PopularTVStateFake());

    mockPopularTVBloc = MockPopularTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockPopularTVBloc>.value(
      value: mockPopularTVBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Popular TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is PopularTVLoading',
        (WidgetTester tester) async {
      when(() => mockPopularTVBloc.state).thenReturn(PopularTVLoading());
      final title = find.text('Popular TV');
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const PopularTVsPage()));

      expect(circular, findsOneWidget);
      expect(title, findsOneWidget);
    });

    testWidgets('Should display ListView when state is PopularTVData',
        (WidgetTester tester) async {
      when(() => mockPopularTVBloc.state).thenReturn(PopularTVData(testTVList));
      final title = find.text('Popular TV');
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularTVsPage()));

      expect(title, findsOneWidget);
      expect(list, findsOneWidget);
    });

    testWidgets("Should display Text('Failed') when state is PopularTVError",
        (WidgetTester tester) async {
      when(() => mockPopularTVBloc.state).thenReturn(PopularTVError('Failed'));
      final title = find.text('Popular TV');
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const PopularTVsPage()));

      expect(title, findsOneWidget);
      expect(errorText, findsOneWidget);
    });
  });
}
