# 00. O método

> Uma fundação tem dez fases. Cada uma termina num portão: um artefato que existe e pode ser
> conferido. Não se passa de fase com o portão aberto.

## Por que em fases

No primeiro produto, as decisões de fundação foram tomadas enquanto o código era escrito. Várias
só mostraram o custo meses depois, com centenas de pessoas dependendo delas: dois retratos do
banco que divergiram, numeração que colidia entre contribuições paralelas, o dono como gargalo
de cada decisão pequena.

O segundo produto inverteu a ordem: levantou evidência, escreveu as decisões, e só então
construiu. Mirou catorze erros conhecidos antes da primeira linha. Mesmo assim, os defeitos
graves que restaram só apareceram em momentos que não são escrever código: rodar o sistema
montado, uma revisão por quem não participou, a primeira instalação numa máquina de verdade e o
dono tentando usar. Por isso esses quatro são fases, e não boas intenções.

**O que este capítulo é.** As fases abaixo são a ordem que o segundo produto *deveria* ter
seguido, corrigida pelo que ele pagou por não seguir. Onde ele saiu da ordem, está dito.

## As fases

| Fase | O que acontece | Portão |
|---|---|---|
| 1. Entradas do dono | O que só o dono sabe e não depende de evidência | Problema, parceiro e casa, escritos |
| 2. Levantamentos | Evidência antes do desenho | Um relatório por pergunta, com o que foi lido e o que não foi |
| 3. Decisões e desenho | As decisões que dependem de evidência, e o documento da fundação | Decisões aprovadas pelo dono; desenho escrito |
| 4. Contratos | Os formatos entre as peças, antes de construir em paralelo | Contratos escritos num lugar só |
| 5. Construção | O repositório, com a fábrica dentro desde o primeiro commit | Verificação local verde |
| 6. Prova montada | O sistema inteiro rodando pelas entradas reais | Um caminho de ponta a ponta executado e lido |
| 7. Revisão fria | Um parecer adversarial de quem não tem o contexto | Parecer com veredito; bloqueadores fechados; fase 6 repetida |
| 8. Instalação real | Instalar numa VPS, como um usuário faria | Instalação funcionando, com evidência |
| 9. O dono usa | O dono tenta fazer o que o produto promete | O que ele não conseguiu, escrito |
| 10. Publicação e devolução | O repositório vai a público, e o que se aprendeu volta para a Fábrica | Lista de publicação cumprida; lições em `licoes.md` |

### 1. Entradas do dono

Três coisas são pedidas antes de qualquer levantamento, porque nenhuma pesquisa as responde:

- **O problema e para quem.** Que trabalho o sistema faz sozinho, e quem ganha com isso
  (capítulo 01).
- **O parceiro de distribuição.** Qual empresa este produto divulga e como ela aparece na
  instalação (capítulo 02). No segundo produto isso só foi dito depois da publicação e custou
  um retrabalho no instalador e no README.
- **A casa.** Organização no GitHub, nome do repositório, licença.

Duas decisões que também são do dono ficam para a fase 3: a fronteira com os produtos irmãos e
o que nasce desligado. No segundo produto, as duas só fizeram sentido depois dos levantamentos.
A fronteira virou pergunta quando se descobriu o que o produto irmão já fazia, e "o que nasce
desligado" saiu da pesquisa sobre a regulação do domínio. Perguntadas antes, teriam resposta
sem base.

### 2. Levantamentos

Antes de desenhar, quatro perguntas são respondidas com evidência. Cada uma vira um relatório
curto, e cada relatório termina dizendo o que foi lido de fato e o que foi só inferido.

| Pergunta | Onde procurar |
|---|---|
| Que erros já foram pagos? | [`licoes.md`](../licoes.md). Já está pronto: não refaça |
| O que o público pede e do que reclama? | Comentários do canal, issues, comunidade |
| Qual a stack do domínio? | Pesquisa externa, pelo critério do capítulo 03 |
| O que a lei e o mercado do domínio impõem? | Regulação, regras de provedores, práticas do setor |

Uma quinta vale quando existe produto irmão: **o que já existe lá e pode ser trazido?**

Regras dos relatórios:

- Cada afirmação é marcada como **fato lido**, **estimativa** ou **não verificado**, com a
  data. Preço, regra de provedor e regulação mudam.
- **O que não foi lido é dito.** No segundo produto, um levantamento declarou que não tinha lido
  o corpo de uma doutrina do primeiro. A versão do segundo foi escrita sem ela, e três leis
  ficaram de fora sem ninguém decidir isso.
