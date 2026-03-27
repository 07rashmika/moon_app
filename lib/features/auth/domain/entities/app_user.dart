class AppUser {
  AppUser({required this.uid, required this.email});

  final String uid;
  final String email;

  //convert AppUser to json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }

  //convert json to AppUser
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(uid: 'uid', email: 'email');
  }
}
