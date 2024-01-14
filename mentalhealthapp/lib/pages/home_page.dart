import 'package:flutter/material.dart';
import 'package:mentalhealthapp/util/emoticon_face.dart';
import 'package:mentalhealthapp/util/emoticon_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Column(
                children: [
                  //greetings row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Hi John
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi, John!',
                              style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            '08 Jan, 2024',
                            style: TextStyle(
                              color: Colors.blue[200],
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      //Notification
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.notifications, color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  //search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text('Search',
                              style: TextStyle(
                                color: Colors.blue[200],
                                fontSize: 16,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),

                  //how do you feel?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('How do you feel?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      )
                    ],
                  ),

                  SizedBox(height: 20),

                  //mood cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 5),
                      //bad
                      EmoticonFace(
                        emoticonFace: '😞',
                        mood: 'Bad',
                      ),
                      //fine
                      EmoticonFace(
                        emoticonFace: '😐',
                        mood: 'Fine',
                      ),
                      //good
                      EmoticonFace(
                        emoticonFace: '😊',
                        mood: 'Good',
                      ),
                      //excellent
                      EmoticonFace(emoticonFace: '🥳', mood: 'Excellent'),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(25.0), // Adjust the radius as needed
                    topRight:
                        Radius.circular(25.0), // Adjust the radius as needed
                  ),
                ),
                child: Center(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercises',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Icon(Icons.more_horiz)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // listview of exrcises
                    Expanded(
                        child: ListView(
                      children: [
                        ExerciseTile(
                          title: 'Listening Skills',
                          subtitle: '10 Exercises',
                          icon: Icons.headset,
                          iconColor: Colors.blue,
                        ),
                        ExerciseTile(
                          title: 'Reading Comprehension',
                          subtitle: '20 Exercises',
                          icon: Icons.book,
                          iconColor: Colors.green,
                        ),
                        ExerciseTile(
                          title: 'Math Challenges',
                          subtitle: '15 Exercises',
                          icon: Icons.calculate,
                          iconColor: Colors.red,
                        ),
                        ExerciseTile(
                          title: 'Coding Practice',
                          subtitle: '30 Challenges',
                          icon: Icons.code,
                          iconColor: Colors.purple,
                        ),
                        ExerciseTile(
                          title: 'Healthy Habits',
                          subtitle: '5 Practices',
                          icon: Icons.local_florist,
                          iconColor: Colors.teal,
                        ),
                        ExerciseTile(
                          title: 'Mindfulness Meditation',
                          subtitle: '12 Sessions',
                          icon: Icons.spa,
                          iconColor: Colors.deepOrange,
                        ),
                        ExerciseTile(
                          title: 'Problem Solving',
                          subtitle: '25 Challenges',
                          icon: Icons.lightbulb_outline,
                          iconColor: Colors.amber,
                        ),
                        ExerciseTile(
                          title: 'Physical Activity',
                          subtitle: 'Daily Workout',
                          icon: Icons.directions_run,
                          iconColor: Colors.indigo,
                        ),
                        ExerciseTile(
                          title: 'Creative Writing',
                          subtitle: '10 Prompts',
                          icon: Icons.edit,
                          iconColor: Colors.deepPurple,
                        ),
                        ExerciseTile(
                          title: 'Language Learning',
                          subtitle: 'Vocabulary Practice',
                          icon: Icons.language,
                          iconColor: Colors.cyan,
                        ),
                      ],
                    ))
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
