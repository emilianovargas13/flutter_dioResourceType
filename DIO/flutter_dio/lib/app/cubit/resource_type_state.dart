import '../models/resource_type.dart';

abstract class ResourceTypeState {}

class ResourceTypeInitial extends ResourceTypeState {}

class ResourceTypeLoading extends ResourceTypeState {}

class ResourceTypeLoaded extends ResourceTypeState {
  final List<ResourceType> resourceTypes;

  ResourceTypeLoaded(this.resourceTypes);
}

class ResourceTypeError extends ResourceTypeState {
  final String message;

  ResourceTypeError(this.message);
}
