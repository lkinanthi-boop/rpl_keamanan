import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

class DependencyInjector {
  static final ApiService apiService = ApiService();

  static final UserRepository userRepository =
      UserRepositoryImpl(apiService: apiService);

  static final PostRepository postRepository =
      PostRepositoryImpl(apiService: apiService);
}