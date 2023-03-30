class Room {
  String? id;
  String? number;
  RoomType? roomType;
  String? hotel;
  String? createdAt;
  String? updatedAt;

  Room(
      {this.id,
      this.number,
      this.roomType,
      this.hotel,
      this.createdAt,
      this.updatedAt});

  Room.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    number = json['number'];
    roomType = json['roomType'] != null
        ? new RoomType.fromMap(json['roomType'])
        : null;
    hotel = json['hotel'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['number'] = this.number;
    if (this.roomType != null) {
      data['roomType'] = this.roomType!.toMap();
    }
    data['hotel'] = this.hotel;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class RoomType {
  String? id;
  String? type;
  int? rent;
  String? description;

  RoomType({this.id, this.type, this.rent, this.description});

  RoomType.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    rent = json['rent'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['type'] = this.type;
    data['rent'] = this.rent;
    data['description'] = this.description;
    return data;
  }
}
