
class LocationDTO{
  final String address;
  final num longitude;
  final num lattitude;

  LocationDTO({required this.address , required this.lattitude ,required this.longitude});

  factory LocationDTO.fromJson(Map< String , dynamic > json){
    return LocationDTO(
      address: json['address'],
      longitude: num.parse(json['longitude'].toString()),
      lattitude: num.parse(json['lattitude'].toString())
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
  final num rating;
  final LocationDTO location;
  final List<RequestDTO> requests;
  final List<ConnectionDTO> connections;
  final List<InvitationDTO> invitations;
  final String createdAt;
  final String updatedAt;
  final String profilePic;

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
    required this.profilePic
  });

  factory CurrentUser.fromJson(Map< String , dynamic> respBody){
    Map < String , dynamic >? json = respBody['data'];

    // check if the json data is null or not

    if(json == null){
      return CurrentUser(
          userId: '',
          userName: '',
          email: '',
          mobile: 0,
          skills: [],
          rating: 0,
          location: LocationDTO(address:"",lattitude: 0 , longitude: 0),
          requests: [],
          connections: [],
          invitations: [],
          createdAt: '',
          updatedAt: '',
          profilePic: ''
      );
    }

    String userId = json['userId'];
    String userName = json['userName'];
    String email = json['email'];
    String profilePic = json['profilePic'];
    int mobile = json['mobile'];
    num rating = json['rating'] ?? 0;
    String createdAt = json['createdAt'];
    String updatedAt = json['updatedAt'];
    List<String> skills = json['skills'].cast<String>();
    List<RequestDTO> requests = json['requests'].cast<RequestDTO>();
    List<ConnectionDTO> connections = json['connections'].cast<ConnectionDTO>();
    List<InvitationDTO> invitations = json['invitations'].cast<InvitationDTO>();
    LocationDTO location = LocationDTO.fromJson(json['location']);


    return CurrentUser(
        userId: userId,
        userName: userName,
        email: email,
        mobile: mobile,
        rating: rating,
        skills: skills,
        location: location,
        requests: requests,
        connections: connections,
        invitations: invitations,
        createdAt: createdAt,
        updatedAt: updatedAt,
        profilePic: profilePic
    );
  }

}