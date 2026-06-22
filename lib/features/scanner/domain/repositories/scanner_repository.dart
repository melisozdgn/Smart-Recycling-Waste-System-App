import 'dart:io';
import 'package:srws_app/features/scanner/domain/entities/waste_result.dart';

abstract class ScannerRepository {
  Future<WasteResult> scanWithCamera();
  Future<WasteResult> analyzeGalleryImage(File image);
}