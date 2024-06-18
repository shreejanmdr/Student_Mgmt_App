import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/common_view_model.dart/theme_view_model.dart';
import 'package:student_management_starter/features/batch/presentation/view/batch_view.dart';
import 'package:student_management_starter/features/course/presentation/view/course_view.dart';
import 'package:student_management_starter/features/home/presentation/view/dashboard_view.dart';
import 'package:student_management_starter/features/home/presentation/viewmodel/home_view_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
   
    final lstViews = [
      const DashboardView(),
      const CourseView(),
      const BatchView(),
      const SizedBox.expand(
        child: Center(
          child: Text(
            'Profile ',
          ),
        ),
      )
    ];
    return Scaffold(
      
      body: lstViews[homeState],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.batch_prediction),
            label: 'Batch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: homeState,
        onTap: (index) {
          ref.read(homeViewModelProvider.notifier).changeIndex(index);
        },
      ),
    );
  }
}
