import 'package:flutter/material.dart';
import 'package:reown_test/views/dashboard/chat.dart';
import 'package:reown_test/views/dashboard/chats.dart';
import 'package:reown_test/views/dashboard/profile.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> tabs = [Chats(), Profile()];

  int currentTab = 0;

  void changeTab(int index) => setState(() => currentTab = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        selectedItemColor: Color(0xFFF2C87D),
        unselectedItemColor: Colors.grey,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
