// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegistrationModel {
  String? name;
  String? email;
  String? phone;
  String? role;
  String? password;
  RegistrationModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.password,
  });

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    password = json['password'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.name;
    data['role'] = this.role;
    data['password'] = this.password;

    return data;
  }
}
