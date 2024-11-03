import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/network/api_services.dart';
import 'app/repositories/resource_repository.dart';
import 'app/cubit/resource_type_cubit.dart';
import 'app/views/resource_type_list.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiServices apiServices = ApiServices(Dio());
    final ResourceRepository resourceRepository = ResourceRepository(apiServices);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ResourceTypeCubit(resourceRepository)..fetchResourceTypes()),
      ],
      child: MaterialApp(
        title: 'Resource Type Management',
        home: ResourceTypeListScreen(),
      ),
    );
  }
}
