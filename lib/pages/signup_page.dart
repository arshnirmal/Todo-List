import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscure = true;
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  bool _emailOk = false;
  bool _passwordOk = false;
  bool _confirmPasswordOk = false;
  bool circularProgressBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 22, 57),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image(
                  image: const AssetImage("assets/images/landingPage3.png"),
                  height: MediaQuery.of(context).size.height / 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.425,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        textFormField("Full Name", false, _nameController),
                        const SizedBox(
                          height: 15,
                        ),
                        textFormField("Email Address", false, _emailController),
                        const SizedBox(
                          height: 15,
                        ),
                        textFormField("Password", true, _passwordController),
                        const SizedBox(
                          height: 15,
                        ),
                        textFormField("Confirm Password", _isObscure,
                            _confirmPasswordController),
                        const SizedBox(
                          height: 25,
                        ),
                        button(),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "-----------------OR-----------------",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        socialLogin(),
                        const SizedBox(
                          height: 20,
                        ),
                        otherMethod(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormField(
      String label, bool isObscure, TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          suffixIcon: label == "Confirm Password"
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _isObscure = !_isObscure;
                      },
                    );
                  },
                )
              : null,
        ),
        style: const TextStyle(
          fontSize: 20,
        ),
        onChanged: (val) {
          if (label == "Email Address") {
            setState(() {
              _email = val;
              _emailOk = EmailValidator.validate(_email);
            });
          }
          if (label == "Password") {
            setState(() {
              _password = val;
              _passwordOk = _password.length >= 8;
            });
          }
          if (label == "Confirm Password") {
            setState(() {
              _confirmPassword = val;
              _confirmPasswordOk = _confirmPassword == _password;
            });
          }
        },
        controller: controller,
      ),
    );
  }

  Widget button() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        onPressed: !_emailOk
            ? () {
                const snackBar = SnackBar(
                  content: Text("Please enter a valid email address"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            : !_passwordOk
                ? () {
                    const snackBar = SnackBar(
                      content: Text("Password must be at least 8 characters"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                : !_confirmPasswordOk
                    ? () {
                        const snackBar = SnackBar(
                          content: Text("Passwords do not match"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    : () async {
                        setState(
                          () {
                            circularProgressBar = true;
                          },
                        );
                        try {
                          // ignore: unused_local_variable
                          UserCredential userCredential =
                              await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          setState(
                            () {
                              circularProgressBar = false;
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "email-already-in-use") {
                            const snackBar = SnackBar(
                              content: Text("Email already in use"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            const snackBar = SnackBar(
                              content: Text("Something went wrong"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          setState(
                            () {
                              circularProgressBar = false;
                            },
                          );
                        }
                      },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 76, 0),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
        child: circularProgressBar
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
      ),
    );
  }

  Widget socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(
          image: AssetImage("assets/images/google.png"),
          height: 50,
        ),
        SizedBox(
          width: 60,
        ),
        Image(
          image: AssetImage("assets/images/facebook.png"),
          height: 50,
        ),
        SizedBox(
          width: 60,
        ),
        Image(
          image: AssetImage("assets/images/twitter.png"),
          height: 50,
        ),
      ],
    );
  }

  Widget otherMethod() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          const TextSpan(
            text: "Already have an account? ",
            style: TextStyle(
              color: Colors.black,
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
    );
  }
}
