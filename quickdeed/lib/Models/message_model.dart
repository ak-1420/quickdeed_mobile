class Message{
  final String type;
  final String message;
  final String senderId;
  final String receiverId;
  final int timestamp;
  Message({required this.type , required this.message , required this.senderId , required this.receiverId , required this.timestamp});

  factory Message.fromJson(Map<String , dynamic> respBody){
    Map<String , dynamic>? json = respBody['data'];
    if(json != null){
      String senderId = json['senderId'];
      String receiverId = json['receiverId'];
      String type = json['type'];
      String msg = json['message'];
      int timestamp = json['timestamp'];
      return Message(type: type, message: msg, senderId: senderId, receiverId: receiverId, timestamp: timestamp);
    }
    throw Exception('message from json error');
  }
}