import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/resource_type_cubit.dart';
import '../models/resource_type.dart';

class ResourceTypeForm extends StatefulWidget {
  final ResourceType? resourceType;
  final bool isEditMode;

  ResourceTypeForm({this.resourceType, required this.isEditMode});

  @override
  _ResourceTypeFormState createState() => _ResourceTypeFormState();
}

class _ResourceTypeFormState extends State<ResourceTypeForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _iconNameController;
  late TextEditingController _descriptionController;
  bool _status = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.isEditMode ? widget.resourceType?.name : '');
    _iconNameController = TextEditingController(
        text: widget.isEditMode ? widget.resourceType?.iconName : '');
    _descriptionController = TextEditingController(
        text: widget.isEditMode ? widget.resourceType?.description : '');
    _status = widget.isEditMode ? widget.resourceType?.status ?? true : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? "Edit Resource Type" : "Add Resource Type"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _iconNameController,
                decoration: InputDecoration(labelText: 'Icon Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an icon name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Status"),
                  Switch(
                    value: _status,
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newResourceType = ResourceType(
                      id: widget.isEditMode ? widget.resourceType!.id : 0,
                      name: _nameController.text,
                      iconName: _iconNameController.text,
                      description: _descriptionController.text,
                      status: _status,
                    );

                    if (widget.isEditMode) {
                      context.read<ResourceTypeCubit>().updateResourceType(newResourceType);
                    } else {
                      context.read<ResourceTypeCubit>().createResourceType(newResourceType);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.isEditMode ? "Update" : "Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
