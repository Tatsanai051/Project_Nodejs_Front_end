import 'package:flutter/material.dart';
import 'package:flutter_lab1/controller/auth_service.dart';
import 'package:flutter_lab1/controller/activity_service.dart';
import 'package:flutter_lab1/providers/user_providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_lab1/models/activity_model.dart';

class UserWelcomePage extends StatefulWidget {
  const UserWelcomePage({super.key});

  @override
  _UserWelcomePage createState() => _UserWelcomePage();
}

class _UserWelcomePage extends State<UserWelcomePage> {
  late Future<List<ActivityModel>>?
      futureActivities; // เปลี่ยนจาก ProductModel เป็น ActivityModel

  @override
  void initState() {
    super.initState();
    futureActivities = ActivityService().fetchActivities(
        context); // เปลี่ยนจาก fetchProducts เป็น fetchActivities
  }

  void refreshActivities() {
    setState(() {
      futureActivities = ActivityService().fetchActivities(
          context); // เปลี่ยนจาก fetchProducts เป็น fetchActivities
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
          "User Page",
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
      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
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
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15.0),
              FutureBuilder<List<ActivityModel>>(
                // เปลี่ยนจาก ProductModel เป็น ActivityModel
                future:
                    futureActivities, // เปลี่ยนจาก futureProducts เป็น futureActivities
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

                  final activities =
                      snapshot.data!; // เปลี่ยนจาก products เป็น activities
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${activities[index].id}', // เปลี่ยนจาก products เป็น activities
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Name: ${activities[index].activityName}', // เปลี่ยนจาก productName เป็น activityName
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Time: ${activities[index].activityTime}', // เปลี่ยนจาก productType เป็น activityType
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Room: ${activities[index].room}', // ราคา
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Participants: ${activities[index].participants}', // หน่วย
                                  style: TextStyle(fontSize: 18),
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
      }),
    );
  }
}
