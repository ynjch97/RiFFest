class UserModel {
  final String uid;
  final String name;
  final String email;
  final String nickname;
  final String bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.nickname,
    required this.bio,
  });

  UserModel.empty()
      : uid = "",
        name = "",
        email = "",
        nickname = "",
        bio = "";

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        name = json["name"],
        email = json["email"],
        nickname = json["nickname"],
        bio = json["bio"];

  // JSON 으로 변경하기
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "nickname": nickname,
      "bio": bio,
    };
  }
}
