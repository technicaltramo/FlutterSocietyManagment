

class Message {
  String content;
  String fromUser;
  String toUser;
  String createdAt;

  Message({this.content, this.fromUser, this.toUser, this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    fromUser = json['fromUser'];
    toUser = json['toUser'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['fromUser'] = this.fromUser;
    data['toUser'] = this.toUser;
    data['createdAt'] = this.createdAt;
    return data;
  }
}