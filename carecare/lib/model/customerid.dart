class Admincustomerid {
  String address;
  String name;
  String birthday;
  String tel;
  String email;
  String sex;
  String accountId;
  

  Admincustomerid({
    required this.accountId,
    required this.name,
    required this.address,
    required this.tel,
    required this.email,
     required this.birthday,
    required this.sex,
    
  });

  factory Admincustomerid.fromJson(Map<String, dynamic> json) {
    return Admincustomerid(
      accountId: json['customerid'],
      name: json['fname'],
      address: json['address'],
     tel: json['phone'],
      email: json['email'],
      birthday: json['birthday'],
     sex: json['sex'],
     

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'name': name,
      'address': address,
      'tel': tel,
      'email': email,
      'birthday': birthday,
      'sex': sex,
      

    };
  }
}