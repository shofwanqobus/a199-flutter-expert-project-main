import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchListTV(TVTable tv);
  Future<String> removeWatchListTV(TVTable tv);
  Future<TVTable?> getTvById(int id);
  Future<List<TVTable>> getWatchlistTv();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TVTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TVTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TVTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchListTV(TVTable tv) async {
    try {
      await databaseHelper.insertWatchlistTV(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchListTV(TVTable tv) async {
    try {
      await databaseHelper.removeWatchlistTV(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
