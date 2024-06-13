import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeViewModelNotifier =
    StateNotifierProvider<ThemeViewModel, bool>((ref) => ThemeViewModel());

class ThemeViewModel extends StateNotifier<bool> {
  ThemeViewModel() : super(false);

  void changeTheme() {
    state = !state;
  }
}