import 'package:flutter/material.dart';
import 'package:flutter_lab1/controller/activity_service.dart';
import 'package:flutter_lab1/models/activity_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.activity})
      : super(key: key); // เปลี่ยนจาก product เป็น activity
  final ActivityModel activity; // เปลี่ยนจาก ProductModel เป็น ActivityModel

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late String activityName; // เปลี่ยนจาก productName เป็น activityName
  late String activityType; // เปลี่ยนจาก productType เป็น activityType
  late String room; // ราคา
  late String participants; // หน่วย

  @override
  void initState() {
    super.initState();
    activityName = widget
        .activity.activityName; // เปลี่ยนจาก productName เป็น activityName
    activityType = widget
        .activity.activityTime; // เปลี่ยนจาก productType เป็น activityType
    room = widget.activity.room; // ราคา
    participants = widget.activity.participants; // หน่วย
  }

  Future<void> _updateActivity() async {
    // เปลี่ยนจาก _updateProduct เป็น _updateActivity
    if (_formKey.currentState?.validate() ?? false) {
      final updatedActivity = ActivityModel(
        // เปลี่ยนจาก ProductModel เป็น ActivityModel
        id: widget.activity.id,
        activityName: activityName, // เปลี่ยนจาก productName เป็น activityName
        activityTime: activityType, // เปลี่ยนจาก productType เป็น activityType
        room: room, // ห้อง
        participants: room, // จำนวนที่รับ
      );

      final success = await ActivityService().updateActivity(updatedActivity,
          context); // เปลี่ยนจาก ProductService เป็น ActivityService
      if (success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Failed to update activity.'))); // เปลี่ยนจาก product เป็น activity
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Edit Activity"), // เปลี่ยนจาก Edit Product เป็น Edit Activity
        backgroundColor: const Color.fromARGB(255, 0, 110, 20),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed:
                _updateActivity, // เปลี่ยนจาก _updateProduct เป็น _updateActivity
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue:
                    activityName, // เปลี่ยนจาก productName เป็น activityName
                decoration: InputDecoration(
                  labelText:
                      "Activity Name", // เปลี่ยนจาก Product Name เป็น Activity Name
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => activityName =
                    value, // เปลี่ยนจาก productName เป็น activityName
                validator: (value) => value!.isEmpty
                    ? 'Please enter activity name'
                    : null, // เปลี่ยนจาก product name เป็น activity name
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue:
                    activityType, // เปลี่ยนจาก productType เป็น activityType
                decoration: InputDecoration(
                  labelText:
                      "Activity Time", // เปลี่ยนจาก Product Type เป็น Activity Type
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => activityType =
                    value, // เปลี่ยนจาก productType เป็น activityType
                validator: (value) => value!.isEmpty
                    ? 'Please enter activity time'
                    : null, // เปลี่ยนจาก product type เป็น activity type
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: room.toString(), // ราคา
                decoration: InputDecoration(
                  labelText: "Room", // ราคา
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => room = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter room' : null, // ราคา
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: participants, // หน่วย
                decoration: InputDecoration(
                  labelText: "Participants", // หน่วย
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => participants = value, // หน่วย
                validator: (value) => value!.isEmpty
                    ? 'Please enter participants'
                    : null, // หน่วย
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _updateActivity, // เปลี่ยนจาก _updateProduct เป็น _updateActivity
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 42, 208, 0),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Text(
                    "Update Activity", // เปลี่ยนจาก Update Product เป็น Update Activity
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
