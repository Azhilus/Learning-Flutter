import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '/pages/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://leetcode.com/graphql/',
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'LeetSpy',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            background: Colors.black,
            primary: Colors.grey.shade700,
            secondary: Colors.black,
            inversePrimary: Colors.grey.shade200,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}