import 'dart:convert';
import 'dart:io';
import 'package:chat_app/models/upload_file_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UploadFileService {
  final String apiUrl = "https://api-chat-with-docs.onrender.com/upload/";

  Future<UploadFileModel?> uploadPdf(File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // تحديد نوع الملف بشكل صحيح
      var mimeType = lookupMimeType(file.path);
      if (mimeType == null) {
        throw Exception('Unknown file type');
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('application', 'pdf'),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);

        return UploadFileModel.fromJson(jsonResponse);
      } else {
        print("Failed to upload: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
    return null;
  }
}
