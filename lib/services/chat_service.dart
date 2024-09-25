import 'dart:convert';
import 'package:chat_app/models/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiUrl = 'https://api-chat-with-docs.onrender.com/chatpdf/';

  Future<ChatModel> sendQuetion(String question) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"question": question});

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(decodedBody);
        return ChatModel.fromJson(data);
      } else {
        throw Exception('Failed to get response from API');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
