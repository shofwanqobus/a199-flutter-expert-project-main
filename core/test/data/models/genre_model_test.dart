import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/genre_model.dart';

void main() {
  group('Genre Model', () {
    test('Should return genre model when fromJson() function called', () {
      const genreMap = <String, dynamic>{
        'id': 1,
        'name': 'Action',
      };
      final genreModel = GenreModel.fromJson(genreMap);
      expect(genreModel, const GenreModel(id: 1, name: 'Action'));
    });

    test('Should return genre map when toJson() function called', () {
      const genreMap = <String, dynamic>{
        'id': 1,
        'name': 'Action',
      };
      final genreModel = const GenreModel(id: 1, name: 'Action').toJson();
      expect(genreModel, genreMap);
    });
  });
}
