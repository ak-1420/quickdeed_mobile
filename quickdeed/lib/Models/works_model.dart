import 'package:flutter/material.dart';

class Works {
  String workName = "";
  String estimatedTime = "";
  double amount = 0.0;
  String location = "";
  DateTime? createdTime = DateTime.now();
  String userName = "";
  String workType = "";
  Works(
      {this.userName = "",
      this.workName = "",
      this.workType = "",
      this.estimatedTime = "",
      this.amount = 0.0,
      this.location = "",
      this.createdTime});
}
