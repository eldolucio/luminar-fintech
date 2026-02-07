import autocannon from 'autocannon';
import { WriteStream } from 'fs';

/**
 * Backend Stress Test - Senior Finance Edition
 * Simula uma carga pesada de sincronização de saldos e transações.
 * Objetivo: Validar latência e estabilidade do BFF sob concorrência.
 */
async function runStressTest() {
    const url = 'http://localhost:3000';

    console.log(`🚀 Iniciando Teste de Stress em: ${url}`);
    console.log('Cenário: 100 usuários simultâneos requisitando consolidado e transações por 30s.\n');

    const instance = autocannon({
        url: url,
        connections: 100, // Conexões simultâneas
        duration: 30,    // Segundos
        pipelining: 1,
        requests: [
            {
                method: 'GET',
                path: '/api/finance/consolidated',
            },
            {
                method: 'GET',
                path: '/api/finance/transactions',
            },
            {
                method: 'POST',
                path: '/api/open-finance/webhook',
                body: JSON.stringify({
                    type: 'SYNC_COMPLETE',
                    institutionId: 'bank_001',
                    timestamp: new Date().toISOString()
                }),
                headers: { 'Content-Type': 'application/json' }
            }
        ]
    }, (err: Error | null, result: autocannon.Result) => {
        if (err) {
            console.error('❌ Erro durante o teste:', err);
            return;
        }
        printResults(result);
    });

    // Mostra progresso
    autocannon.track(instance, { renderProgressBar: true });
}

function printResults(result: autocannon.Result) {
    console.log('\n--- RELATÓRIO DE ESTABILIDADE ---');
    console.log(`Total de Requisições: ${result['2xx'] + result['4xx'] + result['5xx']}`);
    console.log(`Sucesso (2xx): ${result['2xx']}`);
    console.log(`Falhas (5xx): ${result['5xx']}`);
    console.log(`Latência Média: ${result.latency.average} ms`);
    console.log(`Latência P99: ${result.latency.p99} ms`);
    console.log(`Throughput: ${result.throughput.average} bytes/sec`);

    if (result['5xx'] > 0) {
        console.log('\n🚨 CRÍTICO: Detectadas falhas 5xx. O sistema não suportou a carga.');
    } else if (result.latency.p99 > 500) {
        console.log('\n⚠️ ALERTA: Latência P99 acima de 500ms. Experiência do usuário degradada.');
    } else {
        console.log('\n✅ SUCESSO: Sistema estável sob carga de 100 usuários simultâneos.');
    }
}

runStressTest();
