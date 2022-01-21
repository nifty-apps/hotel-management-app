// To parse this JSON data, do
//
//     final rooms = roomsFromJson(jsonString);

import 'dart:convert';

Rooms roomsFromJson(String str) => Rooms.fromJson(json.decode(str));

String roomsToJson(Rooms data) => json.encode(data.toJson());

class Rooms {
  Rooms({
    required this.success,
    required this.data,
  });

  bool success;
  List<Data> data;

  factory Rooms.fromJson(Map<String, dynamic> json) => Rooms(
        success: json['success'],
        data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.id,
    required this.floorId,
    required this.roomTypeId,
    this.sizeId,
    required this.name,
    required this.roomNo,
    this.numOfBed,
    this.numOfBathroom,
    this.numOfLight,
    this.numOfFan,
    required this.haveAc,
    this.haveFridge,
    this.haveBelcony,
    this.haveAlmary,
    this.haveShoebox,
    required this.isBooked,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int floorId;
  int roomTypeId;
  dynamic sizeId;
  String name;
  int roomNo;
  dynamic numOfBed;
  dynamic numOfBathroom;
  dynamic numOfLight;
  dynamic numOfFan;
  int haveAc;
  dynamic haveFridge;
  dynamic haveBelcony;
  dynamic haveAlmary;
  dynamic haveShoebox;
  int isBooked;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        floorId: json['floor_id'],
        roomTypeId: json['room_type_id'],
        sizeId: json['size_id'],
        name: json['name'],
        roomNo: json['room_no'],
        numOfBed: json['num_of_bed'],
        numOfBathroom: json['num_of_bathroom'],
        numOfLight: json['num_of_light'],
        numOfFan: json['num_of_fan'],
        haveAc: json['have_ac'],
        haveFridge: json['have_fridge'],
        haveBelcony: json['have_belcony'],
        haveAlmary: json['have_almary'],
        haveShoebox: json['have_shoebox'],
        isBooked: json['is_booked'],
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'floor_id': floorId,
        'room_type_id': roomTypeId,
        'size_id': sizeId,
        'name': name,
        'room_no': roomNo,
        'num_of_bed': numOfBed,
        'num_of_bathroom': numOfBathroom,
        'num_of_light': numOfLight,
        'num_of_fan': numOfFan,
        'have_ac': haveAc,
        'have_fridge': haveFridge,
        'have_belcony': haveBelcony,
        'have_almary': haveAlmary,
        'have_shoebox': haveShoebox,
        'is_booked': isBooked,
        'status': status,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
