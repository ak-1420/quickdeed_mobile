

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  User? user =  FirebaseAuth.instance.currentUser;
  final token = await user?.getIdToken().then((val)=>val);

  print('fcm token: $token');

  final header = {
    "authorization": 'Bearer $token'
  };

  final response = await http.get(Uri.parse('$userBaseUrl/mobile/$mobile'),headers: header);
  if(response.statusCode == 200){
     return CurrentUser.fromJson(jsonDecode(response.body));
  }
  else if(response.statusCode == 401){
     print('user is unauthorized to access the api: ${response.body} ');
     throw Exception(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to fetch user by mobile number $mobile , error  $response');
  }
}


// method to create a new user
Future<CurrentUser> registerUser(CurrentUser newUser) async {
    if(newUser.mobile == 0){
      throw Exception("INVALID_MOBILE");
    }
    if(newUser.userId == ""){
      throw Exception("INVALID_USER_ID");
    }

    User? user =  FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken().then((val)=>val);

    //TODO: send the post request to register a new user
    final header = {
      "authorization": 'Bearer $token',
      "Content-Type": "application/json"
    };

    Map data = {
      'userId' : newUser.userId,
      'userName': newUser.userName,
      'mobile': newUser.mobile,
      'email': newUser.email,
      'skills': newUser.skills,
      'rating': newUser.rating,
      'connections': newUser.connections,
      'requests' : newUser.requests,
      'invitations': newUser.invitations,
      'location': newUser.location,
      'profilePic' : newUser.profilePic
    };

    // encode the Map to JSON
    var requestBody = json.encode(data);

    final response = await http.post(Uri.parse('$userBaseUrl/signup'),
      headers: header,
      body: requestBody
    );

    if(response.statusCode == 201){
      return CurrentUser.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode == 401){
      throw Exception(jsonDecode(response.body));
    }
    else if(response.statusCode == 400){
      throw Exception(jsonDecode(response.body));
    }
    else
      {
        throw Exception('Failed to register new user');
      }
}