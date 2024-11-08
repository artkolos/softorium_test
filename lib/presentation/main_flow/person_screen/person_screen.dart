import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Person screen!'),
      ),
    );
  }
}
