class CommentModel {
  int? id;
  int postId;
  String text;

  CommentModel({this.id, required this.postId, required this.text});
}
