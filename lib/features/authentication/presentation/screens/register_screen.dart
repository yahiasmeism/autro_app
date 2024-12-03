import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/validator_util.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/generic_text_form_field.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../bloc/register/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _globalKey = GlobalKey<FormState>();
  String userName = '', email = '', password = '', confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    final cubit = sl<RegisterCubit>();

    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: listener,
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // App Logo
                      // const CircleAvatar(
                      //   radius: 50,
                      //   backgroundImage: AssetImage('assets/logo.png'), // Add your logo image in assets
                      //   backgroundColor: Colors.transparent,
                      // ),
                      const SizedBox(height: 20),
                      // Welcome Text
                      Text(
                        'Create an Account!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sign up to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Full Name Input
                      GenericTextFormField(
                        validator: ValidatorUtil.validateUserName,
                        onChanged: (value) => userName = value,
                        label: 'User Name',
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      // Email Input
                      GenericTextFormField(
                        onChanged: (value) => email = value,
                        label: 'Email',
                        prefixIcon: Icons.email,
                        validator: ValidatorUtil.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      // Password Input
                      GenericTextFormField(
                        validator: ValidatorUtil.validatePassword,
                        onChanged: (value) => password = value,
                        label: 'Password',
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password Input
                      GenericTextFormField(
                        label: 'Confirm Password',
                        validator: (value) => ValidatorUtil.validateConfirmPassword(value, password),
                        prefixIcon: Icons.lock,
                        onChanged: (value) => confirmPassword = value,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      // Register Button
                      PrimaryButton(
                          text: 'Register',
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              cubit.register(email: email, password: confirmPassword, name: userName);
                            }
                          }),

                      const SizedBox(height: 20),
                      // Text for Login Navigation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.login);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listener(BuildContext context, RegisterState state) {
    state.whenOrNull(
      registering: () {
        showDialog(
          context: context,
          builder: (context) => const LoadingDialog(message: 'Registering...'),
        );
      },
      registerSuccess: () {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, AppRoutes.home);
      },
      registerError: (error) {
        setupErrorState(context, error);
      },
    );
  }

  void setupErrorState(BuildContext context, Failure error) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error.message ?? 'Something went wrong',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Got it',
            ),
          ),
        ],
      ),
    );
  }
}
