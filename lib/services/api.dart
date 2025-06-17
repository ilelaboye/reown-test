import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reown_test/core/constant.dart';
import '../models/user.dart';

class ApiService {
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/data.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        var error = jsonDecode(response.body);
        throw error['error'];
      }
    } catch (error) {
      throw error;
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}/data.json?orderBy=${Uri.encodeComponent("\"email\"")}&equalTo=${Uri.encodeComponent("\"$email\"")}',
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data == null || data.isEmpty) {
          throw 'Invalid email and password';
        }
        var userMap;

        for (var entry in data.entries) {
          if (entry.value['password'] == password) {
            userMap = {
              "id": entry.key,
              "name": entry.value['name'],
              "email": entry.value['email'],
            };
            break;
          }
        }
        if (userMap == null || userMap.isEmpty) {
          throw 'Invalid email and password';
        }
        return User.fromJson(userMap);
      } else {
        var error = jsonDecode(response.body);
        throw error['error'];
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<User>> getUsers(String email) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}/data.json',
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<User> users = [];
        final data = jsonDecode(response.body);
        for (var entry in data.entries) {
          if (entry.value['email'] != email) {
            var userMap = User(
              id: entry.key,
              name: entry.value['name'],
              email: entry.value['email'],
            );
            users.add(userMap);
          }
        }
        return users;
      } else {
        var error = jsonDecode(response.body);
        throw error['error'];
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> getChats(
      String senderId, String receiverId) async {
    try {
      List<Map<String, dynamic>> chats = [];
      final response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}/chats.json',
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        for (var entry in data.entries) {
          if ((entry.value['senderId'] == senderId &&
                  entry.value['receiverId'] == receiverId) ||
              (entry.value['senderId'] == receiverId &&
                  entry.value['receiverId'] == senderId)) {
            var chat = {
              'id': entry.key,
              'senderId': entry.value['senderId'],
              'receiverId': entry.value['receiverId'],
              'message': entry.value['message'],
            };
            chats.add(chat);
          }
        }
        return chats;
      } else {
        var error = jsonDecode(response.body);
        throw error['error'];
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> saveChat(
      String senderId, String receiverId, String message) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/chats.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'senderId': senderId,
          'receiverId': receiverId,
          'message': message,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        var error = jsonDecode(response.body);
        throw error['error'];
      }
    } catch (error) {
      throw error;
    }
  }
}
