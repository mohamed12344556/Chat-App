class ChatModel {
  final String response;

  ChatModel({required this.response});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(response: json['response']);
  }
}
