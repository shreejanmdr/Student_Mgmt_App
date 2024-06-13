class BatchEntity {
  final String? batchId;
  final String batchName;

  const BatchEntity({
    this.batchId,
    required this.batchName,
  });

  @override
  List<Object?> get props => [batchId, batchName];
}
