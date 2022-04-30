
class LocationDTO{
  final String address;
  final num longitude;
  final num lattitude;

  LocationDTO({required this.address , required this.lattitude ,required this.longitude});

  factory LocationDTO.fromJson(Map< String , dynamic > json){
    return LocationDTO(
      address: json['address'],
      longitude: json['longitude'],
      lattitude: json['lattitude']
    );
  }
}

class RequestDTO{
  final String userId;
  final String workId;

  RequestDTO({required this.userId , required this.workId});

  factory RequestDTO.fromJson(Map< String , dynamic > json){
    return RequestDTO( userId : json['userId'],workId: json['workId']);
  }
}

class ConnectionDTO{
  final String userId;
  final String workId;

  ConnectionDTO({required this.userId , required this.workId});

  factory ConnectionDTO.fromJson(Map< String , dynamic> json){
    return ConnectionDTO(userId: json['userId'], workId: json['workId']);
  }

}

class InvitationDTO{

  final String userId;
  final String workId;

  InvitationDTO({required this.workId , required this.userId});

  factory InvitationDTO.fromJson(Map<String , dynamic > json){
    return InvitationDTO(workId: json['workId'], userId: json['userId']);
  }

}

class CurrentUser
{
  final String userName;
  final String userId;
  final String email;
  final int mobile;
  final List<String> skills;
  final String rating;
  final List<LocationDTO> location;
  final List<RequestDTO> requests;
  final List<ConnectionDTO> connections;
  final List<InvitationDTO> invitations;
  final String createdAt;
  final String updatedAt;

  CurrentUser({
    required this.userId,
    required this.userName,
    required this.email,
    required this.mobile,
    required this.skills,
    required this.rating,
    required this.location,
    required this.requests,
    required this.connections,
    required this.invitations,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentUser.fromJson(Map< String , dynamic> json){
    return CurrentUser(
        userId: json['userId'],
        userName: json['userName'],
        email: json['email'],
        mobile: json['mobile'],
        skills: json['skills'],
        rating: json['rating'],
        location: json['location'],
        requests: json['requests'],
        connections: json['connections'],
        invitations: json['invitations'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']
    );
  }

}