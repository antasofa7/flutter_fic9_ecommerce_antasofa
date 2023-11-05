import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/orderDetail/order_detail_response_model.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';
part 'order_detail_bloc.freezed.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(const _Initial()) {
    on<_GetOrderDetail>((event, emit) async {
      emit(const _Loading());

      final response =
          await OrderRemoteDataSource().getOrderById(event.orderId);

      response.fold((failure) => emit(_Failed(failure)),
          (result) => emit(_Success(result)));
    });
  }
}
