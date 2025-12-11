class Message {
  String? senderId;
  String? receiverId;
  String? message;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.senderId,
        this.receiverId,
        this.message,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['message'] = this.message;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}