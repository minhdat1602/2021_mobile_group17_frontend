import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfoModel {
  int id;
  String firstName;
  String lastName;
  String phone;
  String sonha;
  String xa;
  String huyen;
  String tinh;
  UserInfoModel(
      {this.firstName,
      this.lastName,
      this.phone,
      this.sonha,
      this.xa,
      this.huyen,
      this.tinh,
      this.id});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
