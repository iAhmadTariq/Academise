class User{
  final String uid;
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String type;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.type,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['date_of_birth'],
      email: json['email'],
      type: json['type'],
    );
    
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "first_name": firstName,
    "last_name": lastName,
    "date_of_birth": dob,
    "email": email,
    "type": type,
  };

}