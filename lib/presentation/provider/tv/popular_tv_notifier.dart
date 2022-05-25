import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:flutter/foundation.dart';

class PopularTVsNotifier extends ChangeNotifier {
  final GetPopularTvs getPopularTVs;

  PopularTVsNotifier(this.getPopularTVs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tv = [];
  List<TV> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVs.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _tv = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
