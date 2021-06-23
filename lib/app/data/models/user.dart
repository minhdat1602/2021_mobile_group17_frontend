import 'package:mobile_nhom17_2021/app/data/models/user_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String email;
  String password;
  List<String> role;
  String tokenType;
  String accessToken;
  UserInfo userInfo;
  User({this.id, this.email, this.password, this.userInfo, this.role});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
