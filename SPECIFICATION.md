# Especificação Técnica: FinTech Mobile App (Open Finance Brasil)

---

## 1. Visão Geral do Projeto
Este documento detalha a arquitetura e especificação técnica para um aplicativo de gestão financeira pessoal (PFM) com integração nativa ao ecossistema Open Finance Brasil. O objetivo é fornecer uma visão consolidada do patrimônio do usuário, insights inteligentes e controle rigoroso de gastos.

---

### 1.1 Funcionalidades Avançadas (V2)
*   **Gestão de Consentimento:** Painel detalhado de permissões por instituição com opção de revogação imediata.
*   **Onboarding Educativo:** Fluxo inicial explicando a segurança do Open Finance e privacidade de dados.
*   **Lançamentos Manuais:** Possibilidade de registrar gastos em espécie ou transações fora do ecossistema bancário.
*   **Gestão de Budgets:** Definição de limites mensais por categoria com alertas de proximidade de estouro.
*   **Segurança Adaptativa:** Bloqueio automático por biometria ao alternar entre apps.

---

## 2. Arquitetura do Sistema

### 2.1 Visão Macro
Adotaremos uma arquitetura de microsserviços orientada a eventos para garantir escalabilidade e desacoplamento entre a integração bancária e o motor de regras de finanças.

*   **Mobile App:** Flutter (iOS/Android) com Clean Architecture.
*   **API Gateway:** AWS API Gateway para gerenciamento de tráfego e throttling.
*   **BFF (Backend for Frontend):** Node.js (TypeScript) para agregação de dados específicos da UI.
*   **Core Services:**
    *   **Auth Service:** IAM, OAuth2, Integração Biométrica.
    *   **Financial Service:** Gestão de transações, categorias e metas.
    *   **Open Finance Connector:** Comunicação com diretório do BACEN e APIs das instituições.
*   **Database:** PostgreSQL (RDS) para dados relacionais e Redis para cache de saldos em tempo real.

---

## 3. Integração Open Finance Brasil

O fluxo segue os padrões de segurança **FAPI (Financial-grade API)** exigidos pelo Banco Central.

### 3.1 Fluxo de Consentimento (OAuth 2.0 / OIDC)
1.  **Descoberta:** O app consome o diretório do BACEN para listar instituições participantes.
2.  **Redirect/App2App:** O usuário seleciona o banco e é redirecionado via Deep Link para o app da instituição financeira.
3.  **Consentimento:** O usuário autoriza o compartilhamento de dados (Saldos, Extratos, Cartão de Crédito).
4.  **Callback:** O banco redireciona de volta para o nosso app com um `authorization_code`.
5.  **Token Exchange:** O Backend troca o código por um `access_token` e `refresh_token` armazenados de forma criptografada.

---

## 4. Estratégia de Segurança e Conformidade (LGPD/OWASP)

### 4.1 Mobile Security
*   **SSL Pinning:** Prevenção de ataques Man-in-the-Middle (MitM).
*   **Obscure Storage:** Uso de `Flutter Secure Storage` (Keychain/Keystore).
*   **Jailbreak/Root Detection:** Impedir execução em aparelhos comprometidos.
*   **Biometric Lock:** Exigência de FaceID/TouchID após X minutos de inatividade.

### 4.2 Backend & Cloud
*   **Encryption at Rest:** AES-256 em todos os volumes de DB e Buckets S3.
*   **Encryption in Transit:** TLS 1.3 obrigatório.
*   **Cofre de Chaves:** Uso de AWS Secrets Manager/KMS para chaves de API e certificados Open Finance.
*   **LGPD:** Implementação de exclusão lógica ("Direito ao esquecimento") e trilha de auditoria para acessos a dados sensíveis.

---

## 5. Modelo de Dados Principal (Entity-Relationship)

### Entidades Core:
*   **User:** ID, Email (Hashed), Nome, Preferências.
*   **BankConnection:** UserID, InstitutionID, ConsentID, Status, ExpirationDate.
*   **Account:** ID, BankConnectionID, Type (Corrente/Poupanca), LastBalance, Currency.
*   **Transaction:** ID, AccountID, Amount, Date, Description, CategoryID, ProviderTransactionID.
*   **FinancialGoal:** UserID, Name, TargetAmount, CurrentAmount, Deadline.
*   **Budget:** UserID, CategoryID, MonthlyLimit, SpentAmount, Period.
*   **ConsentAudit:** ID, UserID, InstitutionID, PermissionsJSON, ExpirationDate, RevocationDate.

---

## 6. Estrutura de Código Inicial (Proposta)

### Mobile (Flutter)
```text
lib/
├── core/                   # Utilitários, constantes, temas
├── data/
│   ├── repositories/       # Implementação dos contratos
│   └── datasources/        # Chamadas de API (Dio/Retrofit)
├── domain/
│   ├── entities/           # Classes de negócio puras
│   ├── repositories/       # Interfaces/Abstract classes
│   └── usecases/           # Regras de negócio específicas
└── presentation/
    ├── bloc/               # State Management
    ├── pages/              # Telas (Dashboard, Settings, Meta)
    └── widgets/            # UI Components reutilizáveis (Design System)
```

### Backend (Node.js/TS)
```text
src/
├── api/                    # Controllers e Routes
├── domain/                 # Business Logic e Services
├── infra/                  # Database, External Clients (Open Finance)
└── shared/                 # Middlewares, Security, Config
```

---

## 7. Dashboard Financeiro & UX

O Dashboard será focado em **"Visibilidade e Ação"**:
1.  **Header Dinâmico:** Saldo Total Consolidado (com Toggle de visibilidade).
2.  **Widget de Liquidez:** Barra radial de Receitas vs Despesas do mês.
3.  **Insights por IA:** "Você gastou 15% a mais em Restaurantes esta semana".
4.  **Quick Actions:** Adicionar despesa manual, Conectar novo banco.
5.  **Lista Crítica:** Contas a vencer nos próximos 3 dias.

---

## 8. Checklist de Prontidão para Produção (Go-Live)

- [ ] Auditoria de Pentest (Mobile + Backend).
- [ ] Implementação de Logs Estruturados (ELK Stack ou CloudWatch).
- [ ] Configuração de Alertas de Erro (Sentry/New Relic).
- [ ] Certificado Digital ICP-Brasil (Obrigatório para Open Finance).
- [ ] Homologação de Cadastro no Diretório Central do BACEN.
- [ ] Disaster Recovery Plan documentado e testado.
- [ ] Verificação de acessibilidade (WCAG 2.1).

---
**Elaborado por:** Senior Software Engineer - FinTech Specialist
**Data:** 07/02/2026
