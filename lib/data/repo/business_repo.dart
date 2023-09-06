import 'package:connect_app/data/api/connect_api.dart';
import 'package:connect_app/data/api/model/business_api_model.dart';

class BusinessRepository {

  final ConnectApi api;

  BusinessRepository({required this.api});

  Future<List<BusinessApiModel>> getAllBusinesses() async {
    return api.get('businesses/', Bu)
  }
}