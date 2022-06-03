import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;

  TVDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
  }) : super((TVDetailEmpty())) {
    on<FetchTVDetail>(_fetchTVDetail);
  }

  void _fetchTVDetail(
      FetchTVDetail fetchTVDetail, Emitter<TVDetailState> emitter) async {
    emitter(TVDetailLoading());
    final detailResult = await getTVDetail.execute(fetchTVDetail.id);
    final recommendationResult =
        await getTVRecommendations.execute(fetchTVDetail.id);
    detailResult.fold((failure) => emitter(TVDetailError(failure.message)),
        (detTV) {
      emitter(TVDetailLoading());
      recommendationResult.fold(
        (failure) => emitter(TVDetailError(failure.message)),
        (recTV) => emitter(
          TVDetailData(detTV, recTV),
        ),
      );
    });
  }
}
