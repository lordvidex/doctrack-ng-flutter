class SignUpModel{
  String firstName;
  String email;
  String password;
  String lastName;

  SignUpModel({required this.email, required this.firstName, required this.password, required this.lastName});

  Map<String, dynamic> toJson(){
    return{
     'firstName':firstName,
     'email':email,
     'lastName':lastName,
     'password':password
    };
  }
}