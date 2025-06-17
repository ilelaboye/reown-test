import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:reown_test/core/extensions.dart';
import 'package:reown_test/viewmodels/auth.dart';
import 'package:reown_test/viewmodels/users.dart';
import 'package:reown_test/views/dashboard/chat.dart';

class Chats extends StatefulWidget {
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUsers();
    });
  }

  void getUsers() async {
    final userVm = Provider.of<UsersViewModel>(context, listen: false);
    final authVm = Provider.of<AuthViewModel>(context, listen: false).user;

    try {
      EasyLoading.show(status: 'Loading...');
      final resp = await userVm.getUsers(authVm.email);
      EasyLoading.dismiss();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red[400], content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersViewModel>(context).users;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Chats',
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFFF2C87D),
                        child: Text(
                          '${user.name[0]}${user.name[1]}'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ).onTap(() => context.push(Chat(
                        user: user,
                      )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
