import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/resource_type_cubit.dart';
import '../cubit/resource_type_state.dart';
import 'resource_type_form.dart';

class ResourceTypeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resource Types")),
      body: BlocBuilder<ResourceTypeCubit, ResourceTypeState>(
        builder: (context, state) {
          if (state is ResourceTypeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ResourceTypeLoaded) {
            return ListView.builder(
              itemCount: state.resourceTypes.length,
              itemBuilder: (context, index) {
                final resourceType = state.resourceTypes[index];
                return ListTile(
                  title: Text(resourceType.name),
                  subtitle: Text(resourceType.description ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botón para editar el tipo de recurso
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResourceTypeForm(
                                resourceType: resourceType,
                                isEditMode: true,
                              ),
                            ),
                          );
                        },
                      ),
                      // Switch para cambiar el estado
                      Switch(
                        value: resourceType.status,
                        onChanged: (newValue) {
                          context
                              .read<ResourceTypeCubit>()
                              .changeResourceTypeStatus(resourceType.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ResourceTypeError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("No data available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResourceTypeForm(isEditMode: false),
            ),
          );
        },
      ),
    );
  }
}
