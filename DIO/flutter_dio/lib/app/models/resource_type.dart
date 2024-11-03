class ResourceType {
  final int id;
  final String name;
  final String iconName;
  final String? description;
  final bool status;

  ResourceType({
    required this.id,
    required this.name,
    required this.iconName,
    this.description,
    required this.status,
  });

  factory ResourceType.fromJson(Map<String, dynamic> json) {
    return ResourceType(
      id: json['id'],
      name: json['name'],
      iconName: json['iconName'],
      description: json['description'],
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'description': description,
      'status': status,
    };
  }
  }