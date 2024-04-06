class UserModel {
  String id;
  String username;
  String email;
  bool verified;
  bool totpEnabled;
  bool isAdmin;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.verified,
    required this.totpEnabled,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      verified: json['verified'],
      totpEnabled: json['totpEnabled'],
      isAdmin: json['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'verified': verified,
      'totp_enabled': totpEnabled,
      'isAdmin': isAdmin,
    };
  }
}
