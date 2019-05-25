import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account extends Object{
  @JsonKey(name: 'account_name')
  String accountName;

  @JsonKey(name: 'head_block_num', includeIfNull: false)
  int headBlockNum;

  Account(this.accountName, this.headBlockNum);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  String toString() => this.toJson().toString();
}