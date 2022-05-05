class UserModel{
  String id;
  String username;
  String email;

  UserModel({required this.id, required this.username, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email']
    );
  }
}