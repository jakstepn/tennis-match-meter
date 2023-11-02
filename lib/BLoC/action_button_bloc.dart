import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/BLoC/events/action_button_click_event.dart';

class ActionButtonBloc extends Bloc<ActionButtonEvent, ActionButtonState> {
  ActionButtonBloc() : super(ActionButtonInitialState()) {
    on<ActionButtonClickEvent>((event, emit) {
      emit(ActionButtonClickedState());
    });
    on<ActionButtonUnClickEvent>((event, emit) {
      emit(ActionButtonInitialState());
    });
  }
}

abstract class ActionButtonState {
  ActionButtonState();
}

class ActionButtonInitialState extends ActionButtonState {
  ActionButtonInitialState();
}

class ActionButtonClickedState extends ActionButtonState {
  ActionButtonClickedState();
}
