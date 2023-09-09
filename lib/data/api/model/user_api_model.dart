class UserApiModel{
  final int? id;
  final String? email;
  final String? fullName;

  UserApiModel({
    required this.id,
    required this.email,
    required this.fullName,
  });

  static UserApiModel fromJson(Map<dynamic, dynamic> json) {
    return UserApiModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
    );
  }
}
