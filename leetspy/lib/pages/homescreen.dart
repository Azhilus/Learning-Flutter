import 'package:flutter/material.dart';
import 'userdetailscreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        title: Center(child: Text('LeetSpy', style: TextStyle(fontWeight: FontWeight.w900),),),
        
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBar(
                onSubmitted: (String username) {
                  // You can now execute GraphQL queries here based on the entered username
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(username: username),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
