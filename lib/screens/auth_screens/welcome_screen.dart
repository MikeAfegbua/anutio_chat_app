import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:anutio_chat_app/components/navigator_function.dart';
import 'package:anutio_chat_app/components/rounded_button.dart';
import 'package:anutio_chat_app/screens/auth_screens/login_screen.dart';
import 'package:anutio_chat_app/screens/auth_screens/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: 50,
                        child: Image.asset(
                          'images/logo.png',
                        ),
                      ),
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: const Duration(milliseconds: 300),
                      ),
                    ],
                    repeatForever: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                myText: 'Log In',
                myColor: Colors.red,
                onPressed: () {
                  pushScreen(context, LoginScreen());
                },
              ),
              RoundedButton(
                myColor: Colors.lightBlueAccent,
                myText: "Register",
                onPressed: () {
                  pushScreen(context, RegisterScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
