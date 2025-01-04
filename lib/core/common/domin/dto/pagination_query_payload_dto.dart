import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

class PaginationFilterDTO extends Equatable {
  final int pageNumber;
  final int pageSize;
  final SortDTO sort;
  final FilterDTO filter;

  const PaginationFilterDTO({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.filter,
  });

  factory PaginationFilterDTO.initial() {
    final sort = SortDTO.inital();
    final filter = FilterDTO.defaultFilter();
    return PaginationFilterDTO(
      pageNumber: 1,
      pageSize: 10,
      sort: sort,
      filter: filter,
    );
  }

  PaginationFilterDTO copyWith({
    int? pageNumber,
    int? pageSize,
    SortDTO? sort,
    FilterDTO? filter,
  }) {
    return PaginationFilterDTO(
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      sort: sort ?? this.sort,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [pageNumber, pageSize, sort, filter];
}

class SortDTO extends Equatable {
  final String sortBy;
  final bool ascending;

  const SortDTO({
    required this.sortBy,
    required this.ascending,
  });
  factory SortDTO.inital() {
    return const SortDTO(sortBy: 'UpdateDate', ascending: false);
  }
  @override
  List<Object> get props => [sortBy, ascending];
}

class FilterDTO extends Equatable {
  final String logic;
  final List<FilterConditionDTO> conditions;
  final List<String> groups;

  const FilterDTO({
    required this.logic,
    required this.conditions,
    required this.groups,
  });
  factory FilterDTO.defaultFilter() {
    return const FilterDTO(logic: 'And', conditions: [], groups: []);
  }
  @override
  List<Object> get props => [logic, conditions, groups];

  bool get isChanged => this != FilterDTO.defaultFilter();

  FilterDTO copyWith({
    String? logic,
    List<FilterConditionDTO>? conditions,
    List<String>? groups,
  }) {
    return FilterDTO(
      logic: logic ?? this.logic,
      conditions: conditions ?? this.conditions,
      groups: groups ?? this.groups,
    );
  }
}

class FilterConditionDTO extends Equatable {
  final String fieldName;
  final ConditionOperator conditionOperator;
  final String value;

  const FilterConditionDTO({
    required this.fieldName,
    required this.conditionOperator,
    required this.value,
  });
  factory FilterConditionDTO.searchFilter(String keyword) {
    return FilterConditionDTO(
      fieldName: 'searchTerm',
      conditionOperator: ConditionOperator.contains,
      value: keyword,
    );
  }
  @override
  List<Object> get props => [fieldName, conditionOperator];
}
