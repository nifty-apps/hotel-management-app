import 'dart:convert';

class Room {
  int id;
  String name;
  int roomNo;
  int isBooked;
  int haveAc;
  int? floorId;
  int? roomTypeId;
  int? sizeId;
  int? numOfBed;
  int? numOfBathroom;
  int? numOfLight;
  int? numOfFan;
  int? haveFridge;
  int? haveBelcony;
  int? haveAlmary;
  int? haveShoebox;
  int? status;
  Room({
    required this.id,
    required this.name,
    required this.roomNo,
    required this.isBooked,
    required this.haveAc,
    this.floorId,
    this.roomTypeId,
    this.sizeId,
    this.numOfBed,
    this.numOfBathroom,
    this.numOfLight,
    this.numOfFan,
    this.haveFridge,
    this.haveBelcony,
    this.haveAlmary,
    this.haveShoebox,
    this.status,
  });

  Room copyWith({
    int? id,
    String? name,
    int? roomNo,
    int? isBooked,
    int? haveAc,
    int? floorId,
    int? roomTypeId,
    int? sizeId,
    int? numOfBed,
    int? numOfBathroom,
    int? numOfLight,
    int? numOfFan,
    int? haveFridge,
    int? haveBelcony,
    int? haveAlmary,
    int? haveShoebox,
    int? status,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      roomNo: roomNo ?? this.roomNo,
      isBooked: isBooked ?? this.isBooked,
      haveAc: haveAc ?? this.haveAc,
      floorId: floorId ?? this.floorId,
      roomTypeId: roomTypeId ?? this.roomTypeId,
      sizeId: sizeId ?? this.sizeId,
      numOfBed: numOfBed ?? this.numOfBed,
      numOfBathroom: numOfBathroom ?? this.numOfBathroom,
      numOfLight: numOfLight ?? this.numOfLight,
      numOfFan: numOfFan ?? this.numOfFan,
      haveFridge: haveFridge ?? this.haveFridge,
      haveBelcony: haveBelcony ?? this.haveBelcony,
      haveAlmary: haveAlmary ?? this.haveAlmary,
      haveShoebox: haveShoebox ?? this.haveShoebox,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'roomNo': roomNo,
      'isBooked': isBooked,
      'haveAc': haveAc,
      'floorId': floorId,
      'roomTypeId': roomTypeId,
      'sizeId': sizeId,
      'numOfBed': numOfBed,
      'numOfBathroom': numOfBathroom,
      'numOfLight': numOfLight,
      'numOfFan': numOfFan,
      'haveFridge': haveFridge,
      'haveBelcony': haveBelcony,
      'haveAlmary': haveAlmary,
      'haveShoebox': haveShoebox,
      'status': status,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      roomNo: map['roomNo']?.toInt() ?? 0,
      isBooked: map['isBooked']?.toInt() ?? 0,
      haveAc: map['haveAc']?.toInt() ?? 0,
      floorId: map['floorId']?.toInt(),
      roomTypeId: map['roomTypeId']?.toInt(),
      sizeId: map['sizeId']?.toInt(),
      numOfBed: map['numOfBed']?.toInt(),
      numOfBathroom: map['numOfBathroom']?.toInt(),
      numOfLight: map['numOfLight']?.toInt(),
      numOfFan: map['numOfFan']?.toInt(),
      haveFridge: map['haveFridge']?.toInt(),
      haveBelcony: map['haveBelcony']?.toInt(),
      haveAlmary: map['haveAlmary']?.toInt(),
      haveShoebox: map['haveShoebox']?.toInt(),
      status: map['status']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) => Room.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Room(id: $id, name: $name, roomNo: $roomNo, isBooked: $isBooked, haveAc: $haveAc, floorId: $floorId, roomTypeId: $roomTypeId, sizeId: $sizeId, numOfBed: $numOfBed, numOfBathroom: $numOfBathroom, numOfLight: $numOfLight, numOfFan: $numOfFan, haveFridge: $haveFridge, haveBelcony: $haveBelcony, haveAlmary: $haveAlmary, haveShoebox: $haveShoebox, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Room &&
        other.id == id &&
        other.name == name &&
        other.roomNo == roomNo &&
        other.isBooked == isBooked &&
        other.haveAc == haveAc &&
        other.floorId == floorId &&
        other.roomTypeId == roomTypeId &&
        other.sizeId == sizeId &&
        other.numOfBed == numOfBed &&
        other.numOfBathroom == numOfBathroom &&
        other.numOfLight == numOfLight &&
        other.numOfFan == numOfFan &&
        other.haveFridge == haveFridge &&
        other.haveBelcony == haveBelcony &&
        other.haveAlmary == haveAlmary &&
        other.haveShoebox == haveShoebox &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        roomNo.hashCode ^
        isBooked.hashCode ^
        haveAc.hashCode ^
        floorId.hashCode ^
        roomTypeId.hashCode ^
        sizeId.hashCode ^
        numOfBed.hashCode ^
        numOfBathroom.hashCode ^
        numOfLight.hashCode ^
        numOfFan.hashCode ^
        haveFridge.hashCode ^
        haveBelcony.hashCode ^
        haveAlmary.hashCode ^
        haveShoebox.hashCode ^
        status.hashCode;
  }
}
