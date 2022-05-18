import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/Models/message_model.dart';

const userBaseUrl = "https://user-service-xi.vercel.app/api/v1/users";
//const userBaseUrl = "http://192.168.232.118:3400/api/v1/users";

// method to fetch user messeges
Future<List<Message>> fetchMessages(String senderId , String receiverId) async {
  User? user = FirebaseAuth.instance.currentUser;
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization" : 'Bearer $token'
  };
  final res = await http.get(Uri.parse('$userBaseUrl/message?senderId=$senderId&receiverId=$receiverId'),
  headers: header
  );

  if(res.statusCode == 200){
    var parsed = jsonDecode(res.body);
    List<dynamic> data = parsed['data'];
    bool status = parsed['status'];
    String msg = parsed['message'];
    List<Message> list = [];
    if(status == true && data.isNotEmpty){
      List<Map<String , dynamic>> jsons = data.map((d) => {'data' : d}).toList();
      list = jsons.map((d) => Message.fromJson(d)).toList();
    }
    return list;
  }
  else if(res.statusCode == 401){
    print('user is unauthorized to access the api: ${res.body}');
    throw Exception('forbidden');
  }
  else{
    throw Exception('internal server error');
  }

}

// method  to signout the user
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}



// method to store user device fcm token
Future<void> storeFcmToken(String? uid , String? jwtToken) async {
    if(uid == null || jwtToken == null) return;

    //get fcm token
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if(fcmToken == null) return;

    // store this fcmToken in fcm tokens collection
    final header = {
      "authorization" : 'Bearer $jwtToken',
      "Content-Type": "application/json"
    };

    Map data = {
      'userId': uid,
      'fcm_token' : fcmToken
    };

    var reqBody = json.encode(data);

    final res = await http.post(Uri.parse('$userBaseUrl/fcm-token'),
      headers: header,
      body: reqBody
    );

    if(res.statusCode == 200){
      debugPrint('fcm token stored successfully!');
    }
    else{
      debugPrint('error storing fcm token : ${res.body}');
    }
    return;
}

// method to update user location
Future<void> updateLocation(LocationDTO newLocation) async {
   User? user = FirebaseAuth.instance.currentUser;
   final token = await user?.getIdToken().then((val) => val);
   final header = {
     "authorization" : 'Bearer $token',
     "Content-Type": "application/json"
   };

   Map data = {
     'userId':user?.uid,
     'location':{
       'lattitude': newLocation.lattitude,
       'longitude': newLocation.longitude,
       'address': newLocation.address
     }
   };
   var reqBody = json.encode(data);
   final res = await http.post(Uri.parse('$userBaseUrl/update-location'),
     headers: header,
     body: reqBody
   );
   if(res.statusCode == 200){
     print('location updated successfully!');
   }
  else{
    print('location update failed!');
   }
}

