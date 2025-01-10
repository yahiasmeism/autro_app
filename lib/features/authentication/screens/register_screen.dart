import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/features/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/di.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/validator_util.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/password_input_field.dart';
import '../../../core/widgets/loading_dialog.dart';
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
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
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
                        StandardInput(
                          validator: ValidatorUtils.validateUserName,
                          onChanged: (value) => userName = value,
                          labelText: 'User Name',
                          prefix: const Icon(Icons.person),
                        ),
                        const SizedBox(height: 20),
                        // Email Input
                        StandardInput(
                          onChanged: (value) => email = value,
                          labelText: 'Email',
                          prefix: const Icon(Icons.email),
                          validator: ValidatorUtils.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        // Password Input
                        PasswordInputField(
                          onChanged: (value) => password = value,
                        ),
                        const SizedBox(height: 20),
                        // Confirm Password Input
                        PasswordInputField(
                          isConfirmPassword: true,
                          onChanged: (value) => confirmPassword = value,
                        ),
                        const SizedBox(height: 30),
                        // Register Button
                        PrimaryButton(
                            labelText: 'Register',
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
                                NavUtil.pushR(context, const LoginScreen());
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
      ),
    );
  }

  void listener(BuildContext context, RegisterState state) {
    // state.whenOrNull(
    //   registering: () {
    //     showDialog(
    //       context: context,
    //       builder: (context) => const LoadingDialog(message: 'Registering...'),
    //     );
    //   },
    //   registerSuccess: () {
    //     Navigator.pop(context);
    //     Navigator.popAndPushNamed(context, AppRoutes.home);
    //   },
    //   registerError: (error) {
    //     setupErrorState(context, error);
    //   },
    // );

    if (state is RegistrationInProgress) {
      showDialog(
        context: context,
        builder: (context) => const LoadingDialog(message: 'Registering...'),
      );
    } else if (state is RegistrationCompleted) {
      NavUtil.pop(context);
      NavUtil.push(context, const LoginScreen());
    } else if (state is RegisterError) {
      setupErrorState(context, state.failure);
    }
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
