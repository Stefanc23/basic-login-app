class User {
  String username;
  bool isAdmin;

  User({required this.username, required this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username'], isAdmin: json['isAdmin']);
  }
}
