import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';

@GenerateMocks([
  MovieRepository,
  TVRepository,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
