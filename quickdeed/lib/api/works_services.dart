import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdeed/Models/work.dart';

const workBaseUrl = "https://works-service.vercel.app/api/v1/works";

//method to add a new work
Future<Work> create(Work newWork) async {
  User? user = FirebaseAuth.instance.currentUser;
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization": 'Bearer $token',
    "Content-Type": "application/json"
  };
  Map data = {
    'userName': newWork.userName,
    'userId': newWork.userId,
    'name': newWork.name,
    'type': newWork.type,
    'amount': newWork.amount,
    'duration': newWork.duration,
    'description': newWork.description,
    'location':{
      'longitude': newWork.location.longitude,
      'lattitude': newWork.location.lattitude,
      'address': newWork.location.address
    }
  };
  
  var reqBody = json.encode(data);
  final res = await http.post(Uri.parse('$workBaseUrl'),
    headers: header,
    body: reqBody
  );

  // parse data , status , message from response
  bool status = jsonDecode(res.body)['status'];
  String message = jsonDecode(res.body)['message'];
  print('response message from server: ${jsonDecode(res.body)}');

  if(res.statusCode == 201){
    Map<String , dynamic> resData = jsonDecode(res.body)['data'];
    return Work.fromJson(resData);
  }
  else {
    throw Exception(message);
  }
}

//method to get all the works
Future<List<Work>> getAllWorks() async {
  User? user = FirebaseAuth.instance.currentUser;
  final token = await user?.getIdToken().then((val) => val);
  final header = {
    "authorization": 'Bearer $token'
  };
  final res = await http.get(Uri.parse(workBaseUrl),headers: header);
  // parse data , status , message from response
  bool status = jsonDecode(res.body)['status'];
  String message = jsonDecode(res.body)['message'];

  if(res.statusCode == 200){
    List<dynamic> data = jsonDecode(res.body)['data'];
    List<Work> list = [];
    if(data.isNotEmpty){
      list = data.map((d) => Work.fromJson(d as Map<String , dynamic >)).toList();
    }
    return list;
  }
  else{
    throw Exception(message);
  }
}


