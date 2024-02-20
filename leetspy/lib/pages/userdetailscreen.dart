import 'package:flutter/material.dart';
import 'package:leetspy/components/leetcodestats.dart';
import 'package:leetspy/components/skillstats.dart';
import '../components/userprofile.dart';
import '../components/badgeslist.dart';

class UserDetailScreen extends StatelessWidget {
  final String username;

  const UserDetailScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$username'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListView(
        children: [
          // Fetch user profile data here using GraphQL queries and display it
          UserProfileCard(username: username),
          BadgesList(username: username),
          LeetCodeStatsWidget(username: username),
          SkillStats(username: username),
        ],
      ),
    );
  }
}