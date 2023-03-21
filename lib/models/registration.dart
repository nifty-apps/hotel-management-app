class RegistrationModel {
  String? name;
  String? email;
  String? password;
  String? role;
  String? phone;
  String? address;
  RegistrationModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
     this.phone,
     this.address,
  });

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    phone = json['phone'];
    address = json['address'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['phone'] = this.name;
    data['address'] = this.address;
    return data;
  }
}
