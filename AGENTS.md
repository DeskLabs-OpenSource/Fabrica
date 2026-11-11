# AGENTS.md

> Para qualquer assistente de código que vá fundar um produto com esta Fábrica, auditar um
> produto contra ela, ou alterar a própria Fábrica. O `CLAUDE.md` só importa este arquivo.

## O que você tem em mãos

Um manual de método, e não um template. Você não copia código daqui para o produto novo: você
segue as fases, toma as decisões na ordem e produz os artefatos que cada fase pede. Os
documentos de `modelos/` são formulários para preencher.

A implementação de referência das mecânicas é o repositório do
[DeskVoice](https://github.com/DeskLabs-OpenSource/DeskVoice). [`referencia.md`](referencia.md)
diz onde está cada peça, o que ela ainda não cumpre e o que tem configurado e nunca exercitou.

## Se você vai fundar um produto

Siga [`skills/fabrica-fundar/SKILL.md`](skills/fabrica-fundar/SKILL.md). Ela conduz as dez fases
de [`manual/00-o-metodo.md`](manual/00-o-metodo.md), e guarda o estado da fundação no
repositório do produto para que outra sessão continue de onde esta parou.

O essencial, se você não puder carregar a skill:

1. Peça ao dono só o que nenhuma pesquisa responde: o problema, o parceiro, a casa.
2. Leia [`licoes.md`](licoes.md) inteiro e faça os levantamentos que faltam.
3. Apresente ao dono as decisões que dependem de evidência, e escreva o desenho.
4. Escreva os contratos, e construa com a fábrica dentro desde o primeiro commit.
5. Rode o sistema montado; peça uma revisão fria; instale numa VPS; peça ao dono para usar.
6. Publique, e devolva as lições a este repositório.

## Se você vai auditar um produto

Siga [`skills/fabrica-auditar/SKILL.md`](skills/fabrica-auditar/SKILL.md). A régua é
[`conformidade.md`](conformidade.md). A Fábrica não exige obediência: exige que cada divergência
seja uma decisão escrita.

## O que você não faz

- **Não escolhe o parceiro de distribuição, a licença, a fronteira com outro produto nem uma
  versão maior.** São do dono.
- **Não pula a revisão fria, a instalação real nem o uso pelo dono** porque os testes estão
  verdes. No segundo produto, cada uma dessas três achou o que as outras não acharam.
- **Não herda a stack do produto anterior por inércia.** Aplique os critérios do capítulo 03.
- **Não trata "não provado" como regra.** Onde um capítulo marca assim, você decide, registra e
  devolve o resultado.
- **Não deixa decisão esperando o dono sem padrão.** Use
  [`modelos/pedido-de-decisao.md`](modelos/pedido-de-decisao.md) e siga com o que não depende
  dela.
- **Não publica informação comercial nem fala de pessoas reais.**

## Se você vai alterar a Fábrica

- **Regra nova precisa de erro de origem.** Ele entra em `licoes.md`, com o que aconteceu, a
  regra e como se cobra. Depois o capítulo aponta para a linha.
- **Toda regra nasce de um erro medido num produto.** Onde a solução ainda não rodou em nenhum,
  o texto diz: numa seção "Não provado", ou na própria lição.
- **Onde os produtos divergem, o manual segue a razão medida,** e diz qual produto precisa
  convergir.
- **Regra nova em capítulo ganha um item em `conformidade.md`,** com o jeito de conferir.
- **Erros são contados sem números internos, sem nomes de pessoas e sem citar texto de
  terceiros.**
- **Todo caminho citado existe.** Antes de terminar, rode `bash scripts/conferir.sh`.
- **O tom é profissional e calmo.** Sem exclamação, sem adjetivo vazio, sem promessa de data.

## Estado

Primeira versão, escrita a partir de uma fundação concluída (DeskVoice) e do histórico do
DeskcommCRM. As dez fases foram executadas uma vez, e fora de ordem em dois pontos, que o
capítulo 00 registra. A terceira fundação vai corrigir este manual, e é para isso que existe a
devolução.
