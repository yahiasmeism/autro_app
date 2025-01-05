import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'customer_details_state.dart';

@injectable
class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  CustomerDetailsCubit() : super(CustomerDetailsInitial());
  Future init(CustomerEntity customerEntity) async {
    emit(CustomerDetailsLoaded(customerEntity: customerEntity));
  }

  updateCustomer(CustomerEntity customerEntity) async {
    final state = this.state as CustomerDetailsLoaded;
    emit(state.copyWith(customerEntity: customerEntity));
  }
}
