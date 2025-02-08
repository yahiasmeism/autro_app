import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/domin/usecases/get_customer_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'customer_details_state.dart';

@injectable
class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  final GetCustomerUsecase getCustomerUsecase;

  CustomerDetailsCubit(this.getCustomerUsecase) : super(CustomerDetailsInitial());
  Future getCustomer(int id) async {
    emit(CustomerDetailsInitial());

    final either = await getCustomerUsecase.call(id);

    either.fold(
      (l) => emit(CustomerDetailsError(failure: l, id: id)),
      (r) => emit(CustomerDetailsLoaded(customerEntity: r)),
    );
  }

  handleError() async {
    if (state is CustomerDetailsError) {
      final state = this.state as CustomerDetailsError;
      emit(CustomerDetailsInitial());
      await Future.delayed(const Duration(milliseconds: 300));
      await getCustomer(state.id);
    }
  }

  updateCustomer(CustomerEntity customerEntity) async {
    final state = this.state as CustomerDetailsLoaded;
    emit(state.copyWith(customerEntity: customerEntity));
  }
}
