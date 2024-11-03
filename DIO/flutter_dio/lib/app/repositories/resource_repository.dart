import '../models/resource_type.dart';
import '../network/api_services.dart';

class ResourceRepository {
  final ApiServices apiService;

  ResourceRepository(this.apiService);

  Future<List<ResourceType>> fetchResourceTypes() async {
    try {
      return await apiService.fetchResourceTypes();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addResourceType(ResourceType resourceType) async {
    try {
      await apiService.createResourceType(resourceType);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateResourceType(ResourceType resourceType) async {
    try {
      await apiService.updateResourceType(resourceType);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeResourceTypeStatus(int id) async {
    try {
      await apiService.changeResourceTypeStatus(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ResourceType>> fetchPagedResourceTypes(String name) async {
    try {
      return await apiService.fetchPagedResourceTypes(name);
    } catch (e) {
      rethrow;
    }
  }
}
