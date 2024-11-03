class CastMemberModel {
  final int id;
  final String name;
  final String profilePath;

  CastMemberModel({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) {
    return CastMemberModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
    );
  }
}
