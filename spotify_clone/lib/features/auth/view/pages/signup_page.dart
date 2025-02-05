import 'package:flutter/material.dart';
import 'package:spotify_clone/core/theme/app_pallet.dart';
import 'package:spotify_clone/core/theme/auth_graient_button.dart';
import 'package:spotify_clone/core/utils.dart';
import 'package:spotify_clone/core/wigets/loader.dart';
import 'package:spotify_clone/features/auth/view/pages/login_page.dart';
import 'package:spotify_clone/features/auth/view/widgets/custom_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;
    ref.listen(
      authViewmodelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(context, "Sign up successful. Please login");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          error: (error, st) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBar(context, error.toString());
            });
          },
          loading: () {},
        );
      },
    );
    return isLoading
        ? const Loader()
        : Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up.',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    CustomField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(height: 15),
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
                      buttonText: 'Sign Up',
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          await ref
                              .read(authViewmodelProvider.notifier)
                              .signUpUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: 'Already have an account?  ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                              text: 'Sign In',
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
