import 'package:autro_app/core/extensions/user_role_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/settings/presentation/bloc/users_list/users_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListCubit, UsersListState>(
      builder: (context, state) {
        if (state is UsersListLoaded) {
          return Column(
            children: [
              const StandartListTitle(title: 'Registered Users'),
              state.sortedUsers.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Center(child: Text('No Users', style: TextStyles.font16Regular)),
                    )
                  : Column(
                      children: [
                        _buildHeaderRow(),
                        _buildList(context, state),
                      ],
                    ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'User Full Name',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'User Role',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 4,
            child: Text(
              'Email',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'Password',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.center,
              'Actions',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTileRow(UserModel user, BuildContext context, {required bool isCurrentUser}) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                user.name,
                style: TextStyles.font16Regular,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Text(
                user.role.str,
                style: TextStyles.font16Regular,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 4,
              child: Text(
                user.email,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Text(
                "*" * 12,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(onPressed: () {}),
                  const SizedBox(width: 8),
                  if (!isCurrentUser)
                    DeleteIconButton(
                      onPressed: () {
                        context.read<UsersListCubit>().removeUser(user);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, UsersListLoaded state) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: state.usersList.length,
      itemBuilder: (context, index) {
        return _buildTileRow(state.sortedUsers[index], context,
            isCurrentUser: state.sortedUsers[index].id == state.currentUser.id);
      },
    );
  }
}
