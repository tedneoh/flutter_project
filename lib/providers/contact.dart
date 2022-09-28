import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Contact with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
  });
}
