abstract class SelectedTileEvent {
  SelectedTileEvent();
}

class SelectedNewEvent<T> extends SelectedTileEvent {
  SelectedNewEvent({required this.element});
  final T element;
}
