import 'dart:convert';

import 'package:store/data/model/address_model.dart';

import '../../../core/error/error_handling.dart';
import '../../../core/error/exception.dart';
import '../../../core/util/function.dart';
import '../../cache/cache_constant.dart';
import '../../cache/cache_manager.dart';

abstract class BaseAddressLocalDatasource {
  Future<AddressModel> getDefaultAddress();

  Future<void> cacheDefaultAddress(AddressModel address);
}

class AddressLocalDatasourceImpl implements BaseAddressLocalDatasource {
  final ErrorHandler _errorHandler;
  final CacheManager _cacheManager;

  AddressLocalDatasourceImpl(this._errorHandler, this._cacheManager);

  @override
  Future<AddressModel> getDefaultAddress() async {
    try {
      if (!await _cacheManager.isValid(
        CacheConstant.defaultAddressCreatedKey,
        CacheConstant.defaultAddressDataKey,
      )) {
        throw CacheException(_errorHandler.cacheError());
      }
      final data =
          await _cacheManager().read(CacheConstant.defaultAddressDataKey);

      if (data == null) {
        throw CacheException(_errorHandler.cacheError());
      }

      final jsonData = json.decode(data);
      final address = AddressModel.fromJson(jsonData);

      return address;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cacheDefaultAddress(AddressModel address) async {
    final addressMap = address.toJson();
    final String addressJson = json.encode(addressMap);

    await _cacheManager()
        .write(CacheConstant.defaultAddressDataKey, addressJson);
    await _cacheManager()
        .write(CacheConstant.defaultAddressCreatedKey, currentTimestamp());
  }
}
