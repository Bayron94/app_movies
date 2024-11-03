import 'package:test_app_2024/data/models/models.dart';
import 'package:test_app_2024/domain/entities/entities.dart';

class GenreMapper {
  static Genre toEntity(GenreModel model) {
    return Genre(
      id: model.id,
      name: model.name,
    );
  }
}
