import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/features/authentication/bloc/login/login_state.dart';
import 'package:autro_app/features/home/screens/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/di.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/validator_util.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/generic_text_form_field.dart';
import '../../../core/widgets/loading_dialog.dart';
import '../bloc/login/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  @override
  Widget build(BuildContext context) {
    final cubit = sl<LoginCubit>();
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: listener,
        child: Scaffold(
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Please login to your account',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.black54,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        GenericTextFormField(
                          validator: ValidatorUtil.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                          onChanged: (value) => _email = value,
                          label: 'Email',
                          hint: 'Enter your email',
                        ),
                        const SizedBox(height: 20),
                        // Password Input
                        GenericTextFormField(
                          validator: ValidatorUtil.validatePassword,
                          prefixIcon: Icons.lock,
                          onChanged: (value) => _password = value,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          hint: 'Enter your password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        // Login Button
                        PrimaryButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(email: _email, password: _password);
                            }
                          },
                          text: 'Login',
                        ),
                        const SizedBox(height: 20),
                        // Text for Sign Up Navigation
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Don't have an account?",
                        //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        //             color: Colors.black54,
                        //           ),
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         Navigator.pushReplacementNamed(context, AppRoutes.register);
                        //       },
                        //       child: Text(
                        //         'Sign Up',
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: Theme.of(context).colorScheme.primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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

  void listener(BuildContext context, LoginState state) {
    if (state is LoginInProgress) {
      showDialog(
        context: context,
        builder: (context) => const LoadingDialog(message: 'Logging In'),
      );
    } else if (state is LoginCompleted) {
      NavUtil.pop(context);
      NavUtil.push(context, const HomeWrapper());
    } else if (state is LoginError) {
      setupErrorState(context, state.failure);
    }
  }

  void setupErrorState(BuildContext context, Failure error) {
    NavUtil.pop(context);
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
