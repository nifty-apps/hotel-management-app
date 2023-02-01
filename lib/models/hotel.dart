import 'dart:convert';

class Hotel {
  final String id;
  final String name;
  final String address;
  Hotel({
    required this.id,
    required this.name,
    required this.address,
  });

  Hotel copyWith({
    String? id,
    String? name,
    String? address,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'address': address,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      id: map['_id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hotel.fromJson(String source) =>
      Hotel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Hotel(id: $id, name: $name, address: $address)';

  @override
  bool operator ==(covariant Hotel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode;
}
