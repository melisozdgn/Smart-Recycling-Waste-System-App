import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srws_app/features/scanner/data/data_sources/camera_service.dart';
import 'package:srws_app/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:srws_app/features/scanner/presentation/cubit/scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ScannerRepository repository;
  final CameraService cameraService;

  ScannerCubit({
    required this.repository,
    required this.cameraService,
  }) : super(ScannerInitial());

  Future<void> initCamera() async {
    emit(ScannerLoading());
    try {
      await cameraService.initCamera();
      final controller = cameraService.controller;
      if (controller != null && controller.value.isInitialized) {
        emit(ScannerReady(controller));
      } else {
        emit(const ScannerError('Kamera başlatılamadı.'));
      }
    } catch (e) {
      emit(ScannerError(e.toString()));
    }
  }

  Future<void> captureAndAnalyze() async {
    emit(ScannerAnalysisLoading());
    try {
      final result = await repository.scanWithCamera();
      emit(ScannerAnalysisSuccess(result));
    } catch (e) {
      emit(ScannerError(e.toString()));
    }
  }

  Future<void> analyzeFromFile(File imageFile) async {
    emit(ScannerAnalysisLoading());
    try {
      final result = await repository.analyzeGalleryImage(imageFile);
      emit(ScannerAnalysisSuccess(result));
    } catch (e) {
      emit(ScannerError(e.toString()));
    }
  }

  void reset() => emit(ScannerInitial());

  @override
  Future<void> close() {
    cameraService.dispose();
    return super.close();
  }
}
