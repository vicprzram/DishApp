import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Usuario{
  String email;
  String username;
  String password;

  Usuario(this.email, this.username, this.password);
}

class Recipe {
  String? user;
  File image;
  String title;
  String description;
  String time;
  String timer;
  String diners;
  List<String> ingredients;
  List<String> steps;

  Recipe(this.user, this.image, this.title, this.description, this.time, this.timer, this.diners, this.ingredients, this.steps);
}

class TheException implements Exception {
  String cause;
  TheException(this.cause);
}