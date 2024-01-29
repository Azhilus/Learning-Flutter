import 'package:flutter/material.dart';

class MyMobileBody extends StatelessWidget {
  const MyMobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
          title: const Center(
            child: Text('M O B I L E'),
          ),
        ),
        body: Column(
          children: [
            //youtube video
            Padding(
              padding: EdgeInsets.all(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  height: 250,
                  color: Colors.deepPurple[400],
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
        ));
  }
}
