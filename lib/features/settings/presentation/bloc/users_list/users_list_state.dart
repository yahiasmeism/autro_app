part of 'users_list_cubit.dart';

sealed class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

final class UsersListInitial extends UsersListState {}

final class UsersListLoaded extends UsersListState {
  final List<UserModel> usersList;
  final bool loading;
  final UserModel currentUser;
  final Option<Either<Failure, String>> failureOrSuccessOption;

  const UsersListLoaded({
    required this.usersList,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    required this.currentUser,
  });

  // should be sorted to prefer current user first and then admins second and then others
  List<UserModel> get sortedUsers {
    return usersList.toList() // Create a mutable copy of the list
      ..sort((a, b) {
        if (a.id == currentUser.id) return -1; // Current user comes first
        if (b.id == currentUser.id) return 1; // Current user comes first

        // Sort admins next (assuming we have an isAdmin property)
        if (a.role.isAdmin && !b.role.isAdmin) return -1; // Admins come before non-admins
        if (!a.role.isAdmin && b.role.isAdmin) return 1; // Non-admins after admins

        // Leave others unsorted (no additional sorting applied)
        return 0;
      });
  }

  @override
  List<Object> get props => [usersList, loading, failureOrSuccessOption, currentUser];

  UsersListLoaded copyWith({
    List<UserModel>? usersList,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return UsersListLoaded(
      usersList: usersList ?? this.usersList,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      currentUser: currentUser,
    );
  }
}

final class UsersListError extends UsersListState {
  final Failure failure;

  const UsersListError(this.failure);

  @override
  List<Object> get props => [failure];
}
