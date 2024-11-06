import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/resource_type.dart';
import '../repositories/resource_repository.dart';
import 'resource_type_state.dart';

class ResourceTypeCubit extends Cubit<ResourceTypeState> {
  final ResourceRepository resourceRepository;

  ResourceTypeCubit(this.resourceRepository) : super(ResourceTypeInitial());

  void fetchResourceTypes() async {
    try {
      emit(ResourceTypeLoading());
      final resourceTypes = await resourceRepository.fetchResourceTypes();
      print("resultado jejeje ${resourceTypes}");
      emit(ResourceTypeLoaded(resourceTypes));
    } catch (e) {
      emit(ResourceTypeError(e.toString()));
    }
  }

  void createResourceType(ResourceType resourceType) async {
    try {
      await resourceRepository.addResourceType(resourceType);
      fetchResourceTypes();
    } catch (e) {
      emit(ResourceTypeError(e.toString()));
    }
  }

  void updateResourceType(ResourceType resourceType) async {
    try {
      await resourceRepository.updateResourceType(resourceType);
      fetchResourceTypes();
    } catch (e) {
      emit(ResourceTypeError(e.toString()));
    }
  }

  void changeResourceTypeStatus(int id) async {
    try {
      await resourceRepository.changeResourceTypeStatus(id);
      fetchResourceTypes();
    } catch (e) {
      emit(ResourceTypeError(e.toString()));
    }
  }

  void fetchPagedResourceTypes(String name) async {
    try {
      emit(ResourceTypeLoading());
      final resourceTypes = await resourceRepository.fetchPagedResourceTypes(name);
      emit(ResourceTypeLoaded(resourceTypes));
    } catch (e) {
      emit(ResourceTypeError(e.toString()));
    }
  }
}
