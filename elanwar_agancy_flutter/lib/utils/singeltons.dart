import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:get_it/get_it.dart';

GetIt singelton = GetIt.instance;

Future<void> intiSingeltons() async {
  singelton.registerSingleton<ApiClient>(ApiClientImplementation());

  await singelton<ApiClient>().init();
}