- **Um nome visto num inventário não diz o que o arquivo contém.** O segundo produto batizou
  uma doutrina com o nome de um arquivo do primeiro que trata de outro assunto.

### 3. Decisões e desenho

Primeiro as decisões. O construtor apresenta ao dono as que dependem da evidência, cada uma com
opções, custo e recomendação: a fronteira com os irmãos, a peça central da stack, o que nasce
desligado, e as que o domínio pedir. No segundo produto foram cinco.

Depois o documento, no formato de
[`modelos/desenho-da-fundacao.md`](../modelos/desenho-da-fundacao.md). As seções que não podem
faltar:

- **Intenção**, em um parágrafo.
- **Decisões do dono** e **decisões do construtor**, separadas.
- **Objetivos da fundação**: o que uma pessoa consegue fazer quando ela termina.
- **Fora do escopo**: o que fica para depois.
- **Antiobjetivos**: o que seria um fracasso mesmo funcionando.
- **Arquitetura** e **regras de forma** (capítulo 05).
- **Erros que esta fundação fecha**: uma linha por lição de `licoes.md`.

Três cuidados, os três pagos no segundo produto:

- **Só leva a marca do dono o que ele decidiu de fato.** Lá, o dono aprovou as decisões numa
  conversa e não leu o documento. O documento diz isso na primeira linha, e é o certo: o resto
  fica marcado como do construtor, para ser revisto.
- **A tabela de erros diz como cada um é cobrado, com o caminho.** Duas das catorze linhas
  afirmavam uma cobertura de CI que não existia, e só a revisão fria viu.
- **Ausência também se escreve.** O que o produto não vai ter na fundação entra em "fora do
  escopo". O que não entra ali vira dúvida: é escolha ou esquecimento?

Os antiobjetivos são a seção que mais orienta. Eles viram teste e critério de revisão.

### 4. Contratos

Quando várias peças vão ser construídas ao mesmo tempo, os formatos entre elas (tabelas,
interfaces, eventos, rotas, variáveis) são escritos antes, num lugar só. Quem muda um contrato
muda ali primeiro.

**Limite conhecido:** contrato escrito não basta. No segundo produto os contratos existiam e os
defeitos graves ficaram exatamente na emenda entre as peças. É para isso que existe a fase 6.

### 5. Construção

A fábrica entra no primeiro commit: o documento de autoridade para assistentes de código, as
cercas, o CI, o instalador, a varredura de segredo, o arquivo de créditos. Uma regra que entra
tarde encontra código que já a viola, e vira uma lista de exceções.

**Construção em paralelo, com vários agentes.** O que funcionou:

- cada agente tem um território de arquivos que não se sobrepõe ao de outro;
- agente não faz commit. Só o orquestrador, peça por peça;
- cada agente relê a própria diferença antes de entregar;
- quem implementa não verifica.

Com isso, três agentes interrompidos no meio foram retomados sem perda. E paralelismo demais na
mesma máquina deixou as suítes dez vezes mais lentas: há um teto, e ele é da máquina.

**Revisão de segurança a cada commit.** Foi a segunda maior fonte de correções do segundo
produto, atrás só da revisão fria. Ela tem um modo de falha: três rodadas seguidas no mesmo
ponto, cada remendo criando o achado seguinte. A regra que encerrou o ciclo:

> No segundo achado sobre a mesma peça, pare de remendar. Decida o princípio e escreva um
> registro de decisão.

### 6. Prova montada

Roda-se o sistema inteiro, ligado, pelas entradas que um usuário e um operador usam: a linha de
comando do instalador, as rotas reais, a tela. Não pelas funções, e não pelos testes.

Regras que saíram daqui:

- **Um caminho de ponta a ponta roda sem credencial nem serviço externo.** O produto tem um modo
  simulado da sua dependência mais cara.
- **A resposta simulada tem o formato do contrato real.** Formato inventado esconde o defeito.
- **O teste imita o uso real, inclusive a forma de entrega.** Um teste do script de entrada
  passava com e sem a proteção que devia provar, porque entregava o script por arquivo, e o uso
  real é por cano. Sabotagem que não derruba o teste revela um teste fraco.

**Esta fase se repete depois da fase 7.** No segundo produto, a segunda rodada, feita depois
das correções da revisão fria, achou um defeito novo: a tela dizia "aplicado" sem ler a
resposta.

### 7. Revisão fria

Um revisor que não participou da construção e não recebe o contexto do construtor lê o
repositório para responder uma pergunta: **eu lançaria isto amanhã?** O parecer separa o que
bloqueia o lançamento, o que é importante, o que é menor e o que é suspeita não confirmada.

