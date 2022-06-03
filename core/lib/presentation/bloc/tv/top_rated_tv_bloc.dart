import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tvs.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTvs getTopRatedTV;

  TopRatedTVBloc({
    required this.getTopRatedTV,
  }) : super(TopRatedTVEmpty()) {
    on<FetchTopRatedTV>(_fetchTopRatedTV);
  }

  void _fetchTopRatedTV(
      FetchTopRatedTV fetchTopRatedTV, Emitter<TopRatedTVState> emitter) async {
    emitter(TopRatedTVLoading());
    final hasil = await getTopRatedTV.execute();
    hasil.fold(
      (failure) => emitter(TopRatedTVError(failure.message)),
      (data) => emitter(TopRatedTVData(data)),
    );
  }
}
