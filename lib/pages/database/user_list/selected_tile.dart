import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/pages/database/user_list/selected_user_event.dart';

class SelectedTileBloc<T> extends Bloc<SelectedTileEvent, T?> {
  SelectedTileBloc() : super(null) {
    on<SelectedNewEvent<T>>((event, emit) {
      emit(event.element);
    });
  }
}
