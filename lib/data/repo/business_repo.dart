import 'package:connect_app/common/logger.dart';
import 'package:connect_app/data/api/connect_api.dart';
import 'package:connect_app/data/api/model/business_api_model.dart';

class BusinessRepository {
  static const String tag = 'BusinessRepository';

  final ConnectApi api;

  BusinessRepository({required this.api});

  Future<List<BusinessApiModel>> getAllBusinesses() async {
    var result = await api.getAllBusinesses();
    ConnectLogger.d(tag, result);
    return result;
  }
}
