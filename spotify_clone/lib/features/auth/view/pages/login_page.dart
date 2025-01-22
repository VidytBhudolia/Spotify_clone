import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spotify_clone/core/theme/app_pallet.dart';
import 'package:spotify_clone/core/theme/auth_graient_button.dart';
import 'package:spotify_clone/features/auth/repositories/auth_remote_repository.dart';
import 'package:spotify_clone/features/auth/view/pages/signup_page.dart';
import 'package:spotify_clone/features/auth/view/widgets/custom_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              CustomField(
                hintText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              AuthGraientButton(
                buttonText: 'Sign In',
                onTap: () async {
                  final res = await AuthRemoteRepository().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  final val = switch (res) {
                    Left(value: final l) => l,
                    Right(value: final r) => r,
                  };
                  print(val);
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: RichText(
                    text: TextSpan(
                        text: "Don't have an account?  ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Pallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
