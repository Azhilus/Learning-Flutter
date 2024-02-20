import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BadgesList extends StatelessWidget {
  final String username;

  const BadgesList({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql('''
          query GetUserBadges(\$username: String!) {
            matchedUser(username: \$username) {
              badges {
                id
                name
                shortName
                displayName
                icon
                hoverText
                creationDate
                category
              }
            }
          }
        '''),
        variables: {'username': username},
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (result.hasException) {
          return Text('Error fetching badges data');
        }

        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        final userData = result.data?['matchedUser'];
        if (userData == null) {
          return Text('User not found');
        }

        final badges = userData['badges'] as List<dynamic>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: badges.map<Widget>((badge) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(
                      badge['icon'].startsWith('/') ? 'https://leetcode.com${badge['icon']}' : badge['icon'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
