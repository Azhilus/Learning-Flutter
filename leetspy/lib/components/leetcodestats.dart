import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LeetCodeStatsWidget extends StatelessWidget {
  final String username;

  const LeetCodeStatsWidget({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Query(
          options: QueryOptions(
            document: gql('''
              query userProblemsSolved(\$username: String!) {
                allQuestionsCount {
                  difficulty
                  count
                }
                matchedUser(username: \$username) {
                  problemsSolvedBeatsStats {
                    difficulty
                    percentage
                  }
                  submitStatsGlobal {
                    acSubmissionNum {
                      difficulty
                      count
                    }
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

            final allQuestionsCount = result.data?['allQuestionsCount'];
            final matchedUser = result.data?['matchedUser'];

            if (allQuestionsCount == null || matchedUser == null) {
              return Text('Data not available');
            }

            final submitStatsGlobal = matchedUser['submitStatsGlobal']['acSubmissionNum'];

            return Column(
              children: [
                _buildOverallProgress(allQuestionsCount, submitStatsGlobal),
                SizedBox(height: 16),
                _buildDifficultyProgress(matchedUser),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverallProgress(List<dynamic> allQuestionsCount, List<dynamic> submitStatsGlobal) {
    final totalProblems = allQuestionsCount
        .where((item) => item['difficulty'] != 'All')
        .map<int>((item) => item['count'] as int)
        .fold(0, (prev, count) => prev + count);

    final acSubmissionAll = submitStatsGlobal
        .firstWhere((item) => item['difficulty'] == 'All')['count'] as int;

    final percentage = totalProblems != 0 ? (acSubmissionAll / totalProblems) * 100 : 0.0;

    final solvedCount = acSubmissionAll;

    return Column(
      children: [
        SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CustomPaint(
                painter: CircleProgressBar(percentage),
                child: Center(
                  child: Text(
                    '$solvedCount / $totalProblems',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDifficultyProgress(Map<String, dynamic> matchedUser) {
    final difficulties = ['Easy', 'Medium', 'Hard'];
    final submitStatsGlobal = matchedUser['submitStatsGlobal']['acSubmissionNum'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var difficulty in difficulties)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('$difficulty:'),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: _calculatePercentage(submitStatsGlobal, difficulty),
                    backgroundColor: Color.fromARGB(255, 74, 74, 74),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getColorForDifficulty(difficulty),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  double _calculatePercentage(List<dynamic> submitStatsGlobal, String difficulty) {
    final acSubmission = submitStatsGlobal.firstWhere((item) => item['difficulty'] == difficulty);
    final total = submitStatsGlobal.firstWhere((item) => item['difficulty'] == 'All')['count'] as int;

    return total != 0 ? (acSubmission['count'] as int) / total : 0.0;
  }

  Color _getColorForDifficulty(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Color.fromARGB(255, 0, 184, 163);
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return Color.fromARGB(255, 74, 74, 74);
    }
  }
}

class CircleProgressBar extends CustomPainter {
  final double percentage;

  CircleProgressBar(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 10.0;

    final progressPaint = Paint()
      ..color = Color.fromARGB(255, 255, 161, 22)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final backgroundPaint = Paint()
      ..color = Color.fromARGB(255, 74, 74, 74)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 360 * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.14 / 180),
      sweepAngle * (3.14 / 180),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}