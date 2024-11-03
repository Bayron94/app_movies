import 'package:test_app_2024/data/models/models.dart';
import 'package:test_app_2024/domain/entities/entities.dart';

class CastMemberMapper {
  static CastMember toEntity(CastMemberModel model) {
    return CastMember(
      id: model.id,
      name: model.name,
      profilePath: model.profilePath,
    );
  }
}
