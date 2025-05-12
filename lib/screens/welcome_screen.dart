import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/welcomepageimage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Colmn(
          children:[
            Text("Define\n yourself in \n your uniqueway."),
            spacer(),
            
          ]
        )
      ),
    
    );
  }
}
