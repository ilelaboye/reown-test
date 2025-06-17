import 'package:reown_test/models/user.dart';

import '../services/api.dart';

class AuthRepository {
  final ApiService apiService = ApiService();

  Future<bool> register(String name, String email, String password) {
    return apiService.register(name, email, password);
  }

  Future<User> login(String email, String password) {
    return apiService.login(email, password);
  }

  Future<List<User>> getUsers(String email) {
    return apiService.getUsers(email);
  }

  Future<bool> saveChat(String senderId, String receiverId, String message) {
    return apiService.saveChat(senderId, receiverId, message);
  }

  Future<List<Map<String, dynamic>>> getChats(
    String senderId,
    String receiverId,
  ) {
    return apiService.getChats(senderId, receiverId);
  }
}
