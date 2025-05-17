import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserServices {

  static Future<List<Map<String, dynamic>>> fetchUserDetails() async {
    List<Map<String, dynamic>> userList_Table = [];
    final response = await http
        .get(Uri.parse('http://147.93.97.78:5030/user_with_other_details_by_role/user/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      userList_Table = data.map((user) {
      return {
        "No": user['user']['id'],
        "Name": {
        "name": user['user']['name'],
        "profilePictures": user['user']['profile_image']
        },
        'Phone': user['user']['contact_number'],
        'Pin Code': 
          user['addresses'] != null && user['addresses'].isNotEmpty 
          ? user['addresses'][0]['postal_code'] 
          : '', 
        "Status": user['user']['active_status'].toString().replaceFirstMapped(
          RegExp(r'^\w'), (match) => match.group(0)!.toUpperCase()),
        "Action": 

         [
  {
    'label': 'View/Edit',
    'icon': Icons.edit,
    'onPressed': () {
      print('Edit button pressed');
    },
  },
  {
    'label': 'Delete',
    'icon': Icons.delete,
    'onPressed': () {
      print('Delete button pressed');
    },
  }
]
      };
      }).toList();

      // Sort the userList_Table by 'No' (user['user']['id'])
      userList_Table.sort((a, b) => a["No"].compareTo(b["No"]));
    } else {
      throw Exception('Failed to load user details');
    }

    return [
      {
        "header": ['No', 'Name', 'Phone', 'Pin Code', 'Status', 'Action'],
        "dataType": [
          "Text",
          "UserNameWithProfile",
          "Text",
          "Text",
          "Status",
          "Action"
        ],
        "data": userList_Table
      }
    ];
  }


  static Future<List<Map<String, dynamic>>> fetchUsersCount() async {
    List<Map<String, dynamic>> userlistTable = [];
    final response = await http
        .get(Uri.parse('http://147.93.97.78:5030/users_with_other_details/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      userlistTable = data.map((user) {
        return {
          'role': user['user']['role'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load user details');
    }

    return [
      {
        "data": userlistTable
      }
    ];
  }

  Future<void> createUser(
      String email, String password, Map<String, dynamic> userData) async {
    //name is not required
    //number too not required
    //profile img
    int role = 1; //Default role
    String url = "http://147.93.97.78:5060/users/";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
          "role": role,
          "created_by": "admin"
        },
      );

      if (response.statusCode == 201) {
        userData = jsonDecode(response.body);
      } else {
        print("error at response");
        //handle error statements
      }

      if (response.statusCode != 201) {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print("this error happening in create user $e");
    }
  }

  Future<void> loginUser(String email, String password, int userID) async {
    String url = "http://147.93.97.78:5060/users/login/";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);

        if (temp["message"] == "Login successful." && temp["user_id"] != null) {
          userID = temp["user_id"];
        } else {
          print("error at respone body");
        }
      } else {
        print("error at response");
        //handle error statements
      }

      if (response.statusCode != 201) {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print("Error happening in login uer $e");
    }
  }

  Future<void> fetchUserById(int userID) async {
    String url = "http://147.93.97.78:5060/users/$userID/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        return userData;
      } else {
        print("Error fetching user by ID. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching user by ID: $e");
    }
  }

  Future<void> fetchUserByEmail(String email) async {
    String url = "http://147.93.97.78:5060/users/email/$email/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        return userData;
      } else {
        print(
            "Error fetching user by email. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching user by email: $e");
    }
  }
}
