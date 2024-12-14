import 'dart:async';

import 'package:danilee/shared/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/loading.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              Constants.appLogo,
              width: MediaQuery.of(context).size.width / 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Timer startTime() {
    const Duration duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  Future<void> route() async {
    await Navigator.pushReplacementNamed(context, '/login');
  }
}
