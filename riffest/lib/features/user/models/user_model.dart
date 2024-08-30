class UserModel {
  final String uid;
  final String name;
  final String email;
  final String nickname;
  final String bio;
  final List<String> bookmarks;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.nickname,
    required this.bio,
    required this.bookmarks,
  });

  UserModel.empty()
      : uid = "",
        name = "",
        email = "",
        nickname = "",
        bio = "",
        bookmarks = [];

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        name = json["name"],
        email = json["email"],
        nickname = json["nickname"],
        bio = json["bio"],
        bookmarks = json["bookmarks"] != null
            ? List<String>.from(json["bookmarks"])
            : [];

  // JSON 으로 변경하기
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "nickname": nickname,
      "bio": bio,
      "bookmarks": bookmarks,
    };
  }
}
