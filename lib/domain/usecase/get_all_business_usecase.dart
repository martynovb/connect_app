import 'package:connect_app/data/repo/business_repo.dart';
import 'package:connect_app/domain/model/business_model.dart';
import 'package:connect_app/domain/usecase/base_usecase.dart';

class GetAllBusinessUseCase
    extends BaseUseCase<Future<List<BusinessModel>>, void> {
  final BusinessRepository businessRepository;

  GetAllBusinessUseCase({
    required this.businessRepository,
  });

  @override
  Future<List<BusinessModel>> execute({void params}) async {
    final data = await businessRepository.getAllBusinesses();
    return data
        .map((businessApiModel) => BusinessModel.fromApiModel(businessApiModel))
        .toList();
  }
}
