import 'package:t_society/src/data/repository/bill.dart';
import 'package:t_society/src/data/repository/complain.dart';
import 'package:t_society/src/data/repository/dashboard.dart';
import 'package:t_society/src/data/repository/expense.dart';
import 'package:t_society/src/data/repository/login.dart';
import 'package:t_society/src/data/repository/expense_report.dart';
import 'package:t_society/src/data/repository/user.dart';
import 'package:t_society/src/data/repository/visitor.dart';
import 'package:t_society/src/data/repository_impl/bill.dart';
import 'package:t_society/src/data/repository_impl/complain.dart';
import 'package:t_society/src/data/repository_impl/dashboard.dart';
import 'package:t_society/src/data/repository_impl/expense.dart';
import 'package:t_society/src/data/repository_impl/login.dart';
import 'package:t_society/src/data/repository_impl/expense_report.dart';
import 'package:t_society/src/data/repository_impl/user.dart';
import 'package:t_society/src/data/repository_impl/visitor.dart';

import 'locator.dart';

void registerRepository(){
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl()));
  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl(sl()));
  sl.registerLazySingleton<ComplainRepository>(() => ComplainRepositoryImpl(sl()));
  sl.registerLazySingleton<ExpenseReportRepository>(() => ExpenseReportRepositoryImpl(sl()));
  sl.registerLazySingleton<VisitorRepository>(() => VisitorRepositoryImpl(sl()));
  sl.registerLazySingleton<BillRepository>(() => BillRepositoryImpl(sl()));
}
















