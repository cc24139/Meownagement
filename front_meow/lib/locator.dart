import 'package:front_meow/services/GatoServices.dart';
import 'package:front_meow/services/UsuarioServices.dart';
import 'package:get_it/get_it.dart';
import 'package:front_meow/services/metaServices.dart';
import 'package:front_meow/services/cofrinhoServices.dart';
import 'package:front_meow/services/transacaoServices.dart';

// Cria uma instância global do GetIt
final GetIt locator = GetIt.instance;

// Função para registrar os serviços
void setupLocator() {
  // Registra os serviços como "singletons".
  // Isso significa que uma única instância será criada e compartilhada por todo o app.
  locator.registerLazySingleton(() => Metaservices());
  locator.registerLazySingleton(() => CofrinhoServices());
  locator.registerLazySingleton(() => TransacaoServices());
  locator.registerLazySingleton(() => UsuarioServices());
  locator.registerLazySingleton(() => GatoServices());
}