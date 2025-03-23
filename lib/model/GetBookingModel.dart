// To parse this JSON data, do
//
//     final getBooking = getBookingFromJson(jsonString);

import 'dart:convert';

List<GetBooking> getBookingFromJson(String str) => List<GetBooking>.from(json.decode(str).map((x) => GetBooking.fromJson(x)));

String getBookingToJson(List<GetBooking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBooking {
  int id;
  String title;
  List<String> images;
  String price;
  String desc;
  String province;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;

  GetBooking({
    required this.id,
    required this.title,
    required this.images,
    required this.price,
    required this.desc,
    required this.province,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetBooking.fromJson(Map<String, dynamic> json) => GetBooking(
    id: json["id"],
    title: json["title"],
    images: List<String>.from(json["images"].map((x) => x)),
    price: json["price"],
    desc: json["desc"],
    province: json["province"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "images": List<dynamic>.from(images.map((x) => x)),
    "price": price,
    "desc": desc,
    "province": province,
    "phone": phone,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
