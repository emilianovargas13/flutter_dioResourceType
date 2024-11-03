import 'package:dio/dio.dart';
import '../models/resource_type.dart';

class ApiServices {
  final Dio dio;
  final String baseUrl = 'http://localhost:8080/api/resourceTypes';

  ApiServices(this.dio);

  

  // Obtener lista completa de tipos de recurso (GET)
  Future<List<ResourceType>> fetchResourceTypes() async {
    final url = '$baseUrl/list';
    try {
      final response = await dio.get(url);
      return (response.data as List)
          .map((json) => ResourceType.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Obtener tipos de recurso paginados (POST)
  Future<List<ResourceType>> fetchPagedResourceTypes(String name) async {
    final url = '$baseUrl/paged';
    try {
      final response = await dio.post(url, data: {'name': name});
      return (response.data as List)
          .map((json) => ResourceType.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Cambiar estado de un tipo de recurso (PATCH)
  Future<void> changeResourceTypeStatus(int id) async {
    final url = '$baseUrl/change/status';
    try {
      await dio.patch(url, data: {'id': id});
    } catch (e) {
      return null;
    }
  }

  

  // Crear nuevo tipo de recurso (POST)
Future<void> createResourceType(ResourceType resourceType) async {
  final url = '$baseUrl/';
  try {
    await dio.post(url, data: resourceType.toMap());
  } catch (e) {
      return null;
  }
}

// Actualizar tipo de recurso (PUT)
Future<void> updateResourceType(ResourceType resourceType) async {
  final url = '$baseUrl/';
  try {
    await dio.put(url, data: resourceType.toMap());
  } catch (e) {
      return null;
  }
}


}
