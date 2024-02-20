import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';

class Ingredients {
  final String userId;
  final List<String> ingredients;

  Ingredients({required this.userId, required this.ingredients});
}
