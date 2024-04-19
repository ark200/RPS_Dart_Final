import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'signup.dart'; // Import the signup page widget
import 'database_helper.dart'; // Import the database helper file

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime? _lastPressedTime;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void _login() async {
      String username = usernameController.text;
      String password = passwordController.text;

      List<Map<String, dynamic>> result = await DatabaseHelper().getUser(username, password);

      if (result.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        // Invalid credentials, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    }

    void _navigateToSignup() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupScreen(), // Replace SignupPage() with your actual signup page widget
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedTime == null ||
            DateTime.now().difference(_lastPressedTime!) > Duration(seconds: 2)) {
          _lastPressedTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              Text("Need to create an account?"),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _navigateToSignup, // Call the _navigateToSignup function
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
