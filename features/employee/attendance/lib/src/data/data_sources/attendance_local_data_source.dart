import 'dart:convert';

import 'package:attendance/attendance.dart';
import 'package:core/core.dart';

const String _kOfflineAttendance = 'OFFLINE_ATTENDANCE_CACHE';

abstract class AttendanceLocalDataSource {
  Future<bool> saveAttendance(List<AttendanceOfflineDataEntity> data);

  Future<List<AttendanceOfflineDataModel>> getSavedAttendances();

  Future<bool> clearSavedAttendances();
}

class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  final CacheManager cache;

  AttendanceLocalDataSourceImpl(this.cache);

  @override
  Future<bool> clearSavedAttendances() async {
    try {
      await cache.delete(_kOfflineAttendance);
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<AttendanceOfflineDataModel>> getSavedAttendances() async {
    try {
      final rawData = await cache.read(_kOfflineAttendance);

      if (rawData != null && rawData is List) {
        return rawData
            .map((e) =>
                AttendanceOfflineDataModel.fromJson(jsonDecode(jsonEncode(e))))
            .toList();
      }

      return [];
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> saveAttendance(List<AttendanceOfflineDataEntity> data) async {
    try {
      await cache.write(
          _kOfflineAttendance, data.map((e) => e.toJson()).toList());
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
