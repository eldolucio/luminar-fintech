import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fintech_app/main.dart' as app;

/// Teste de Integração: Fluxo de Segurança e Conformidade Open Finance
/// Este teste valida os requisitos da SECURITY_AUDIT.md:
/// 1. Bloqueio Biométrico Obrigatório
/// 2. Integridade do Dashboard após Auth
/// 3. Fluxo de Consentimento Bancário
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Security & Compliance E2E Tests', () {
    
    testWidgets('Deve exigir biometria antes de exibir dados financeiros', (tester) async {
      // 1. Inicia o App
      app.main();
      await tester.pumpAndSettle();

      // 2. Verifica se o Onboarding educacional é a primeira tela (LGPD/Compliance)
      expect(find.text('Seu Banco, Suas Regras.'), findsOneWidget);
      
      // 3. Completa Onboarding
      final startButton = find.text('Começar Agora');
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // 4. Verifica se o Bloqueio Biométrico foi acionado (Hardening)
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
      expect(find.text('Acesso Seguro'), findsOneWidget);

      // 5. Simula autenticação bem-sucedida
      final authButton = find.text('Autenticar');
      await tester.tap(authButton);
      await tester.pumpAndSettle();

      // 6. Valida acesso ao Dashboard Consolidado (Dados Sensíveis protegidos)
      expect(find.text('Saldo Consolidado'), findsOneWidget);
      expect(find.text('R$ 12.450,80'), findsOneWidget);
    });

    testWidgets('Deve permitir gerenciar consentimento Open Finance', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Bypass Auth (Simulado para este teste específico)
      await tester.tap(find.text('Começar Agora'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Autenticar'));
      await tester.pumpAndSettle();

      // 1. Navega para a aba de Carteira (Wallet)
      final walletTab = find.byIcon(Icons.account_balance_wallet_outlined);
      await tester.tap(walletTab);
      await tester.pumpAndSettle();

      // 2. Verifica presença de conta conectada
      expect(find.text('Nubank'), findsOneWidget);

      // 3. Abre detalhes de consentimento (Auditoria)
      await tester.tap(find.text('Nubank'));
      await tester.pumpAndSettle();

      // 4. Valida se informações de segurança/validade estão presentes
      expect(find.text('Gestão de Consentimento'), findsOneWidget);
      expect(find.text('Dados Compartilhados'), findsOneWidget);
      
      // 5. Verifica existência do botão de Revogação (Mandatário BACEN)
      expect(find.text('Revogar Consentimento'), findsOneWidget);
    });
  });
}
