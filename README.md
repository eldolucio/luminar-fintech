# FinTech Open Finance Brasil - Engenharia e Arquitetura

Este repositório contém a especificação técnica e a base de código inicial para o aplicativo de Gestão Financeira Pessoal com integração via Open Finance.

## 🚀 Guia Rápido

- **Especificação Completa:** Veja o arquivo [SPECIFICATION.md](./SPECIFICATION.md) para detalhes de segurança, infraestrutura e fluxos.
- **Mobile (Flutter):** Localizado em `/mobile`. Segue Clean Architecture e gerenciamento de estado via BLoC.
- **Backend (Node.js):** Localizado em `/backend`. API RESTful com TypeScript e Prisma ORM.

## 🏛️ Arquitetura Proposta

O projeto utiliza uma separação clara de responsabilidades:
1. **Domain:** Contém as entidades de negócio e as regras de alto nível, independente de frameworks.
2. **Data:** Implementa o acesso a dados, seja via APIs externas (Open Finance) ou banco de dados local.
3. **Presentation:** Camada visual otimizada para performance e UX premium.

## 🔒 Segurança em Primeiro Lugar
- Implementação de mTLS para comunicação com instituições financeiras.
- Tratamento de PII (Personally Identifiable Information) conforme a LGPD.
- Tokens de acesso JWT com expiração curta e rotação de Refresh Tokens.

## 🛠️ Stack Tecnológica Recomendada
- **Mobile:** Flutter 3.x
- **Backend:** Node.js 20+ (NestJS ou Fastify)
- **DB:** PostgreSQL (Persistência) + Redis (Cache/Sessions)
- **Infra:** AWS (Fargate, RDS, Secrets Manager)
- **CI/CD:** GitHub Actions com deploy automatizado para ambientes de Dev, Staging e Prod.

---
© 2026 - Engineering Team
