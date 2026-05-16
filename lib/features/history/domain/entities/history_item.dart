import 'package:equatable/equatable.dart';

class HistoryItem extends Equatable {
  final String   id;
  final String   category;
  final DateTime date;

  const HistoryItem({
    required this.id,
    required this.category,
    required this.date,
  });

  @override
  List<Object?> get props => [id, category, date];
}
