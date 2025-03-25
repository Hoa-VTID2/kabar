import 'package:kabar/data/datasources/remote/models/response/list_response_model.dart';
import 'package:kabar/domain/entities/list_paging.dart';

class ListPagingTranslator {
  static ListPaging<T> translateToEntity<T, S>(
    ListResponseModel<S> model,
    T Function(S) translator,
  ) {
    int totalPages = 0;
    if (model.total > 0 && model.pageSize > 0) {
      totalPages = (model.total * 1.0 / model.pageSize).ceil();
    }
    return ListPaging(
      currentPage: model.pageNum,
      totalItems: model.total,
      totalPages: totalPages,
      data: model.data.map((e) => translator(e)).toList(),
    );
  }
}
