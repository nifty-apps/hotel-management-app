class AddRoom {
  String? floor;
  String? number;
  String? type;
  int? rent;
  AddRoom({
    required this.floor,
    required this.number,
    required this.type,
    required this.rent,
  });

  AddRoom.fromJson(Map<String, dynamic> json) {
    floor = json['floor'];
    number = json['number'];
    type = json['roomType'];
    rent = json['rent'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor'] = this.floor;
    data['number'] = this.number;
    data['roomType'] = this.type;
    data['rent'] = this.rent;

    return data;
  }
}
