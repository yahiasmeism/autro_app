import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/authentication/bloc/app_auth/app_auth_bloc.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_new_user_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_users_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'users_list_state.dart';

@lazySingleton
class UsersListCubit extends Cubit<UsersListState> {
  final GetUsersListUseCase getUsersListUseCase;
  final AddNewUserUseCase addNewUserUseCase;
  final AppAuthBloc appAuthBloc;
  UsersListCubit(this.getUsersListUseCase, this.addNewUserUseCase, this.appAuthBloc) : super(UsersListInitial());

  Future<void> getUsersList() async {
    Either<Failure, List<UserModel>> result = await getUsersListUseCase(NoParams());
    final currentUser = (appAuthBloc.state as AuthenticatedState).user;

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
}
