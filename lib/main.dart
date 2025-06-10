import 'package:flutter/material.dart';
import 'package:super_app/config/theme/app_theme.dart';
//getx
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Super App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: colorList[0]),
      home: Scaffold(
        appBar: AppBar(title: const Text('Super App')),
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
