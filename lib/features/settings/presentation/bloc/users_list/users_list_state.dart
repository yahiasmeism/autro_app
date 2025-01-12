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
