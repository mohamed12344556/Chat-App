class UploadFileModel {
  final String message;

  UploadFileModel({required this.message});
  
  factory UploadFileModel.fromJson(Map<String, dynamic> json) {
    return UploadFileModel(
      message: json['message'],
    );
  }
}
