class Comment {
  String username, userId, userProfilePicUrl, body;
  int likeCount;
  List<Comment> replies;
  DateTime dateTime;

  Comment(
      {this.username,
      this.userId,
      this.userProfilePicUrl,
      this.body,
      this.likeCount,
      this.replies,
      this.dateTime});
}
