import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 22, 57),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(
                image: AssetImage("assets/images/landingPage3.png"),
                width: 300,
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
