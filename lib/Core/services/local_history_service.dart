// lib/core/services/local_history_service.dart
// Instance metotlar (projedeki mevcut kullanımla uyumlu)
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';

class LocalHistoryService {
  static const String _key = 'scan_history';

  /// Yeni AI sonucunu kaydet
  Future<void> saveRecord(WasteResult result) async {
    final prefs   = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];

    final record = jsonEncode({
      'category':     result.category,
      'confidence':   result.confidence,
      'description':  result.description,
      'recycling_bin': result.recyclingBin,
      'color_hex':    result.colorHex,
      'timestamp':    DateTime.now().toIso8601String(),
    });

    history.insert(0, record);
    if (history.length > 50) history.removeLast();
    await prefs.setStringList(_key, history);
  }

  /// Tüm geçmişi Map listesi olarak döndür
  Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs   = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    return history
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  /// Geçmişi temizle
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
