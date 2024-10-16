import 'dart:convert';

ActivityModel activityModelFromJson(String str) =>
    ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel {
  String id;
  String activityName; // เปลี่ยนจาก productName เป็น activityName
  String activityTime; // เปลี่ยนจาก productType เป็น activityType
  String room;
  String participants;

  ActivityModel({
    required this.id,
    required this.activityName, // เปลี่ยนจาก productName เป็น activityName
    required this.activityTime, // เปลี่ยนจาก productType เป็น activityType
    required this.room,
    required this.participants,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json["_id"] ?? 'unknown_id', // ถ้าค่า id เป็น null จะใช้ค่าเริ่มต้น
        activityName: json["activity_name"] ??
            'Unnamed Activity', // เปลี่ยนจาก productName เป็น activityName
        activityTime: json["activity_time"] ??
            'Unknown Time', // เปลี่ยนจาก productType เป็น activityType
        room: json["room"] ??
            'Unknown room', // ถ้าค่า price เป็น null จะให้ค่าเป็น 0
        participants: json["participants"] ??
            'Unknown participants', // ถ้าค่า unit เป็น null จะใช้ค่าเริ่มต้น
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "activity_name":
            activityName, // เปลี่ยนจาก productName เป็น activityName
        "activity_time":
            activityTime, // เปลี่ยนจาก productType เป็น activityType
        "room": room,
        "participants": participants,
      };
}
