import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:student_management_starter/features/batch/presentation/widgets/load_batch.dart';

class BatchView extends ConsumerStatefulWidget {
  const BatchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BatchViewState();
}

class _BatchViewState extends ConsumerState<BatchView> {
  final gap = const SizedBox(height: 8);
  final batchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var batchState = ref.watch(batchViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batch Management'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: batchController,
                decoration: const InputDecoration(
                  labelText: 'Batch Name',
                ),
              ),
              gap,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(batchViewModelProvider.notifier).addBatch(
                          BatchEntity(batchName: batchController.text),
                        );
                    batchController.clear();
                  },
                  child: const Text('Add Batch'),
                ),
              ),
              gap,
              const Text(
                'List of Batches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              batchState.isLoading
                  ? const CircularProgressIndicator()
                  : batchState.lstBatches.isEmpty
                      ? const Text('No Batches')
                      : Expanded(
                          child: LoadBatch(
                            lstBatch: batchState.lstBatches,
                            ref: ref,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
