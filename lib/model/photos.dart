class PhotosModel {
  final String url;
  final String authorName;

  PhotosModel({required this.url, required this.authorName});

  // Convert a Map into a PhotosModel
  factory PhotosModel.fromMap(Map<String, dynamic> map) {
    return PhotosModel(
      url: map['src']['portrait'] ?? '',
      authorName: map['photographer'] ?? '',
    );
  }

  // Convert a PhotosModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'authorName': authorName,
    };
  }
}
