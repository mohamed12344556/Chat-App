import 'dart:io';

import 'package:chat_app/models/upload_file_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/upload_file_service.dart';
import 'package:chat_app/widgets/chat_ai_bupel.dart';
import 'package:chat_app/widgets/chat_user_bupel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  static const String id = 'ai_chat_screen';

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  File? selectedFile;
  bool isFileLoading = false;
  UploadFileModel? response;

  final UploadFileService apiService = UploadFileService();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
      await _uploadFile(); // بعد تحديد الملف، نقوم برفعه
    }
  }

  Future<void> _uploadFile() async {
    if (selectedFile == null) return;

    setState(() {
      isFileLoading = true;
    });

    try {
      UploadFileModel? uploadResponse =
          await apiService.uploadPdf(selectedFile!);

      setState(() {
        response = uploadResponse;
        isFileLoading = false;
      });

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('File uploaded successfully: ${response!.message}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File upload failed')),
        );
      }
    } catch (e) {
      setState(() {
        isFileLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  final ChatService _chatService = ChatService();

  // List to hold messages (user input + AI response)
  List<Map<String, dynamic>> _messages = [];

  void _sendQuestion() async {
    // Get the user's question
    final userQuestion = _controller.text.trim();

    if (userQuestion.isEmpty) return;

    // Clear the input field
    _controller.clear();

    // Add the user's message to the list
    setState(() {
      _messages.add({'sender': 'user', 'message': userQuestion});
      _isLoading = true;

      // Add a temporary widget showing a loading indicator (Lottie)
      _messages.add({
        'sender': 'ai',
        'message': 'loading', // Placeholder for loading
      });
    });

    try {
      // Send the question and wait for the response
      final chatResponse = await _chatService.sendQuetion(userQuestion);

      // Replace the loading indicator with the AI's actual response
      setState(() {
        _messages[_messages.length - 1] = {
          'sender': 'ai',
          'message': chatResponse.response,
        };
      });
    } catch (e) {
      setState(() {
        _messages[_messages.length - 1] = {
          'sender': 'ai',
          'message': 'Error: $e',
        };
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0xff000E08),
            size: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length, // The number of messages
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == 'user';

                // Depending on the sender, show different message styles
                if (isUserMessage) {
                  return ChatUser(message: message);
                } else {
                  // Check if it's loading message
                  if (message['message'] == 'loading') {
                    return ChatAI(message: message);
                  }
                  // Otherwise, show it as a normal text message
                  return ChatAI(message: message);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter your message',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(
                    color: Color(0xffCDD1D0),
                    width: 1.3,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed:
                      _sendQuestion, // Call the send function when pressed
                  icon: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: Color(0xff000E08),
                    size: 20,
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: isFileLoading ? null : _pickFile,
                  icon: isFileLoading
                      ? const CircularProgressIndicator()
                      : const FaIcon(
                          FontAwesomeIcons.paperclip,
                          color: Color(0xff000E08),
                          size: 20,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
