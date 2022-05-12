import 'package:quickdeed/Models/current_user.dart';

class Work{
  final String name;
  final String userId;
  final String type;
  final double duration;
  final String description;
  final double amount;
  final LocationDTO location;
  final String createdAt;
  final String userName;
  final String workId;

  Work({
    required this.userId ,
    required this.name,
    required this.type,
    required this.description,
    required this.duration,
    required this.amount,
    required this.location,
    required this.createdAt,
    required this.userName,
    required this.workId,
  });

  factory Work.fromJson(Map<String , dynamic > data){
     String userId = data['userId'];
     String name = data['name'];
     String type = data['type'] ?? "NA";
     double amount = data['amount']?.toDouble() ?? 0.toDouble();
     double duration = data['duration']?.toDouble() ?? 0.toDouble();
     String description = data['description'] ?? "NA";
     LocationDTO loc = LocationDTO.fromJson(data['location']);
     String createdAt = data['createdAt'] ?? "";
     String userName = data['userName'] ?? "";
     String workId = data['_id'];

     return Work(
       userId: userId,
       name: name,
       type: type,
       amount: amount,
       description: description,
       duration: duration,
       location: loc,
       createdAt : createdAt,
       userName: userName,
       workId: workId
     );
  }

}