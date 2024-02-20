import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserProfileCard extends StatelessWidget {
  final String username;

  const UserProfileCard({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Query(
          options: QueryOptions(
            document: gql('''
              query GetUserProfile(\$username: String!) {
                matchedUser(username: \$username) {
                  username
                  profile {
                    ranking
                    userAvatar
                    realName
                    aboutMe
                    school
                    websites
                    countryName
                    company
                    jobTitle
                    skillTags
                    postViewCount
                    postViewCountDiff
                    reputation
                    reputationDiff
                    solutionCount
                    solutionCountDiff
                    categoryDiscussCount
                    categoryDiscussCountDiff
                  }
                  languageProblemCount {
                    languageName
                    problemsSolved
                  }
                }
              }
            '''),
            variables: {'username': username},
          ),
          builder: (QueryResult result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Text('Error fetching data');
            }

            if (result.isLoading) {
              return CircularProgressIndicator();
            }

            final userData = result.data?['matchedUser'];
            if (userData == null) {
              return Text('User not found');
            }

            final profileData = userData['profile'];
            final userAvatarUrl = profileData['userAvatar'];
            final List<Map<String, dynamic>> languageStats = List<Map<String, dynamic>>.from(userData['languageProblemCount']);
            
            // Sort the languageStats based on problems solved in descending order
            languageStats.sort((a, b) => b['problemsSolved'].compareTo(a['problemsSolved']));
            
            // Take the top 3 languages
            final top3Languages = languageStats.take(3);

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (userAvatarUrl != null)
                  Image.network(
                    userAvatarUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                SizedBox(width: 16), // Add spacing between image and text
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${profileData['realName'] ?? 'N/A'}'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text('Ranking: ${profileData['ranking'] ?? 'N/A'}'),
                      Text('Location: ${profileData['countryName'] ?? 'N/A'}'),
                      SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: top3Languages.map<Widget>((stats) {
                          return Container(
                            margin: EdgeInsets.only(right: 4.0),
                            padding: EdgeInsets.symmetric(
                          vertical: 1.0,
                          horizontal: 10.0,
                        ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,// Add border to the container
                            borderRadius: BorderRadius.circular(30.0), // Add border radius to the container
                          ),
                            child: Text(
                              '${stats['languageName']}',
                            ),
                          );
                        }).toList(),
                      ),
                      // Add more user information here
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
