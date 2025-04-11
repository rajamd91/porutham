import 'package:flutter/material.dart';

import '../../../personalization/screens/profile/update_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Matches'),
                Tab(text: 'By Location'),
                Tab(text: 'By Education'),
                Tab(text: 'By Career'),
              ],
            ),
            title: const Text('Matches'),
          ),
          body: TabBarView(
            children: [
              const UpdateProfileScreen(),
              Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('Location',
                      style: TextStyle(color: Colors.white, fontSize: 50)),
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(
                  child: Text('Education',
                      style: TextStyle(color: Colors.white, fontSize: 50)),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Center(
                  child: Text('Career',
                      style: TextStyle(color: Colors.white, fontSize: 50)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
