import 'data.dart';
import 'support.dart';

class User {
  Data? data;
  Support? support;

  User({this.data, this.support});

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        support: json['support'] == null
            ? null
            : Support.fromJson(json['support'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'support': support?.toJson(),
      };
}
