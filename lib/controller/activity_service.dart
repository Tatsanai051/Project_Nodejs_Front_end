import 'package:flutter/material.dart';
import 'package:flutter_lab1/providers/user_providers.dart';
import 'package:flutter_lab1/variables.dart';
import 'package:flutter_lab1/models/activity_model.dart'; // เปลี่ยนจาก product_model เป็น activity_model
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class ActivityService {
  Future<List<ActivityModel>> fetchActivities(BuildContext context) async {
    // เปลี่ยนชื่อฟังก์ชันจาก fetchProducts เป็น fetchActivities
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.get(
        Uri.parse(
            '$apiURL/api/activities'), // เปลี่ยนจาก /api/products เป็น /api/activities
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((activity) => ActivityModel.fromJson(
                activity)) // เปลี่ยนจาก ProductModel เป็น ActivityModel
            .toList();
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception(
            'Failed to load activities: ${response.statusCode}'); // เปลี่ยนจาก products เป็น activities
      }
    } catch (e) {
      print('Caught error: $e');
      throw Exception(
          'Failed to load activities: $e'); // เปลี่ยนจาก products เป็น activities
    }
  }

  Future<bool> addActivity(BuildContext context, ActivityModel activity) async {
    // เปลี่ยนจาก addProduct เป็น addActivity
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.post(
        Uri.parse(
            '$apiURL/api/activity'), // เปลี่ยนจาก /api/product เป็น /api/activity
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
        body: jsonEncode(activity.toJson()), // เปลี่ยนจาก product เป็น activity
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print(
            'Failed to add activity: ${response.body}'); // เปลี่ยนจาก product เป็น activity
        return false;
      }
    } catch (e) {
      print('Error adding activity: $e'); // เปลี่ยนจาก product เป็น activity
      return false;
    }
  }

  Future<bool> deleteActivity(BuildContext context, String activityId) async {
    // เปลี่ยนจาก deleteProduct เป็น deleteActivity
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.delete(
        Uri.parse(
            '$apiURL/api/activity/$activityId'), // เปลี่ยนจาก /api/product/$productId เป็น /api/activity/$activityId
        headers: <String, String>{
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Failed to delete activity: ${response.body}'); // เปลี่ยนจาก product เป็น activity
        return false;
      }
    } catch (e) {
      print('Error deleting activity: $e'); // เปลี่ยนจาก product เป็น activity
      return false;
    }
  }

  Future<bool> updateActivity(
      ActivityModel activity, BuildContext context) async {
    // เปลี่ยนจาก updateProduct เป็น updateActivity
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final response = await http.put(
        Uri.parse(
            '$apiURL/api/activity/${activity.id}'), // เปลี่ยนจาก /api/product/${product.id} เป็น /api/activity/${activity.id}
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
        body: jsonEncode(activity.toJson()), // เปลี่ยนจาก product เป็น activity
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Failed to update activity: ${response.body}'); // เปลี่ยนจาก product เป็น activity
        return false;
      }
    } catch (e) {
      print('Error updating activity: $e'); // เปลี่ยนจาก product เป็น activity
      return false;
    }
  }
}
