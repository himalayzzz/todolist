import 'package:flutter/material.dart';
import 'package:todo_project/presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    waitSplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(26, 201, 223, 102),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
        Image.network('https://tamilnaducouncil.ac.in/wp-content/uploads/2018/10/loading-gif.gif', fit: BoxFit.cover, height: 100),
        Text('Loading', 
        style: TextStyle(fontSize: 32,
        color: const Color.fromARGB(255, 206, 71, 116)),),
        ]
      )
      )
    );
  }
  waitSplash() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}