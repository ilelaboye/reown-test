class User {
  final String name;
  final String email;
  final String id;

  User({required this.name, required this.email, required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
