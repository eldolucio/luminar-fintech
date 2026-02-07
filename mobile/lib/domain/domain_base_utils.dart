// lib/core/error/failures.dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

// lib/domain/entities/financial_summary.dart
class FinancialSummary {
  final double totalBalance;
  final int accountCount;
  final DateTime lastSync;

  FinancialSummary({
    required this.totalBalance,
    required this.accountCount,
    required this.lastSync,
  });
}

// lib/domain/repositories/open_finance_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/account_entity.dart';
import '../../core/error/failures.dart';

abstract class OpenFinanceRepository {
  Future<Either<Failure, List<AccountEntity>>> getConsolidatedAccounts();
}

// lib/domain/entities/account_entity.dart
class AccountEntity {
  final String id;
  final String bankName;
  final double balance;
  final String currency;

  AccountEntity({
    required this.id,
    required this.bankName,
    required this.balance,
    required this.currency,
  });
}
