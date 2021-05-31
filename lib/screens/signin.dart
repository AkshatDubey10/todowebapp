import 'package:flutter/material.dart';
import 'package:todowebapp/services/auth.dart';
import 'package:todowebapp/widgets/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().mainAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/todos.png',
              height: 300,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'ToDoApp For Awesome People',
              style: TextStyle(fontSize: 17.0),
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                authService.signInWithGoogle(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFF5964),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Sign In With Google',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
