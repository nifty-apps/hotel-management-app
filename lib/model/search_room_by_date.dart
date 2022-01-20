class SearchRoom {
  dynamic success;
  int? totalRoom;
  List<Data1>? data;

  SearchRoom({this.success, this.totalRoom, this.data});

  SearchRoom.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalRoom = json['total_room'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total_room'] = this.totalRoom;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data1 {
  int? id;
  int? floorId;
  int? roomTypeId;
  int? sizeId;
  String? name;
  dynamic roomNo;
  dynamic numOfBed;
  dynamic numOfBathroom;
  dynamic numOfLight;
  dynamic numOfFan;
  dynamic haveAc;

  dynamic haveFridge;
  dynamic haveBelcony;
  dynamic haveAlmary;
  dynamic haveShoebox;
  int? isBooked;
  int? status;
  String? createdAt;
  String? updatedAt;
  Floor? floor;
  RoomType? roomType;

  Data1(
      {this.id,
      this.floorId,
      this.roomTypeId,
      this.sizeId,
      this.name,
      this.roomNo,
      this.numOfBed,
      this.numOfBathroom,
      this.numOfLight,
      this.numOfFan,
      this.haveAc,
      this.haveFridge,
      this.haveBelcony,
      this.haveAlmary,
      this.haveShoebox,
      this.isBooked,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.floor,
      this.roomType});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floorId = json['floor_id'];
    roomTypeId = json['room_type_id'];
    sizeId = json['size_id'];
    name = json['name'];
    roomNo = json['room_no'];
    numOfBed = json['num_of_bed'];
    numOfBathroom = json['num_of_bathroom'];
    numOfLight = json['num_of_light'];
    numOfFan = json['num_of_fan'];
    haveAc = json['have_ac'];
    haveFridge = json['have_fridge'];
    haveBelcony = json['have_belcony'];
    haveAlmary = json['have_almary'];
    haveShoebox = json['have_shoebox'];
    isBooked = json['is_booked'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    floor = json['floor'] != null ? new Floor.fromJson(json['floor']) : null;
    roomType = json['room_type'] != null
        ? new RoomType.fromJson(json['room_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['floor_id'] = this.floorId;
    data['room_type_id'] = this.roomTypeId;
    data['size_id'] = this.sizeId;
    data['name'] = this.name;
    data['room_no'] = this.roomNo;
    data['num_of_bed'] = this.numOfBed;
    data['num_of_bathroom'] = this.numOfBathroom;
    data['num_of_light'] = this.numOfLight;
    data['num_of_fan'] = this.numOfFan;
    data['have_ac'] = this.haveAc;
    data['have_fridge'] = this.haveFridge;
    data['have_belcony'] = this.haveBelcony;
    data['have_almary'] = this.haveAlmary;
    data['have_shoebox'] = this.haveShoebox;
    data['is_booked'] = this.isBooked;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.floor != null) {
      data['floor'] = this.floor!.toJson();
    }
    if (this.roomType != null) {
      data['room_type'] = this.roomType!.toJson();
    }
    return data;
  }
}

class Floor {
  int? id;
  String? floor;
  String? createdAt;
  String? updatedAt;

  Floor({this.id, this.floor, this.createdAt, this.updatedAt});

  Floor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floor = json['floor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['floor'] = this.floor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RoomType {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;

  RoomType({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  RoomType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
