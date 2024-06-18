import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/navigator_key/navigator_key.dart';
import 'package:student_management_starter/app/themes/app_theme.dart';
import 'package:student_management_starter/core/common/common_view_model.dart/theme_view_model.dart';
import 'package:student_management_starter/features/splash/presentation/view/splash_view.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeViewModelProvider);
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: AppTheme.getApplicationTheme(themeState),
      home: const SplashView(),
    );
  }
}
