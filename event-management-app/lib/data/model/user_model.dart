import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

class UserLogin {
  String? email;
  String? password;

  UserLogin({this.email, this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? token;

  const UserModel({
    this.name,
    this.email,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['data']['user']['name'], // Adjust field names if needed
      email: json['data']['user']['email'], // Adjust field names if needed
      token: json['data']['user']['token'], // Adjust field names if needed
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        token
      ];
}
