import 'package:kornia/features/auth/domain/entities/user_entity.dart';

class UserDto {
  final String name;
  final String email;
  final String lastName;
  final String? profilePhoto;
  final String? phone;
  final DateTime? birthDate;
  final String? uid;

  UserDto({
    required this.uid,
    required this.name,
    required this.email,
    required this.lastName,
    required this.profilePhoto,
    required this.phone,
    required this.birthDate,
  });

//convertir la entidad dominio a DTO
factory UserDto.fromEntity(UserEntity entity) {
  return UserDto(
    uid: entity.uid,
    name: entity.name,
    email: entity.email,
    lastName: entity.lastName,
    profilePhoto: entity.profilePhoto,
    phone: entity.phone,
    birthDate: entity.birthDate,
  );
}
  
//luego el dto a map/json
Map<String, dynamic> toMap() {
  return {
    'name': name,
    'email': email,
    'lastName': lastName,
    'profilePhoto': profilePhoto,
    'phone': phone,
    'birthDate': birthDate?.toIso8601String(),
  };
}

}