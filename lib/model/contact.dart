class Contact {
  String username;
  String msg;

  Contact({this.username, this.msg});

  factory Contact.fromJson(Map<String, dynamic> con) {
    return Contact(username: con['username'], msg: con['msg']);
  }
}
