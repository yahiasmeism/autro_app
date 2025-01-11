import '../../../interfaces/mapable.dart';
import '../../domin/dto/pagination_query_payload_dto.dart';

class PaginationFilterRequest extends PaginationFilterDTO {
  const PaginationFilterRequest({
    required super.pageNumber,
    required super.pageSize,
    required super.sort,
    required super.filter,
  });

  factory PaginationFilterRequest.fromDTO(PaginationFilterDTO dto) => PaginationFilterRequest(
        pageNumber: dto.pageNumber,
        pageSize: dto.pageSize,
        sort: dto.sort,
        filter: dto.filter,
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        if (sort.sortBy.isNotEmpty) ...SortRequest.fromDTO(sort).toJson(),
        if (filter.conditions.isNotEmpty) ...FilterRequest.fromDTO(filter).toJson()
      };
}

class FilterRequest extends FilterDTO implements RequestMapable {
  const FilterRequest({
    required super.logic,
    required super.conditions,
    required super.groups,
  });

  factory FilterRequest.fromDTO(FilterDTO dto) => FilterRequest(
        logic: dto.logic,
        conditions: dto.conditions,
        groups: dto.groups,
      );

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (int i = 0; i < conditions.length; i++) {
      json["filter.conditions[$i][field]"] = conditions[i].fieldName;
      json["filter.conditions[$i][operator]"] = conditions[i].conditionOperator.index;
      json["filter.conditions[$i][value]"] = conditions[i].value;
    }
    return json;
  }
}

class SortRequest extends SortDTO {
  const SortRequest({
    required super.sortBy,
    required super.ascending,
  });

  factory SortRequest.fromDTO(SortDTO dto) => SortRequest(
        sortBy: dto.sortBy,
        ascending: dto.ascending,
      );

  Map<String, dynamic> toJson() => {
        "sort.sortBy": sortBy,
        "sort.ascending": ascending,
      };
}
