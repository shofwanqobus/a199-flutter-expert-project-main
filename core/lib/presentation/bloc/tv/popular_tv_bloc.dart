import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tvs.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTvs getPopularTV;

  PopularTVBloc({
    required this.getPopularTV,
  }) : super(PopularTVEmpty()) {
    on<FetchPopularTV>(_fetchPopularTV);
  }

  void _fetchPopularTV(
      FetchPopularTV fetchPopularTV, Emitter<PopularTVState> emitter) async {
    emitter(PopularTVLoading());
    final hasil = await getPopularTV.execute();
    hasil.fold(
      (failure) => emitter(PopularTVError(failure.message)),
      (data) => emitter(PopularTVData(data)),
    );
  }
}
