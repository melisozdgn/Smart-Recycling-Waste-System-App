import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_state.dart';
import '../../domain/entities/history_item.dart';
import '../../../../core/services/local_history_service.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      // LocalHistoryService'ten SharedPreferences'e kaydedilmiş gerçek verileri almak için 
      
      final rawList = await LocalHistoryService().getHistory();

      final items = rawList.map((map) {
        return HistoryItem(
          id:       map['timestamp'] as String? ?? DateTime.now().toIso8601String(),
          category: map['category']  as String? ?? 'Unknown',
          date:     DateTime.tryParse(map['timestamp'] as String? ?? '') ?? DateTime.now(),
        );
      }).toList();

      emit(HistoryLoaded(items));
    } catch (e) {
      emit(HistoryError('Could not load history: $e'));
    }
  }

  Future<void> clearHistory() async {
    await LocalHistoryService().clearHistory();
    emit(const HistoryLoaded([]));
  }
}
