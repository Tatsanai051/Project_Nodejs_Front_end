import 'package:flutter/material.dart';
import 'package:flutter_lab1/controller/auth_service.dart';
import 'package:flutter_lab1/controller/activity_service.dart';
import 'package:flutter_lab1/pages/addpage.dart';
import 'package:flutter_lab1/pages/editpage.dart';
import 'package:flutter_lab1/providers/user_providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_lab1/models/activity_model.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<List<ActivityModel>>?
      futureActivities; // เปลี่ยนจาก ProductModel เป็น ActivityModel

  @override
  void initState() {
    super.initState();
    futureActivities = ActivityService().fetchActivities(
        context); // เปลี่ยนจาก ProductService เป็น ActivityService
  }

  void refreshActivities() {
    setState(() {
      futureActivities = ActivityService().fetchActivities(
          context); // เปลี่ยนจาก ProductService เป็น ActivityService
    });
  }

  void _logout() async {
    try {
      await AuthService().logout(context);
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Admin Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 110, 20),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Activities', // เปลี่ยนจาก Products เป็น Activities
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPage()),
                      );
                      if (result == true) {
                        refreshActivities(); // เปลี่ยนจาก refreshProducts เป็น refreshActivities
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Add Activity',
                        style: TextStyle(
                            color: Colors
                                .white)), // เปลี่ยนจาก Add Product เป็น Add Activity
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 42, 208, 0),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                FutureBuilder<List<ActivityModel>>(
                  // เปลี่ยนจาก ProductModel เป็น ActivityModel
                  future: futureActivities,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                              'No activities available.')); // เปลี่ยนจาก No products เป็น No activities
                    }

                    final activities = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15.0),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ID: ${activities[index].id}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Text(
                                      'Name: ${activities[index].activityName}', // เปลี่ยนจาก productName เป็น activityName
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5),
                                  Text(
                                      'Time: ${activities[index].activityTime}', // เปลี่ยนจาก productType เป็น activityType
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5),
                                  Text(
                                      'Room: ${activities[index].room}', // ราคา
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5),
                                  Text(
                                      'Participants: ${activities[index].participants}', // หน่วย
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: const Color.fromARGB(
                                                255, 238, 251, 0)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditPage(
                                                  // ใช้ EditPage สำหรับกิจกรรม
                                                  activity: activities[
                                                      index]), // เปลี่ยนจาก product เป็น activity
                                            ),
                                          ).then((value) {
                                            if (value == true) {
                                              refreshActivities(); // เปลี่ยนจาก refreshProducts เป็น refreshActivities
                                            }
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Confirm Delete"),
                                                content: Text(
                                                    "Are you sure you want to delete this activity?"), // เปลี่ยนจาก product เป็น activity
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // ปิด dialog
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text("Delete"),
                                                    onPressed: () async {
                                                      final isDeleted =
                                                          await ActivityService() // เปลี่ยนจาก ProductService เป็น ActivityService
                                                              .deleteActivity(
                                                                  context,
                                                                  activities[
                                                                          // เปลี่ยนจาก products เป็น activities
                                                                          index]
                                                                      .id);
                                                      if (isDeleted) {
                                                        refreshActivities(); // เปลี่ยนจาก refreshProducts เป็น refreshActivities
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Activity deleted successfully')), // เปลี่ยนจาก Product เป็น Activity
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Failed to delete activity')), // เปลี่ยนจาก Product เป็น Activity
                                                        );
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
