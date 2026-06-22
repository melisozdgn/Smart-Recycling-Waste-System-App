import 'package:get_it/get_it.dart';
import 'package:srws_app/core/services/local_history_service.dart';
import 'package:srws_app/features/scanner/data/data_sources/camera_service.dart';
import 'package:srws_app/features/scanner/data/data_sources/ai_service.dart';
import 'package:srws_app/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:srws_app/features/scanner/data/repositories/scanner_repository_impl.dart';
import 'package:srws_app/features/scanner/presentation/cubit/scanner_cubit.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerLazySingleton<CameraService>(() => CameraService());
  sl.registerLazySingleton<IAiService>(() => AiService());
  sl.registerLazySingleton<LocalHistoryService>(() => LocalHistoryService());

  sl.registerLazySingleton<ScannerRepository>(
    () => ScannerRepositoryImpl(
      cameraService: sl<CameraService>(),
      aiService: sl<IAiService>(),
      localHistory: sl<LocalHistoryService>(),
    ),
  );

  sl.registerFactory<ScannerCubit>(
    () => ScannerCubit(
      repository: sl<ScannerRepository>(),
      cameraService: sl<CameraService>(),
    ),
  );
}
