import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../models/user.dart';
import '../repositories/auth.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool isLoading = false;
  late User user;

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;

    notifyListeners();
    try {
      bool resp = await _authRepository.register(name, email, password);
      return resp;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      user = await _authRepository.login(email, password);
      localStorage.setItem(
          'reown',
          jsonEncode(
              {'userId': user.id, 'name': user.name, 'email': user.email}));
      return user;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> getUser() async {
    isLoading = true;
    notifyListeners();
    try {
      var hd = await localStorage.getItem('reown');
      if (hd!.isNotEmpty) {
        var dt = jsonDecode(hd!);
        user = User(email: dt['email'], id: dt['userId'], name: dt['name']);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  logout() {
    localStorage.setItem('reown', '');
  }
}
