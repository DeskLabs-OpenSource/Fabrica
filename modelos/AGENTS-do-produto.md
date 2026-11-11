# AGENTS.md

> Autoridade para **qualquer** assistente de código neste repositório. O `CLAUDE.md` só importa
> este arquivo. Se outro documento discordar deste sobre como escrever código aqui, vale este, e
> a divergência é um defeito: abra uma issue.

## Visão em um parágrafo

<O que o produto é, o que o sistema faz sozinho, licença, relação com os irmãos. Ponteiro para
`VISION.md`.>

**Consequência que muda como você trabalha:** o produto é distribuído como código, e quem
instala numa VPS é o usuário. Uma mudança que funciona na sua máquina e quebra numa instalação
nova é defeito de produto. Nada que exija editar arquivo à mão na VPS entra.

## Stack

<Uma linha por camada, sem versão menor.>

A versão exata de cada dependência é a do arquivo de dependências. Não afirme versão em prosa.

## Mapa de pastas

| Pasta | O que mora ali |
|---|---|
| | |

## Comandos

| Comando | O que faz |
|---|---|
| `<verificar>` | Lint, tipos, cercas e testes. Rode antes de abrir contribuição |
| `<cercas>` | Só as cercas. É o que mais reprova, e é rápido |
| `<teste de banco>` | Testes que usam banco real |
| `<demonstração>` | Roda o caminho central de ponta a ponta, sem credencial |

## Convenções críticas

Cada uma tem uma cerca ou um teste que a cobra. Onde não tem, está dito.

1. **Um caminho de schema.** <como> — cobra: `<caminho>`
2. **Um arquivo por peça.** <quais pastas> — cobra: `<caminho>`
3. **Toda tabela tem organização.** — cobra: `<caminho>`
4. **Todo acesso a dado de produto passa por <a porta única>.** — cobra: `<caminho>`
5. **Um ponto de escrita por entidade.** <quais funções> — cobra: revisão
6. **Fila por notificação.** — cobra: revisão
7. **Configuração de operador tem tela.** — cobra: `<caminho>`
8. **Tudo tem registro**, com vocabulário fechado. — cobra: <...>
9. **Nenhum texto visível fora de dicionário.** — cobra: `<caminho>`
10. **Teste não usa relógio real, porta fixa nem fuso da máquina.** — cobra: revisão
11. **Sem escape de tipo, sem erro engolido.** — cobra: lint
12. **Segredo de operador é cifrado em repouso.** — cobra: revisão
13. **Entrada externa é validada.** — cobra: revisão
14. **<As convenções do domínio.>**

## Antipadrões

Cada item nasceu de um erro medido. O motivo está escrito para você reconhecer a situação, e
não só a regra.

| Nº | Não faça | O erro que originou a regra |
|---|---|---|
| | | |

<Parta de `licoes.md` da Fábrica: uma linha para cada lição que se aplica a este produto.>

## Situação → skill

| Situação | Skill |
|---|---|
| Vou abrir uma contribuição, ou o CI ficou vermelho e não sei se a culpa é minha | `<produto>-contribuir` |
| Não sei se algo é permitido, ou quero o porquê de uma regra | `<produto>-doutrina` |
| Vou instalar numa VPS, ou a instalação falhou | `<produto>-instalar` |
| Tenho uma instalação rodando e preciso atualizar, fazer backup, diagnosticar | `<produto>-operar` |
| Vou criar ou alterar <uma peça plugável> | `<produto>-<peça>` |

## Definição de pronto

Em duas listas, de propósito.

### O que o CI reprova

<A lista exata, que bate com os jobs.>

### O que o CI não vê

Fica com você e com a revisão. É onde moram os defeitos caros.

- **A peça tem duas conexões?** O que a alimenta e o que ela alimenta.
- **O que aconteceu aparece na linha do tempo?** Evento gravado e legível na tela.
- **Se falhar, quem está sendo atendido percebe o quê? E a tela mostra o quê?**
- **Tem tela?** Se o operador precisa de acesso ao servidor para usar, não está pronto.
- **O custo é medido e respeita o teto?**
- **A ação destrutiva pede confirmação nomeando o alvo?**
- **É código de nicho?**
- **Quem já instalou precisa fazer alguma coisa?** Se sim, diga na contribuição.
- **Trouxe algo de fora?** Crédito em `CREDITS.md`.
- **Outra pessoa verificou?** Quem implementa não é quem verifica.

## Regra final: não invente

- **Não invente capacidade.** Se o contrato não está no plano nem no código, ele não existe.
- **Não invente estado.** "Funciona", "passou" e "corrigido" só depois de rodar e ler a saída.
- **Não invente decisão.** O que é do dono está em `GOVERNANCE.md`. Faltou regra? Pedido de
  decisão, com o padrão que vale sem resposta.
- **Não invente fato externo.** Cite a fonte e a data, ou diga que não conferiu.
- **Na dúvida entre dois caminhos, escolha o menor** e diga o que ficou de fora.
