import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
        body:  Center(
          child: Column(
            children: [
              Text('Login'),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed("/home");
                },  
                child: const Text('Home'),
              )
            ],
          ),
      ),
    );
  }
  }