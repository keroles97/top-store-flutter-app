import 'package:path_provider/path_provider.dart';

import '../../core/util/function.dart';
import 'cache_client.dart';
import 'cache_constant.dart';

/// callable class
class CacheManager {
  CacheManager._internal();

  static final CacheManager _instance = CacheManager._internal();

  factory CacheManager() => _instance;

  CacheClient? _cacheClient;

  /// initiate cache clients
  Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();

    _cacheClient ??= HiveClient();
    await _cacheClient!.init(appDir);
  }

  /// return cache client instance
  CacheClient call() {
    return _cacheClient!;
  }

  /// check if cache is valid and exists
  Future<bool> isValid(String createdKey, String dataKey) async {
    //return false;
    final int? created = (await _cacheClient!.read(createdKey)) as int?;

    if (created == null) return false;
    if (!_cacheClient!.exist(dataKey)) return false;

    final current = currentTimestamp();

    final diff = current - created;

    if (diff < CacheConstant.cacheValidSeconds) return true;

    await _cacheClient!.remove(createdKey);
    await _cacheClient!.remove(dataKey);
    return false;
  }
}
