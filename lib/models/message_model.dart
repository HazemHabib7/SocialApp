class MessageModel {
  String? senderId;
  String? receiverId;
  String? text;
  String? dateTime;

  MessageModel(
      {
        required senderId,
        required receiverId,
        required text,
        required dateTime,
      });

  MessageModel.fromJson(Map<String, dynamic>? json) {

    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