//  method to get user by mobile number
Future<CurrentUser> getUserByMobile(String? mobileNumber) async {
  String mobile = (mobileNumber == null) ? "" : mobileNumber.toString();
  if(mobile == ""){
    throw Exception('user mobile number is empty : $mobile');
  }
  // removing +91 i.e country code from mobile number
  mobile = mobile.substring(3);
  User? user =  FirebaseAuth.instance.currentUser;
  final token = await user?.getIdToken().then((val)=>val);

  print('jwt token: $token');

  final header = {
    "authorization": 'Bearer $token'
  };

  final response = await http.get(Uri.parse('$userBaseUrl/mobile/$mobile'),headers: header);
  if(response.statusCode == 200){
     await storeFcmToken(user?.uid, token);
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
      'location': {
        'longitude': newUser.location.longitude,
        'lattitude': newUser.location.lattitude,
        'address': newUser.location.address
      },
      'profilePic' : newUser.profilePic
    };

    print('req body before encoding : $data');

    // encode the Map to JSON
    var requestBody = json.encode(data);

    print('req body after encoding $requestBody');



    final response = await http.post(Uri.parse('$userBaseUrl/signup'),
      headers: header,
      body: requestBody
    );

    print('response status ${response.statusCode}');
    print('reponse for register user : ${response.body}');

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


// method to fetch all the users
Future<List<CurrentUser>> getAllUsers() async {
   User? user = FirebaseAuth.instance.currentUser;
   final token = await user?.getIdToken().then((val) => val);
   final header = {
     "authorization": 'Bearer $token'
   };
   final res = await http.get(Uri.parse(userBaseUrl),
     headers: header
   );
   if(res.statusCode == 200){
     var parsed = jsonDecode(res.body);
     List<dynamic> data = parsed['data'];
     bool status = parsed['status'];
     String msg = parsed['message'];
     List<CurrentUser> list = [];
     if(status == true && data.isNotEmpty){
       List<Map<String , dynamic >> jsons = data.map((d) => {'data' : d}).toList();
       list = jsons.map((d) => CurrentUser.fromJson(d)).toList();
     }
     return list;
   }
   else if(res.statusCode == 401){
     print('user is unauthorized to access the api: ${res.body} ');
     throw Exception(jsonDecode(res.body));
   }
   else{
     throw Exception('Failed to fetch all users');
   }

}

// method to fetch user connections list
Future<List<CurrentUser>> getUserConnections() async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization": 'Bearer $token'
  };
  final res = await http.get(Uri.parse('$userBaseUrl/$uid/connections'),
      headers: header
  );
  if(res.statusCode == 200){
    var parsed = jsonDecode(res.body);
    List<dynamic> data = parsed['data'];
    bool status = parsed['status'];
    String msg = parsed['message'];
    List<CurrentUser> list = [];
    if(status == true && data.isNotEmpty){
      List<Map<String , dynamic >> jsons = data.map((d) => {'data' : d}).toList();
      list = jsons.map((d) => CurrentUser.fromJson(d)).toList();
    }
    return list;
  }
  else if(res.statusCode == 401){
    print('user is unauthorized to access the api: ${res.body} ');
    throw Exception(jsonDecode(res.body));
  }
  else{
    throw Exception('Failed to fetch user connections');
  }


}

// method to fetch user requests list
Future<List<CurrentUser>> getUserRequests() async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization": 'Bearer $token'
  };
  final res = await http.get(Uri.parse('$userBaseUrl/$uid/requests'),
      headers: header
  );
  if(res.statusCode == 200){
    var parsed = jsonDecode(res.body);
    List<dynamic> data = parsed['data'];
    bool status = parsed['status'];
    String msg = parsed['message'];
    List<CurrentUser> list = [];
    if(status == true && data.isNotEmpty){
      List<Map<String , dynamic >> jsons = data.map((d) => {'data' : d}).toList();
      list = jsons.map((d) => CurrentUser.fromJson(d)).toList();
    }
    return list;
  }
  else if(res.statusCode == 401){
    print('user is unauthorized to access the api: ${res.body} ');
    throw Exception(jsonDecode(res.body));
  }
  else{
    throw Exception('Failed to fetch  user requests');
  }


}

// method to fetch user invitation list
Future<List<CurrentUser>> getUserInvitations() async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization": 'Bearer $token'
  };
  final res = await http.get(Uri.parse('$userBaseUrl/$uid/invitations'),
      headers: header
  );
  if(res.statusCode == 200){
    var parsed = jsonDecode(res.body);
    List<dynamic> data = parsed['data'];
    bool status = parsed['status'];
    String msg = parsed['message'];
    List<CurrentUser> list = [];
    if(status == true && data.isNotEmpty){
      List<Map<String , dynamic >> jsons = data.map((d) => {'data' : d}).toList();
      list = jsons.map((d) => CurrentUser.fromJson(d)).toList();
    }
    return list;
  }
  else if(res.statusCode == 401){
    print('user is unauthorized to access the api: ${res.body} ');
    throw Exception(jsonDecode(res.body));
  }
  else{
    throw Exception('Failed to fetch  user invitations');
  }
}

