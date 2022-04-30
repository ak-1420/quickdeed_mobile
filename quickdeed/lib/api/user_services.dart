

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickdeed/Models/current_user.dart';


const userBaseUrl = "https://user-service-xi.vercel.app/api/v1/users";

Future<CurrentUser> getUserByMobile(String? mobileNumber) async {
  String mobile = (mobileNumber == null) ? "" : mobileNumber.toString();
  if(mobile == ""){
    throw Exception('user mobile number is empty : $mobile');
  }
  // removing +91 i.e country code from mobile number
  mobile = mobile.substring(3);

  final response = await http.get(Uri.parse('$userBaseUrl/mobile/$mobile'));
  if(response.statusCode == 200){
    //TODO: START HERE AFTER GYM (authentication is working fine but you stuck at parsing the repsonse body
     print('from getUserByMobile ${response.body}');
    return CurrentUser.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to fetch user by mobile number $mobile , error  $response');
  }
}

