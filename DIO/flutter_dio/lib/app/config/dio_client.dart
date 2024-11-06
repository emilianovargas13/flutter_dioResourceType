import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  final String _token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWx1ZXZlbnRzMjRAZ21haWwuY29tIiwicm9sZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfU1VQRVJVU0VSIn1dLCJpYXQiOjE3MzA5MTIyOTEsImV4cCI6MTczMTUxNzA5MX0.JFjWoP964XV3boB30TKkcPy82Ibgo6iEsvxsuRmu_WY';

  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://localhost:8080/api/resourceTypes',
          connectTimeout: const Duration(seconds: 30), // Tiempo de conexión
          receiveTimeout: const Duration(
              seconds: 30), // Tiempo de espera para recibir respuesta
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    // Interceptores para autenticación
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler){
        if(_token.isNotEmpty){
          options.headers['Authorization'] = 'Bearer $_token';
        }
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler){
        //Lógica de manejo de errores
        return handler.next(error);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler){
        //Lógica de manejo de respuestas
        print("Response en el dio client: ${response.data}");
        return handler.next(response);
      }
    ));
  }

  // GET
  Future<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      throw Exception("Error en la petición GET: $e");
    }
  }

  //POST
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } catch (e) {
      throw Exception("Error en la petición POST: $e");
    }
  }
}
