class ResponseMessages {
  final List<Message>? messages;

  ResponseMessages({
    this.messages,
  });

  ResponseMessages.fromJson(Map<String, dynamic> json)
      : messages = (json['Messages'] as List?)
            ?.map((dynamic e) => Message.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'Messages': messages?.map((e) => e.toJson()).toList()};
}

class Message {
  int? id;
  int? senderId;
  int? reciverId;
  String? title;
  String? text;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.senderId,
      this.reciverId,
      this.title,
      this.text,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    reciverId = json['reciver_id'];
    title = json['title'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['reciver_id'] = this.reciverId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
