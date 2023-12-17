class User{
  final String uid;
  final String firstName;
  final String lastName;
  final String dob;
  final String email;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['date_of_birth'],
      email: json['email'],
    );
    
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "first_name": firstName,
    "last_name": lastName,
    "date_of_birth": dob,
    "email": email,
  };

}