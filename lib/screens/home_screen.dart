import 'package:daytwo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:daytwo/services/authentication.dart';

void signOut(BuildContext context) {
  AuthServices().signOut();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();

        if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
          // Show a message to press back again to exit
          _lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Do not exit yet
        }

        // Exit the app directly
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                signOut(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              tooltip: 'Logout',
            ),
          ],
        ),
        body: const Center(
          child: Text(
            "Welcome to the Home Screen!",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
