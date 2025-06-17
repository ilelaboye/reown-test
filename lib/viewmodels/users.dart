import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/auth.dart';

class UsersViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool isLoading = false;
  List<User> users = [];
  List<Map<String, dynamic>> chats = [];

  Future<List<User>> getUsers(String email) async {
    isLoading = true;
    notifyListeners();
    try {
      users = await _authRepository.getUsers(email);
      return users;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveChat(
      String senderId, String receiverId, String message) async {
    isLoading = true;
    notifyListeners();
    try {
      chats.add({
        "id": 'oe22ene',
        "senderId": senderId,
        "receiverId": receiverId,
        "message": message
      });

      var resp = await _authRepository.saveChat(senderId, receiverId, message);

      return resp;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Map<String, dynamic>>> getChats(
      String senderId, String receiverId) async {
    isLoading = true;
    notifyListeners();
    try {
      chats = await _authRepository.getChats(senderId, receiverId);

      return chats;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
