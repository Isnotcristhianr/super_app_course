import 'package:get/get.dart';
//views
import '../views/welcome.dart';
import '../views/loggin/loggin.dart';
//import 

class Routes {
  static const String home = '/home';
  static const String login = '/login';

  static final List<GetPage> pages = [
    GetPage(name: home, page: () => WelcomeView()),
   // GetPage(name: login, page: () => LoginView()),
  ];
}