No segundo produto, com mais de seiscentos testes verdes, a revisão fria achou dois
bloqueadores: uma capacidade central que não funcionaria em nenhuma instalação padrão, e um
controle legal anunciado como "sempre" que vinha ausente. Os dois moravam entre peças, e entre
o que a documentação dizia e o que o código fazia.

O que a revisão fria procura, na ordem em que mais rende:

1. Documento que afirma o que o código não faz.
2. Capacidade anunciada sem caminho para funcionar: ninguém grava o dado de que ela depende.
3. Mensagem de sucesso emitida sem conferência.
4. Teste que usa um substituto no lugar exato onde o defeito mora.
5. Cerca que guarda menos do que o texto diz que ela guarda.

A lista de [`conformidade.md`](../conformidade.md) é o roteiro dela.

### 8. Instalação real

Instala-se numa VPS, pelo caminho que o README ensina.

No segundo produto, essa instalação achou um defeito que nenhum levantamento, teste ou revisão
previu: um serviço não conseguia ler o que o instalador gravava. A causa imediata foi o próprio
operador, que restringiu as permissões padrão da sessão para proteger um arquivo de senha; o
instalador herdou. Um servidor endurecido teria o mesmo efeito. A regra que saiu está no
capítulo 11.

**O que ainda não foi provado em nenhum produto,** e é o que esta fase pede:

- a instalação num servidor recém-criado. A do segundo produto foi numa máquina de teste
  compartilhada, com outros sistemas e um proxy já ocupando as portas;
- o caminho com perguntas no terminal. Rodou-se o modo sem perguntas;
- uma atualização entre duas versões publicadas.

**O que o segundo produto pagou por inverter a ordem:** o repositório foi publicado antes desta
fase, e o defeito ficou no ar até ser corrigido. A publicação é a fase 10.

Outras duas regras da mesma instalação:

- **Sem domínio, o painel não fica exposto.** A primeira instalação deixou a tela de login na
  internet sem conexão segura. O instalador passou a oferecer o modo só local.
- **Credencial é gerada na máquina de destino,** num arquivo que só o administrador lê. Nunca
  escrita numa conversa.

### 9. O dono usa

O dono tenta fazer, sozinho, o que o produto promete. É uma prova diferente das três anteriores.

No segundo produto, o dono tentando entrar achou o que nenhuma fase tinha achado: não havia
como criar uma conta nem como incluir a equipe.

### 10. Publicação e devolução

**Antes do primeiro envio ao repositório público:**

- varredura de segredo, de caminho da máquina local e de endereço de e-mail em todo o
  histórico;
- conferência da identidade de cada commit;
- regra do ramo principal, time de mantenedores, discussões e canal de relato privado de
  vulnerabilidade;
- o que o agente não consegue fazer fica numa lista para o dono. No segundo produto, uma
  permissão da organização exigia um nível de acesso que o agente não tinha.

**No primeiro dia de público,** o robô de dependências abre contribuições propondo versões
maiores. Tenha a regra pronta: o piso declarado de cada dependência vale.

**A devolução.** Toda fundação ensina alguma coisa que a Fábrica não sabia. Antes de encerrar,
o construtor escreve as lições novas em [`licoes.md`](../licoes.md): o que aconteceu, a regra,
como se cobra. Sem isso, o terceiro produto paga de novo o que o segundo já pagou.

## Configurado não é exercitado

Uma fundação termina com muita coisa escrita que nunca rodou: uma fila de merge que nenhuma
contribuição atravessou, um workflow de acolhida que nenhuma contribuição de fora disparou, um
passo de atualização que o CI pula até existir a primeira versão.

Isso é normal, e precisa estar dito. O produto mantém uma lista do que está configurado e ainda
não foi exercitado, e cada item sai dela na primeira vez em que roda de verdade. Sem a lista,
quem lê o repositório conclui que tudo foi provado.

## O que o método não resolve

- **Não substitui o julgamento sobre o que construir.** A triagem de ideias vem antes
  (capítulo 02).
- **Não garante que as provas achem tudo.** A revisão fria achou dois bloqueadores, a instalação
  achou um terceiro, o dono achou um quarto.
- **Foi executado uma vez, e fora de ordem.** A terceira fundação vai corrigir este capítulo.

## Origem

Desenho da fundação, registros de decisão, revisão fria e relato do construtor do DeskVoice;
histórico de decisões do DeskcommCRM.
