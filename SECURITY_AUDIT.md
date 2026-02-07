# Plano de Garantia de Qualidade, Segurança e Auditoria (FinTech Mobile)

---

## 1. Visão Geral
Este documento estabelece os critérios e procedimentos formais para a verificação de segurança, detecção de bugs e validação de resiliência do ecossistema financeiro. O objetivo é assegurar o selo "Production-Ready" em conformidade com o Banco Central do Brasil e LGPD.

---

## 2. Checklist de Segurança e Hardening (Baseado em OWASP MAST)

### 2.1 Armazenamento e Criptografia (M1, M2)
- [ ] **Data at Rest:** Validar se `FlutterSecureStorage` utiliza `AES-256-GCM` no Android e `Keychain` no iOS.
- [ ] **No Raw PII:** Garantir que nenhum dado sensível (CPF, Saldo, Nome) seja gravado em `SharedPreferences` ou `UserDefaults`.
- [ ] **Binary Obfuscation:** Validar se o build de produção foi gerado com `--obfuscate --split-debug-info`.
- [ ] **Root/Jailbreak Detection:** Implementação de bloqueio de execução em dispositivos comprometidos.

### 2.2 Segurança em Trânsito (M3)
- [ ] **TLS 1.3:** Garantir que o Backend recuse conexões abaixo de TLS 1.2.
- [ ] **SSL Pinning:** Validar a assinatura dos certificados no app para prevenir ataques Man-in-the-Middle (MitM).
- [ ] **mTLS (Open Finance):** Testar a troca de certificados digitais ICP-Brasil para autenticação mTLS mútua com os bancos.

### 2.3 Gestão de Sessão e Sessão OAuth 2.0 (M4)
- [ ] **Biometric Fallback:** Se a biometria falhar 3x, exigir senha mestra.
- [ ] **Idleness Timeout:** Bloqueio automático do app após 120 segundos de inatividade.
- [ ] **Refresh Token Rotation:** Garantir que cada renovação de token Open Finance gere um novo `refresh_token` e invalide o anterior.

---

## 3. Plano de Testes Automatizados e Resiliência

### 3.1 Cobertura de Testes (KPIs)
| Tipo de Teste | Ferramenta Recomendada | Meta de Cobertura | Foco |
| :--- | :--- | :--- | :--- |
| **Unitários** | Flutter Test / Jest | > 85% | UseCases e Regras de Negócio |
| **Integração** | Integration Test (Flutter) | Fluxos Críticos | Login -> Sync Banco -> Dashboard |
| **E2E (Scenario)** | Appium / Maestro | Happy Path | Cadastro completo e revogação |
| **Contrato (API)**| Pact | 100% Endpoints | Sincronia entre App e BFF |

### 3.2 Testes de Caos e Resiliência
- [ ] **API Timeout:** Forçar 15s de delay na API Open Finance e validar se o App exibe o estado de "Retry" sem travar.
- [ ] **Invalid Consent:** Simular um token revogado pelo banco e verificar se o App redireciona o usuário para o fluxo de nova conexão com mensagem clara.
- [ ] **Partial Data:** Testar o comportamento do Dashboard quando o Banco A responde, mas o Banco B está offline (Resiliência Parcial).

---

## 4. Matriz de Vulnerabilidades (Exemplo de Report)

| ID | Vulnerabilidade | Risco | Impacto | Ação de Tratamento |
| :--- | :--- | :--- | :--- | :--- |
| SEC-01 | Logs com PII (Saldos no Logcat) | **ALTO** | Exposição de dados sensíveis | Remover `print()` e usar logger estruturado em modo dev apenas. |
| SEC-02 | Falta de SSL Pinning | **MÉDIO** | Interceptação de tráfego (MitM) | Implementar `HttpCertificatePinning` no código Flutter. |
| BBUG-03| Crash em saldo negativo | **BAIXO** | Experiência do usuário | Validar conversão de tipos `Decimal` no parse de JSON. |

---

## 5. Monitoramento, Logs e Auditoria

### 5.1 Estratégia de Logs (SIEM/ELK)
- **Logs de Auditoria:** Toda ação de `Consentimento`, `Revogação` e `Login` DEVE gerar um log imutável no backend contendo: `timestamp`, `user_id`, `ip_address`, `device_id` e `action`.
- **Crash Reporting:** Integração obrigatória com Firebase Crashlytics ou Sentry.

### 5.2 Alertas Críticos (P1)
- Alerta em 5 minutos se a taxa de erro 5XX nas APIs de Open Finance subir > 5%.
- Alerta imediato se houver 10 falhas de autenticação biométrica seguidas para o mesmo `user_id`.

---

## 6. Critérios de "Pronto para Produção" (Go-Live Gate)

1. [ ] Resolução de 100% das vulnerabilidades de Risco **ALTO** e **CRÍTICO**.
2. [ ] Teste de Stress/Carga realizado (Suportar 3x a carga esperada no lançamento).
3. [ ] Auditoria de Conformidade LGPD assinada pelo DPO.
4. [ ] Pentest externo (Grey Box) concluído com relatório de remediação.
5. [ ] Configuração de Backups e Plano de Disaster Recovery testado.

---
**Documento gerado por:** Senior Security & Quality Engineer
**Status:** Revisado para Auditoria
**Versão:** 1.0.0
