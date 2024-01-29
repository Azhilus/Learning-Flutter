import 'package:flutter/material.dart';

class MyDesktopBody extends StatelessWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Center(
          child: Text('D E S K T O P'),
        ),
      ),
      body: Row(
        children: [
          // First Column
          Expanded(
            child: Column(
              children: [
                //youtube video
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 800),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.deepPurple[400],
                      ),
                    ),
                  ),
                ),

                //comment section
                Expanded(
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          height: 150,
                          color: Colors.deepPurple[300],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Second Column
          Container(
            width: 200,
            color: Colors.deepPurple[300],
          )
        ],
      ),
    );
  }
}
