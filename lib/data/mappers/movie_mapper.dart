import 'package:test_app_2024/data/mappers/mappers.dart';
import 'package:test_app_2024/data/models/models.dart';
import 'package:test_app_2024/domain/entities/entities.dart';

class MovieMapper {
  static Movie toEntity(MovieModel model) {
    return Movie(
      id: model.id,
      title: model.title,
      overview: model.overview,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      voteAverage: model.voteAverage,
      genres: model.genres
          ?.map(
            (genre) => GenreMapper.toEntity(genre),
          )
          .toList(),
    );
  }
}
