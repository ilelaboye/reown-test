import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:reown_test/core/extensions.dart';
import 'package:reown_test/models/user.dart';
import 'package:reown_test/viewmodels/auth.dart';
import 'package:reown_test/viewmodels/users.dart';

class Chat extends StatefulWidget {
  final User user;
  Chat({super.key, required this.user});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getChats(loader: true);
      _startPeriodicTask();
    });
  }

  final _form = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String message = "";
  Timer? _timer;

  void saveChat() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      final userVm = Provider.of<UsersViewModel>(context, listen: false);
      final authVm = Provider.of<AuthViewModel>(context, listen: false).user;
      try {
        final resp = await userVm.saveChat(authVm.id, widget.user.id, message);
        _controller.clear();
        if (resp) {
          message = '';
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red[400], content: Text('Error: $e')),
        );
      }
    }
  }

  void getChats({loader = false}) async {
    final userVm = Provider.of<UsersViewModel>(context, listen: false);
    final authVm = Provider.of<AuthViewModel>(context, listen: false).user;

    try {
      if (loader) {
        EasyLoading.show(status: 'loading...');
      }
      final resp = await userVm.getChats(authVm.id, widget.user.id);
      if (loader) {
        EasyLoading.dismiss();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red[400], content: Text('Error: $e')),
      );
      EasyLoading.dismiss();
    }
  }

  void _startPeriodicTask() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getChats();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<UsersViewModel>(context).chats;
    final user = Provider.of<AuthViewModel>(context, listen: false).user;

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFF2C87D),
                    radius: 24,
                    child: Text(
                      '${widget.user.name[0]}${widget.user.name[1]}'
                          .toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    widget.user.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),

            // Chat messages
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final message = chats[index];
                  final isMe = message['senderId'] == user.id ? true : false;
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        color: isMe ? Color(0xFFD9A326) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['message'],
                        style: TextStyle(
                          fontSize: 16,
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Form(
              key: _form,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: _controller,
                          maxLines: 3,
                          minLines: 1,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            hintText: 'Hmm....',
                            hintStyle: TextStyle(
                              color: Color(0xFFD9A326),
                              fontSize: 13,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          cursorColor: Color(0xFFD9A326),
                          cursorHeight: 15,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "";
                            }
                          },
                          onSaved: (value) => message = value!),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color(0xFFF2F2F2),
                      radius: 22,
                      child: Icon(
                        Icons.send,
                        color: Color(0xFFD9A326),
                      ),
                    ).onTap(() => {saveChat()}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
