import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/common_view_model.dart/theme_view_model.dart';
import 'package:student_management_starter/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:student_management_starter/features/batch/presentation/widgets/show_my_snackbar.dart';
import 'package:student_management_starter/features/course/presentation/viewmodel/course_view_model.dart';
import 'package:student_management_starter/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:student_management_starter/features/home/presentation/widgets/batch_widget.dart';
import 'package:student_management_starter/features/home/presentation/widgets/course_widget.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeViewModelProvider);
    var batchState = ref.watch(batchViewModelProvider);
    var courseState = ref.watch(courseViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dashboard View'),
            const Spacer(),
            // Reload button
            IconButton(
              onPressed: () {
                ref.read(batchViewModelProvider.notifier).getAllBatches();
                ref.read(courseViewModelProvider.notifier).getAllCourses();
                showMySnackBar(message: 'Refreshing...');
              },
              icon: const Icon(Icons.refresh),
            ),

            // Logout button
            IconButton(
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).logout();
              },
              icon: const Icon(Icons.logout),
            ),

            // Theme toggle button
            Switch(
              value: themeState,
              onChanged: (value) {
                ref.read(themeViewModelProvider.notifier).changeTheme();
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Batches',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (batchState.isLoading) ...{
              const CircularProgressIndicator(),
            } else if (batchState.error != null) ...{
              Text(batchState.error.toString()),
            } else ...{
              Flexible(
                child: BatchWidget(ref: ref, batchList: batchState.lstBatches),
              ),
            },
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (courseState.isLoading) ...{
              const CircularProgressIndicator(),
            } else if (courseState.error != null) ...{
              Text(courseState.error.toString()),
            } else ...{
              Flexible(
                child: CourseWidget(courseList: courseState.lstCourses),
              ),
            }
          ],
        ),
      ),
    );
  }
}
