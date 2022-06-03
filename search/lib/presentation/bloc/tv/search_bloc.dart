import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:core/domain/entities/tv/tv.dart';

import '../../../domain/search_domain.dart';

part 'search_event.dart';
part 'search_state.dart';

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTV tv;

  TVSearchBloc({required this.tv}) : super(TVSearchEmpty()) {
    on<OnTVQueryChanged>((event, emit) async {
      final dataQuery = event.query;

      emit(TVSearchLoading());
      final dataResult = await tv.execute(dataQuery);

      dataResult.fold((failure) {
        emit(TVSearchError(failure.message));
      }, (data) {
        emit(SearchTVData(data));
      });
    }, transformer: _debounceTV(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnTVQueryChanged> _debounceTV<OnTVQueryChanged>(
      Duration dur) {
    return (events, mapper) => events.debounceTime(dur).switchMap(mapper);
  }
}
