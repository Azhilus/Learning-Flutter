import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SkillStats extends StatelessWidget {
  final String username;

  const SkillStats({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql('''
          query SkillStats(\$username: String!) {
            matchedUser(username: \$username) {
              tagProblemCounts {
                advanced {
                  tagName
                  tagSlug
                  problemsSolved
                }
                intermediate {
                  tagName
                  tagSlug
                  problemsSolved
                }
                fundamental {
                  tagName
                  tagSlug
                  problemsSolved
                }
              }
            }
          }
        '''),
        variables: {'username': username},
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (result.hasException) {
          return Text('Error fetching skill statistics');
        }

        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        final userData = result.data?['matchedUser'];
        if (userData == null) {
          return Text('User not found');
        }

        final tagProblemCounts = userData['tagProblemCounts'];

        // Combine all skills from different categories into one list
        List<dynamic> allSkills = [];
        allSkills.addAll(tagProblemCounts['fundamental']);
        allSkills.addAll(tagProblemCounts['intermediate']);
        allSkills.addAll(tagProblemCounts['advanced']);

        // Sort the combined skills based on the number of problems solved
        allSkills.sort((a, b) => b['problemsSolved'].compareTo(a['problemsSolved']));

        // Take the top 20 skills
        List<dynamic> topSkills = allSkills.take(20).toList();

        return Container(
          padding: EdgeInsets.all(20.0),// Add border radius to the container
          child: Wrap(
            spacing: 4.0, // Adjust the spacing between skill items
            runSpacing: 4.0, // Add spacing between rows of skills
            children: topSkills.map<Widget>((skill) {
              return Container(
                padding: EdgeInsets.symmetric(
                            vertical: 1.0,
                            horizontal: 10.0,
                          ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,// Add border to the container
                  borderRadius: BorderRadius.circular(30.0), // Add border radius to the container
                ),
                child: Text('${skill['tagName']}',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              
              );
            }).toList(),
          ),
        );
      },
    );
  }
}