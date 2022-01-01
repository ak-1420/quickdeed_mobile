import 'package:flutter/material.dart';

class RateWorker extends StatefulWidget {
  const RateWorker({Key? key}) : super(key: key);

  @override
  _RateWorkerState createState() => _RateWorkerState();
}

class _RateWorkerState extends State<RateWorker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
