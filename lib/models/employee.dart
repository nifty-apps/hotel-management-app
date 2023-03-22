class Employee {
  String? id;
  String? name;
  String? email;
  String? role;
  String? phone;
  String? address;
  Employee({
    this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.address,
  });

  Employee.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    address = json['address'];
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
