import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfo {
  int id;
  String firstName;
  String lastName;
  String phone;
  String sonha;
  String xa;
  String huyen;
  String tinh;
  UserInfo(
      {this.firstName,
      this.lastName,
      this.phone,
      this.sonha,
      this.xa,
      this.huyen,
      this.tinh,
      this.id});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
