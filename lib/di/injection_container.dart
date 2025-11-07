import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// Auth imports temporariamente removidos para isolar Firestore
// import 'package:firebase_auth/firebase_auth.dart';

import '../data/datasources/remote/currency_remote_data_source.dart';
import '../data/datasources/local/user_local_data_source.dart';
import '../data/datasources/local/transaction_local_data_source.dart';
// Auth imports temporariamente removidos para isolar Firestore
// import '../data/datasources/remote/auth_remote_data_source.dart';
import '../data/datasources/remote/transaction_firestore_data_source.dart';
import '../data/repositories/currency_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../data/repositories/transaction_repository_impl.dart';
// Auth imports temporariamente removidos
import '../domain/repositories/currency_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/usecases/get_dollar_value.dart';
import '../domain/usecases/get_user.dart';
import '../domain/usecases/save_user.dart';
import '../domain/usecases/clear_user.dart';
import '../domain/usecases/get_transactions.dart';
import '../domain/usecases/add_transaction.dart';
import '../domain/usecases/edit_transaction.dart';
import '../domain/usecases/delete_transaction.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Firestore Transaction DataSource
  sl.registerLazySingleton<TransactionFirestoreDataSource>(() => TransactionFirestoreDataSourceImpl(firestore: sl()));

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Data sources
  sl.registerLazySingleton<CurrencyRemoteDataSource>(() => CurrencyRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<TransactionLocalDataSource>(() => TransactionLocalDataSourceImpl());

  // Repositories (register by abstraction)
  sl.registerLazySingleton<CurrencyRepository>(() => CurrencyRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<TransactionRepository>(() => TransactionRepositoryImpl(localDataSource: sl()));

  // Usecases
  sl.registerLazySingleton<GetDollarValue>(() => GetDollarValue(sl()));
  sl.registerLazySingleton<SaveUser>(() => SaveUser(sl()));
  sl.registerLazySingleton<GetUser>(() => GetUser(sl()));
  sl.registerLazySingleton<ClearUser>(() => ClearUser(sl()));
  sl.registerLazySingleton<GetTransactions>(() => GetTransactions(sl()));
  sl.registerLazySingleton<AddTransaction>(() => AddTransaction(sl()));
  sl.registerLazySingleton<EditTransaction>(() => EditTransaction(sl()));
  sl.registerLazySingleton<DeleteTransaction>(() => DeleteTransaction(sl()));
}
