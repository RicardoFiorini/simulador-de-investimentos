algoritmo "Simulador de Investimentos"

// Estruturas para Ativos, Carteira e Usuário

variáveis
    tipo Ativo
        nome : caractere
        tipo : caractere // "Ação", "Título", "Fundo"
        valorInicial : real
        valorAtual : real
        rentabilidadeMensal : real
        risco : real // nível de risco de 1 a 10
    fimTipo

    tipo Carteira
        ativos : vetor[1..100] de Ativo
        totalAtivos : inteiro
        saldoInicial : real
        saldoAtual : real
    fimTipo

    usuarioCarteira : Carteira
    opcao : inteiro
    tipoAtivo, nomeAtivo : caractere
    valorInvestimento, rentabilidadeMensal, riscoAtivo : real

início
    usuarioCarteira.totalAtivos ← 0
    usuarioCarteira.saldoInicial ← 0
    usuarioCarteira.saldoAtual ← 0

    // Função para adicionar novo ativo à carteira
    funcao adicionarAtivo()
        usuarioCarteira.totalAtivos ← usuarioCarteira.totalAtivos + 1
        escreva("Tipo do Ativo (Ação, Título, Fundo): ")
        leia(tipoAtivo)
        escreva("Nome do Ativo: ")
        leia(nomeAtivo)
        escreva("Valor do Investimento Inicial: ")
        leia(valorInvestimento)
        escreva("Rentabilidade Mensal (%) estimada: ")
        leia(rentabilidadeMensal)
        escreva("Nível de Risco (1 a 10): ")
        leia(riscoAtivo)

        com usuarioCarteira.ativos[usuarioCarteira.totalAtivos] faça
            nome ← nomeAtivo
            tipo ← tipoAtivo
            valorInicial ← valorInvestimento
            valorAtual ← valorInvestimento
            rentabilidadeMensal ← rentabilidadeMensal / 100
            risco ← riscoAtivo
        fimcom

        usuarioCarteira.saldoInicial ← usuarioCarteira.saldoInicial + valorInvestimento
        usuarioCarteira.saldoAtual ← usuarioCarteira.saldoAtual + valorInvestimento

        escreva("Ativo adicionado com sucesso!\n")
    fimfuncao

    // Função para calcular o desempenho da carteira ao longo do tempo (simula meses)
    funcao simularDesempenho(meses : inteiro)
        escreva("\nSimulando desempenho para ", meses, " meses...\n")
        para i de 1 até meses faça
            usuarioCarteira.saldoAtual ← 0
            para j de 1 até usuarioCarteira.totalAtivos faça
                usuarioCarteira.ativos[j].valorAtual ← usuarioCarteira.ativos[j].valorAtual * (1 + usuarioCarteira.ativos[j].rentabilidadeMensal)
                usuarioCarteira.saldoAtual ← usuarioCarteira.saldoAtual + usuarioCarteira.ativos[j].valorAtual
            fimpara
            escreva("Após ", i, " mês(es), valor total da carteira: R$", usuarioCarteira.saldoAtual, "\n")
        fimpara
    fimfuncao

    // Função para calcular a rentabilidade total da carteira
    funcao calcularRentabilidade()
        rentabilidadeTotal : real
        rentabilidadeTotal ← ((usuarioCarteira.saldoAtual - usuarioCarteira.saldoInicial) / usuarioCarteira.saldoInicial) * 100
        escreva("Rentabilidade Total da Carteira: ", rentabilidadeTotal, "%\n")
    fimfuncao

    // Função para calcular o risco médio da carteira (soma dos riscos ponderados por valor)
    funcao calcularRiscoMedio()
        riscoTotal : real
        valorTotal : real
        riscoMedio : real

        riscoTotal ← 0
        valorTotal ← usuarioCarteira.saldoAtual

        para i de 1 até usuarioCarteira.totalAtivos faça
            riscoTotal ← riscoTotal + (usuarioCarteira.ativos[i].valorAtual * usuarioCarteira.ativos[i].risco)
        fimpara

        riscoMedio ← riscoTotal / valorTotal
        escreva("Risco Médio da Carteira: ", riscoMedio, " (escala de 1 a 10)\n")
    fimfuncao

    // Função para avaliar diversificação da carteira
    funcao calcularDiversificacao()
        totalAcoes, totalTitulos, totalFundos : inteiro
        totalAcoes ← 0
        totalTitulos ← 0
        totalFundos ← 0

        para i de 1 até usuarioCarteira.totalAtivos faça
            escolha usuarioCarteira.ativos[i].tipo
                caso "Ação"
                    totalAcoes ← totalAcoes + 1
                caso "Título"
                    totalTitulos ← totalTitulos + 1
                caso "Fundo"
                    totalFundos ← totalFundos + 1
            fimescolha
        fimpara

        escreva("Diversificação da Carteira:\n")
        escreva("Ações: ", (totalAcoes / usuarioCarteira.totalAtivos) * 100, "%\n")
        escreva("Títulos: ", (totalTitulos / usuarioCarteira.totalAtivos) * 100, "%\n")
        escreva("Fundos: ", (totalFundos / usuarioCarteira.totalAtivos) * 100, "%\n")
    fimfuncao

    // Menu principal
    repita
        escreva("\n=== Simulador de Investimentos ===\n")
        escreva("1. Adicionar Ativo\n")
        escreva("2. Simular Desempenho (Meses)\n")
        escreva("3. Calcular Rentabilidade Total\n")
        escreva("4. Calcular Risco Médio\n")
        escreva("5. Calcular Diversificação\n")
        escreva("0. Sair\n")
        escreva("Escolha uma opção: ")
        leia(opcao)

        escolha opcao
            caso 1
                adicionarAtivo()
            caso 2
                escreva("Quantos meses deseja simular? ")
                leia(opcao)
                simularDesempenho(opcao)
            caso 3
                calcularRentabilidade()
            caso 4
                calcularRiscoMedio()
            caso 5
                calcularDiversificacao()
            caso 0
                escreva("Saindo do Simulador de Investimentos...\n")
            caso contrário
                escreva("Opção inválida.\n")
        fimescolha
    até opcao = 0

fimalgoritmo