// method to invite / request a user to connect
Future<Map<String , dynamic>> inviteUser(String userId , String workId) async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization" : 'Bearer $token',
    "Content-Type": "application/json"
  };

  Map data = {
    'userId': userId,
    'workId': workId,
  };

  // encode the map to json
  var reqBody = json.encode(data);
  print('reqbody : $reqBody');
  print('token $token');
  print('uid : $uid');

  final res = await http.post(Uri.parse('$userBaseUrl/$uid/invite-user'),
    headers: header,
    body: reqBody
  );

  print('response status ${res.statusCode}');
  print('repsonse body ${res.body}');

  Map<String , dynamic > apiRes = {};

  if(res.statusCode == 200){
    apiRes = jsonDecode(res.body);
  }
  else if(res.statusCode == 400){
    apiRes = jsonDecode(res.body);
  }
  else {
    apiRes = {
      'status' : false ,
      'message' : 'internal server error',
      'data' : []
    };
  }

  return apiRes;
}


//method to cancel the invite / request a user to connect
// the user who sent the invite will cancel here
Future<Map<String , dynamic>> cancelInvitation(String userId , String workId) async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization" : 'Bearer $token',
    "Content-Type": "application/json"
  };

  Map data = {
    'userId': userId,
    'workId': workId,
  };
  // encode the map to json
  var reqBody = json.encode(data);
  final res = await http.post(Uri.parse('$userBaseUrl/$uid/cancel-invite'),
      headers: header,
      body: reqBody
  );
  print('response status ${res.statusCode}');
  print('repsonse body ${res.body}');

  Map<String , dynamic > apiRes = {};
  if(res.statusCode == 200){
    apiRes = jsonDecode(res.body);
  }
  else if(res.statusCode == 400){
    apiRes = jsonDecode(res.body);
  }
  else {
    apiRes = {
      'status' : false ,
      'message' : 'internal server error',
      'data' : []
    };
  }

  return apiRes;
}


// method to accept the invite / request to connect
Future<Map<String , dynamic>> acceptRequest(String userId , String workId) async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization" : 'Bearer $token',
    "Content-Type": "application/json"
  };
  Map data = {
    'userId': userId,
    'workId': workId,
  };
  // encode the map to json
  var reqBody = json.encode(data);
  final res = await http.post(Uri.parse('$userBaseUrl/$uid/accept-request'),
      headers: header,
      body: reqBody
  );
  print('response status ${res.statusCode}');
  print('repsonse body ${res.body}');

  Map<String , dynamic > apiRes = {};
  if(res.statusCode == 200){
    apiRes = jsonDecode(res.body);
  }
  else if(res.statusCode == 400){
    apiRes = jsonDecode(res.body);
  }
  else {
    apiRes = {
      'status' : false ,
      'message' : 'internal server error',
      'data' : []
    };
  }

  return apiRes;


}

// method to ignore the invite / request to connect
Future<Map<String , dynamic>> ignoreRequest(String userId , String workId) async {
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization" : 'Bearer $token',
    "Content-Type": "application/json"
  };
  Map data = {
    'userId': userId,
    'workId': workId,
  };
  // encode the map to json
  var reqBody = json.encode(data);
  final res = await http.post(Uri.parse('$userBaseUrl/$uid/ignore-request'),
      headers: header,
      body: reqBody
  );
  print('response status ${res.statusCode}');
  print('repsonse body ${res.body}');

  Map<String , dynamic > apiRes = {};
  if(res.statusCode == 200){
    apiRes = jsonDecode(res.body);
  }
  else if(res.statusCode == 400){
    apiRes = jsonDecode(res.body);
  }
  else {
    apiRes = {
      'status' : false ,
      'message' : 'internal server error',
      'data' : []
    };
  }

  return apiRes;


}






















