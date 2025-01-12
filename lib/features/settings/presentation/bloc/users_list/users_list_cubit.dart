import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_new_user_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_users_list_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/remove_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'users_list_state.dart';

@lazySingleton
class UsersListCubit extends Cubit<UsersListState> {
  final GetUsersListUseCase getUsersListUseCase;
  final AddNewUserUseCase addNewUserUseCase;
  final RemoveUserUseCase removeUserUseCase;
  UsersListCubit(this.getUsersListUseCase, this.addNewUserUseCase, this.removeUserUseCase)
      : super(UsersListInitial());

  Future<void> getUsersList() async {
    final currentUser = sl.get<UserModel>();
    Either<Failure, List<UserModel>> result = await getUsersListUseCase(NoParams());

    result.fold((failure) => emit(UsersListError(failure)), (usersList) {
      emit(UsersListLoaded(usersList: usersList, currentUser: currentUser));
    });
  }

  Future<void> addNewUser(AddNewUserUseCaseParams params) async {
    final state = this.state as UsersListLoaded;
    emit(state.copyWith(loading: true));
    Either<Failure, UserModel> result = await addNewUserUseCase(params);
    emit(state.copyWith(loading: false));
    result.fold((failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))), (user) {
      final users = [user, ...state.usersList];
      emit(state.copyWith(usersList: users, failureOrSuccessOption: some(right('User added'))));
    });
  }

  Future<void> removeUser(UserModel user) async {
    final state = this.state as UsersListLoaded;
    emit(state.copyWith(loading: true));
    Either<Failure, Unit> result = await removeUserUseCase(user.id);
    emit(state.copyWith(loading: false));
    result.fold((failure) {
      emit(state.copyWith(failureOrSuccessOption: some(left(failure))));
    }, (_) {
      final users = state.usersList.where((element) => element.id != user.id).toList();
      emit(state.copyWith(
        usersList: users,
        failureOrSuccessOption: some(right('User removed')),
      ));
    });
  }

  onHandleFailure() async {
    emit(UsersListInitial());
    await Future.delayed(const Duration(seconds: 1));
    getUsersList();
  }
}
