import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tvs.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTVBloc extends Bloc<NowPlayingTVEvent, NowPlayingTVState> {
  final GetNowPlayingTvs getNowPlayingTV;

  NowPlayingTVBloc({
    required this.getNowPlayingTV,
  }) : super(NowPlayingTVEmpty()) {
    on<FetchNowPlayingTV>(_fetchNowPlayingTV);
  }

  void _fetchNowPlayingTV(FetchNowPlayingTV fetchNowPlayingTV,
      Emitter<NowPlayingTVState> emitter) async {
    emitter(NowPlayingTVLoading());
    final detailResult = await getNowPlayingTV.execute();
    detailResult.fold(
      (failure) => emitter(NowPlayingTVError(failure.message)),
      (data) => emitter(NowPlayingTVData(data)),
    );
  }
}
