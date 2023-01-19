import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/signup_page.dart';
import 'package:todo_list/pages/login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                height: 80,
              ),
              const Text(
                "Let's get started!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: 'Roboto',
                  fontSize: 45,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Image(
                image: AssetImage("assets/images/landingPage3.png"),
                height: 400,
                width: 500,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 90,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 76, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 125,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "Log In",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 76, 0),
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
