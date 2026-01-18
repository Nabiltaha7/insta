class PostModel {
  int? id;
  String image;
  String caption;

  PostModel({this.id, required this.image, required this.caption});

  Map<String, dynamic> toMap() {
    return {'id': id, 'image': image, 'caption': caption};
  }
}
