import 'package:flutter/material.dart';
import 'package:hungry_calculator/pages/stepper_page.dart';

class GreetingsPage extends StatefulWidget {
  const GreetingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _GreetingsPage();
}

class _GreetingsPage extends State<GreetingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: onTap,
          child: logoButton(),
        ),
      ),
    );
  }

  Widget logoButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const SizedBox(
        //   height: 100,
        //   width: 100,
        //   child: Image(
        //     image: AssetImage('assets/logo.png'),
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'начнём',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        )
      ],
    );
  }

  void onTap() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const StepperPage(); // Замените NextPage() на ваш виджет следующей страницы
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

