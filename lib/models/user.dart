class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final Map<String, dynamic> name;
  final Map<String, dynamic> address;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
    );
  }

  Object? toJson() {
    return null;
  }
}