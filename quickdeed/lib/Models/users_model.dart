import 'package:flutter/material.dart';

class Users {
  String userId = "";
  String userName = "";
  String email = "";
  int mobile = 1;
  double rating = 0.0;
  String location = "";


  Users(
      {this.userId = "",
      this.userName = "",
      this.email = "",
      this.rating = 0.0,
      this.location = "",
      this.mobile = 969}
    );
}
