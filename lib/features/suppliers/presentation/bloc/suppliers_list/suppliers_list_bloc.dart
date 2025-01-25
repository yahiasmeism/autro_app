import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/domin/repositoreis/suppliers_repository.dart';
import 'package:autro_app/features/suppliers/domin/usecases/create_supplier_usecase.dart';
import 'package:autro_app/features/suppliers/domin/usecases/get_suppliers_list_usecase.dart';
import 'package:autro_app/features/suppliers/domin/usecases/update_supplier_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/usecases/delete_supplier_usecase.dart';

part 'suppliers_list_event.dart';
part 'suppliers_list_state.dart';

@injectable
class SuppliersListBloc extends Bloc<SuppliersListEvent, SuppliersListState> {
  final GetSuppliersListUsecase getSuppliersListUsecase;
  final DeleteSupplierUsecase deleteSupplierUsecase;
  final SuppliersRepository suppliersRepository;
  final UpdateSupplierUsecase updateSupplierUsecase;
  final CreateSupplierUsecase createSupplierUsecase;
  SuppliersListBloc(
    this.getSuppliersListUsecase,
    this.deleteSupplierUsecase,
    this.suppliersRepository,
    this.updateSupplierUsecase,
    this.createSupplierUsecase,
  ) : super(SuppliersListInitial()) {
    on<SuppliersListEvent>(_mapEvents);
  }

  int get totalCount => suppliersRepository.totalCount;

  Future _mapEvents(SuppliersListEvent event, Emitter<SuppliersListState> emit) async {
    if (event is GetSuppliersListEvent) {
      await onGetSuppliersList(event, emit);
    }

    if (event is OnUpdatePaginationSuppliersEvent) {
      await onUpdatePagination(event, emit);
    }

    if (event is HandleFailureSuppliersEvent) {
      await onHandleFailure(event, emit);
    }

    if (event is NextPageSuppliersEvent) {
      await onNextPage(event, emit);
    }
    if (event is PreviousPageSuppliersEvent) {
      await onPreviousPage(event, emit);
    }
    if (event is DeleteSupplierEvent) {
      await onDeleteSupplier(event, emit);
    }
    if (event is SearchInputChangedSuppliersEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedSupplierEvent) {
      await onAddedUpdatedSupplier(event, emit);
    }
  }

  Future onGetSuppliersList(GetSuppliersListEvent event, Emitter<SuppliersListState> emit) async {
    emit(SuppliersListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetSuppliersListUsecaseParams(dto: paginationFilterDto);
    final either = await getSuppliersListUsecase.call(params);
    either.fold(
      (failure) => emit(SuppliersListError(failure: failure)),
      (suppliers) => emit(SuppliersListLoaded(
        totalCount: totalCount,
        suppliersList: suppliers,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationSuppliersEvent event, Emitter<SuppliersListState> emit) async {
    final state = this.state as SuppliersListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetSuppliersListUsecaseParams(dto: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getSuppliersListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (suppliers) => emit(state.copyWith(
        totalCount: totalCount,
        suppliersList: suppliers,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureSuppliersEvent event, Emitter<SuppliersListState> emit) async {
    emit(SuppliersListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetSuppliersListEvent());
  }

  onNextPage(NextPageSuppliersEvent event, Emitter<SuppliersListState> emit) {
    final state = this.state as SuppliersListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationSuppliersEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageSuppliersEvent event, Emitter<SuppliersListState> emit) {
    final state = this.state as SuppliersListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationSuppliersEvent(pageNumber: pageNumber));
  }

  onDeleteSupplier(DeleteSupplierEvent event, Emitter<SuppliersListState> emit) async {
    final state = this.state as SuppliersListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteSupplierUsecase.call(event.supplierId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedSuppliersList = List.of(state.suppliersList);
        updatedSuppliersList.removeWhere((element) => element.id == event.supplierId);
        const message = 'Supplier Deleted Successfully';
        emit(state.copyWith(
          suppliersList: updatedSuppliersList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
  }

  onSearchInputChanged(SearchInputChangedSuppliersEvent event, Emitter<SuppliersListState> emit) async {
    if (state is SuppliersListLoaded) {
      final state = this.state as SuppliersListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetSuppliersListUsecaseParams(dto: updatedFilterPagination);

      final either = await getSuppliersListUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (suppliers) {
          emit(state.copyWith(
            suppliersList: suppliers,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: totalCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedSupplier(AddedUpdatedSupplierEvent event, Emitter<SuppliersListState> emit) async {
    final state = this.state as SuppliersListLoaded;
    final params = GetSuppliersListUsecaseParams(dto: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getSuppliersListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (suppliers) => emit(state.copyWith(
        totalCount: totalCount,
        suppliersList: suppliers,
      )),
    );
  }
}
