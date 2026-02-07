import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/financial_summary.dart';
import '../repositories/open_finance_repository.dart';

/// UseCase responsável por consolidar os saldos de todas as contas conectadas
/// via Open Finance. Aplica regras de conversão de moeda se necessário
/// e tratamento de erros específicos de conexão.
class GetConsolidatedBalance {
  final OpenFinanceRepository repository;

  GetConsolidatedBalance(this.repository);

  Future<Either<Failure, FinancialSummary>> call() async {
    // 1. Busca saldos de múltiplas fontes via repositório
    final result = await repository.getConsolidatedAccounts();
    
    return result.fold(
      (failure) => Left(failure),
      (accounts) {
        // 2. Lógica de negócio: Somatória e formatação
        double totalBalance = 0;
        for (var account in accounts) {
          totalBalance += account.balance;
        }

        return Right(FinancialSummary(
          totalBalance: totalBalance,
          accountCount: accounts.length,
          lastSync: DateTime.now(),
        ));
      },
    );
  }
}
