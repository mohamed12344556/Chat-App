// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String message;
  final String id;
  final String senderImageUrl;
  final String receiverImageUrl;

  MessageModel({
    required this.message,
    required this.id,
    required this.senderImageUrl,
    required this.receiverImageUrl,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      message: json['message'],
      id: json['id'],
      senderImageUrl: json['senderImageUrl'],
      receiverImageUrl: json['receiverImageUrl'],
    );
  }
}
