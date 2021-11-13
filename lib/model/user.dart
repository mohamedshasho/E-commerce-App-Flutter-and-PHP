class User {
  // int userId;
  // String username;
  String email;
  String password;

  User({
    // this.userId,
    // this.username,
    this.email,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      // userId: responseData['id'],
      // username: responseData['username'],
      email: responseData['email'],
      password: responseData['password'],
    );
  }
}
