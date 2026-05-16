import 'package:flutter/material.dart';
import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';

class ScanResultSheet extends StatelessWidget {
  final WasteResult result;
  const ScanResultSheet({super.key, required this.result});

  Color get _color {
    final hex = result.colorHex.replaceAll('#', '');
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return const Color(0xFF2E7D32);
    }
  }

  IconData _icon() {
    switch (result.category.toLowerCase()) {
      case 'plastic':           return Icons.local_drink;
      case 'paper':
      case 'paper & cardboard':
      case 'cardboard':         return Icons.description;
      case 'metal':             return Icons.inbox;
      case 'battery':
      case 'batteries':         return Icons.battery_alert;
      case 'glass':             return Icons.wine_bar;
      default:                  return Icons.recycling;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize:     0.40,
      maxChildSize:     0.85,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          controller: ctrl,
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tutamaç
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),
              // İkon
              CircleAvatar(
                radius: 44,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(_icon(), size: 44, color: color),
              ),
              const SizedBox(height: 14),
              // Kategori
              Text(result.category,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: color)),
              const SizedBox(height: 8),
              // Güven skoru badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14)),
                child: Text(
                  '${(result.confidence * 100).toStringAsFixed(0)}% Confidence',
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              // Açıklama
              Text(result.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555555),
                      height: 1.6)),
              const SizedBox(height: 20),
              // Hangi kutuya at
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline_rounded, color: color, size: 26),
                    const SizedBox(width: 10),
                    Text('Place in: ${result.recyclingBin}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: color)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Done butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('Done',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
