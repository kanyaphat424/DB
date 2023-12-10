class UserProfile {
  String name;
  String address;
  String tel;
  String birthday;
  String sex;
  String email;
  int age;
 
 

  UserProfile({
    required this.name,
    required this.address,
    required this.tel,
    required this.birthday,
    required this.sex,
    required this.email,
    required this.age,
  
    
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      address: json['address'],
      tel: json['phone'],
      birthday: json['dateOfBirth'],
      sex: json['sex'],
      email: json['email'],
      age: json['age'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': tel,
      'dateOfBirth': birthday,
      'sex': sex,
      'email': email,
      'age': age,
    };
  }
}