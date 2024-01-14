import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {
  final String emoticonFace;
  final String mood;

  const EmoticonFace({
    Key? key,
    required this.emoticonFace,
    required this.mood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(17.5),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              emoticonFace,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            mood,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
