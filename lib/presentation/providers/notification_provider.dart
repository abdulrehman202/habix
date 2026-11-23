import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/injection.dart';
import 'package:habix/service/notification_service.dart';



final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(getIt<Dio>());
});