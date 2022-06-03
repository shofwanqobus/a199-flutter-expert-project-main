import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return entities genre when toEntity() function called', () {
    const genreModel = GenreModel(id: 1, name: 'Action');
    final genre = genreModel.toEntity();
    expect(genre, Genre(id: 1, name: 'Action'));
  });
}
