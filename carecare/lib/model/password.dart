class UserPassword {
  String password2;
  String password3;
 

  UserPassword({
    
    
    required this.password2,
    required this.password3,
    
  });

  factory UserPassword.fromJson(Map<String, dynamic> json) {
    return UserPassword(
      
      
      password2: json['password2'],
      password3: json['password3'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      
      
      'password2': password2,
      'password3': password3,
    
    };
  }
}