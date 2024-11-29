class HomeState {
  final List<int> openedSheets;
  final int animatingIndex;

  HomeState({
    this.openedSheets = const [],
    this.animatingIndex = -1,
  });

  HomeState copyWith({
    List<int>? openedSheets,
    int? animatingIndex,
  }) {
    return HomeState(
      openedSheets: openedSheets ?? this.openedSheets,
      animatingIndex: animatingIndex ?? this.animatingIndex,
    );
  }
}