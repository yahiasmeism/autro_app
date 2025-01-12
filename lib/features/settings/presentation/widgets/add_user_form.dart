import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/add_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_new_user_use_case.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/standard_selection_dropdown.dart';
import '../bloc/users_list/users_list_cubit.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  bool addUserEnabled = false;
  bool clearAllEnabled = false;

  @override
  void initState() {
    super.initState();
    setUpListeners();
  }

  setUpListeners() {
    userFullNameController.addListener(updateOnChange);
    userRoleController.addListener(updateOnChange);
    emailController.addListener(updateOnChange);
    passwordController.addListener(updateOnChange);
  }

  updateOnChange() {
    updateSaveEnabled();
    updateClearAllEnabled();
  }

  updateSaveEnabled() {
    final isChanged = userFullNameController.text.isNotEmpty &&
        userRoleController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    if (isChanged != addUserEnabled) {
      addUserEnabled = isChanged;
      setState(() {});
    }
  }

  updateClearAllEnabled() {
    final isChanged = userFullNameController.text.isNotEmpty ||
        userRoleController.text.isNotEmpty ||
        emailController.text.isNotEmpty ||
        passwordController.text.isNotEmpty;

    if (isChanged != clearAllEnabled) {
      clearAllEnabled = isChanged;
      setState(() {});
    }
  }

  final formKey = GlobalKey<FormState>();
  final userFullNameController = TextEditingController();
  final userRoleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> addUser() async {
    if (formKey.currentState?.validate() == true) {
      final params = AddNewUserUseCaseParams(
        name: userFullNameController.text,
        role: userRoleController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      sl<UsersListCubit>().addNewUser(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: StandardCard(
        title: 'Add New User',
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: StandardInput(
                  validator: (p0) => ValidatorUtils.validateRequiredField(p0, 'User Full Name'),
                  controller: userFullNameController,
                  labelText: 'User Full Name',
                  hintText: 'Enter user full name',
                )),
                const SizedBox(width: 32),
                Expanded(
                    child: StandardSelectableDropdown(
                  initialValue: userRoleController.text.isNotEmpty ? userRoleController.text : null,
                  items: const [
                    'Admin',
                    'User',
                    'Viewer',
                  ],
                  onChanged: (p0) {
                    userRoleController.text = p0 ?? '';
                  },
                  labelText: 'User Role',
                  hintText: 'Select user role',
                )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: StandardInput(
                  validator: (p0) => ValidatorUtils.validateEmail(p0),
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Enter email',
                )),
                const SizedBox(width: 32),
                Expanded(
                    child: StandardInput(
                  validator: (p0) => ValidatorUtils.validatePassword(p0),
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter password',
                )),
              ],
            ),
            const SizedBox(height: 32),
            Row(children: [
              const Spacer(),
              ClearAllButton(
                onPressed: clearAllEnabled
                    ? () {
                        userFullNameController.clear();
                        userRoleController.clear();
                        emailController.clear();
                        passwordController.clear();
                      }
                    : null,
              ),
              const SizedBox(width: 16),
              AddButton(
                onAddTap: addUserEnabled
                    ? () {
                        addUser();
                      }
                    : null,
                labelAddButton: 'Add User',
              ),
            ])
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    userFullNameController.dispose();
    userRoleController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
