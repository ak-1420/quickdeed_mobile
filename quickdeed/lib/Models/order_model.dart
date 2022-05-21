class Order{
  final String orderId;
  final String workId;
  final String assignedBy;
  final String assignedTo;
  final int status;
  final List<dynamic> logs;
  final String createdAt;
  final String updatedAt;

  Order({required this.orderId , required this.workId , required this.assignedBy , required this.assignedTo , required this.status , required this.logs, required this.createdAt , required this.updatedAt});

  factory Order.fromJson(Map<String , dynamic> respBody){
    Map<String , dynamic>? json = respBody['data'];
    if(json != null){
       String assigned_by = json['assignedBy'];
       String assigned_to = json['assignedTo'];
       String work_id = json['workId'];
       String order_id = json['_id'];
       int status = json['status'];
       String created_at = json['createdAt'];
       String updated_at = json['updatedAt'];
       List<dynamic> ls = json['log'];
       return Order(orderId: order_id, workId: work_id, assignedBy: assigned_by, assignedTo: assigned_to, status: status, logs: ls, createdAt: created_at, updatedAt: updated_at);
    }
    throw Exception('Order from json error');
  }

}