class UserEntity {
  final String name;
  final String email;
  final String lastName;
  final String? profilePhoto;
  final String? phone;
  final DateTime? birthDate;
  final String? uid;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.lastName,
    required this.profilePhoto,
    required this.phone,
    required this.birthDate,
  });
}