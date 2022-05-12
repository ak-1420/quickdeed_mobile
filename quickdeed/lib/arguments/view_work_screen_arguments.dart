
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/Models/work.dart';

class ViewWorkArguments {
  final CurrentUser? user;
  final Work? work;
  ViewWorkArguments({required this.user , required this.work});
}