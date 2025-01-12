import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/features/settings/presentation/bloc/users_list/users_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/overley_loading.dart';
import '../../widgets/add_user_form.dart';

class UserManagementTab extends StatelessWidget {
  const UserManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersListCubit, UsersListState>(
      listener: listener,
      builder: (context, state) {
        if (state is UsersListInitial) return const LoadingIndicator();

        if (state is UsersListLoaded) {
          return Stack(
            children: [
              const SingleChildScrollView(
                child: Column(
                  children: [
                    AddUserForm(),
                    SizedBox(height: 48),
                    UsersList(),
                  ],
                ),
              ),
              if (state.loading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        } else if (state is UsersListError) {
          return FailureScreen(
            failure: state.failure,
            onRetryTap: () => context.read<UsersListCubit>().onHandleFailure(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void listener(BuildContext context, UsersListState state) {
    if (state is UsersListLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold((a) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(a)),
            (message) => DialogUtil.showSuccessSnackBar(context, message)),
      );
    }
  }
}
