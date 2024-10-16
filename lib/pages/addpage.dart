import 'package:flutter/material.dart';
import 'package:flutter_lab1/controller/activity_service.dart';
import 'package:flutter_lab1/models/activity_model.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String? activityName; // เปลี่ยนจาก productName เป็น activityName
  String? activityType; // เปลี่ยนจาก productType เป็น activityType
  String? room;
  String? participants;

  void addActivity() async {
    // เปลี่ยนจาก addProduct เป็น addActivity
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ActivityModel newActivity = ActivityModel(
        // เปลี่ยนจาก ProductModel เป็น ActivityModel
        id: '',
        activityName: activityName!, // เปลี่ยนจาก productName เป็น activityName
        activityTime: activityType!, // เปลี่ยนจาก productType เป็น activityType
        room: room!,
        participants: participants!,
      );

      final response = await ActivityService().addActivity(context,
          newActivity); // เปลี่ยนจาก ProductService เป็น ActivityService
      if (response) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to add activity')), // เปลี่ยนข้อความจาก product เป็น activity
        );
        Navigator.pop(context, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'), // เปลี่ยนจาก Add Product เป็น Add Activity
        backgroundColor: const Color.fromARGB(255, 0, 110, 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add a New Activity', // เปลี่ยนจาก Product เป็น Activity
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText:
                        'Activity Name', // เปลี่ยนจาก Product Name เป็น Activity Name
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter an activity name'
                      : null, // เปลี่ยนจาก product name เป็น activity name
                  onSaved: (value) => activityName =
                      value, // เปลี่ยนจาก productName เป็น activityName
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText:
                        'Activity Time', // เปลี่ยนจาก Product Type เป็น Activity Type
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter an activity of time'
                      : null, // เปลี่ยนจาก product type เป็น activity type
                  onSaved: (value) => activityType =
                      value, // เปลี่ยนจาก productType เป็น activityType
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Room',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a room' : null,
                  onSaved: (value) => room = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Participants',
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a participants' : null,
                  onSaved: (value) => participants = value,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed:
                        addActivity, // เปลี่ยนจาก addProduct เป็น addActivity
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      backgroundColor: const Color.fromARGB(255, 42, 208, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Add Activity', // เปลี่ยนจาก Add Product เป็น Add Activity
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
