import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      title: 'Welcome',
      home: Scaffold(
        appBar: AppBar(title: const Text('Welcome')),
        body: Center(
          child: Column(
            children: [
              Text('Hello, World!'),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "Hola",
                    "Hola Mundo",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
                child: const Text('Hola Mundo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
