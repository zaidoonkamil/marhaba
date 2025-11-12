import 'dart:convert';

List<PendingModel> pendingModelFromJson(String str) => List<PendingModel>.from(json.decode(str).map((x) => PendingModel.fromJson(x)));

String pendingModelToJson(List<PendingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingModel {
  int id;
  String title;
  List<String> images;
  String price;
  String desc;
  String province;
  String phone;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String type;

  PendingModel({
    required this.id,
    required this.title,
    required this.images,
    required this.price,
    required this.desc,
    required this.province,
    required this.phone,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory PendingModel.fromJson(Map<String, dynamic> json) => PendingModel(
    id: json["id"],
    title: json["title"],
    images: List<String>.from(json["images"].map((x) => x)),
    price: json["price"],
    desc: json["desc"],
    province: json["province"],
    phone: json["phone"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "images": List<dynamic>.from(images.map((x) => x)),
    "price": price,
    "desc": desc,
    "province": province,
    "phone": phone,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "type": type,
  };
}
