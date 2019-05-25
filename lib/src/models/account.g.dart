// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(json['account_name'] as String, json['head_block_num'] as int);
}

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{
    'account_name': instance.accountName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('head_block_num', instance.headBlockNum);
  return val;
}
