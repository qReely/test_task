import 'package:flutter/material.dart';
import 'package:test_task/login_page.dart';
import 'package:test_task/users_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorMap =
    {
      50:Color.fromRGBO(155,81,224, .1),
      100:Color.fromRGBO(155,81,224, .2),
      200:Color.fromRGBO(155,81,224, .3),
      300:Color.fromRGBO(155,81,224, .4),
      400:Color.fromRGBO(155,81,224, .5),
      500:Color.fromRGBO(155,81,224, .6),
      600:Color.fromRGBO(155,81,224, .7),
      700:Color.fromRGBO(155,81,224, .8),
      800:Color.fromRGBO(155,81,224, .9),
      900:Color.fromRGBO(155,81,224, 1),
    };
    MaterialColor color = MaterialColor(0xFF9B51E0, colorMap);

    return MaterialApp(
      title: 'Test Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: color,
      ),
      initialRoute: "/",
      routes:  {
        "/" :(context) => const LoginPage(),
        "/users" : (context) => const UsersPage(),
      },
    );
  }
}
