# 01. Visão

> A visão é um arquivo, `VISION.md`, na raiz do repositório. É a fonte do posicionamento: tudo o
> que for público (README, site, descrições, vídeos) deriva dele. Este capítulo diz que perguntas
> ele responde e como saber se as respostas prestam.

## Por que escrever antes do código

No primeiro produto a visão existia, mas as fronteiras ficaram na cabeça do dono. O efeito foi
medido: dezenas de decisões "isso entra ou não entra?" esperaram por ele, uma a uma, e
contribuições boas esfriaram na fila. No segundo produto as fronteiras foram escritas na
fundação e viraram regras que a triagem aplica sozinha (capítulo 10).

Uma visão serve quando permite a outra pessoa, ou a um agente, dizer "não" a uma boa ideia sem
perguntar a ninguém.

## Decisões do dono

Só o dono responde. Sem elas, o construtor não começa.

1. **Qual é a tese?** Uma frase sobre o resultado que o sistema entrega, e não sobre o canal ou
   a tecnologia.
2. **Para quem?** Os três públicos, nesta ordem: quem usa, quem implementa para outros, quem
   contribui.
3. **O que seria fracasso, mesmo funcionando?**
4. **Qual é a fronteira com cada produto irmão?**
5. **O que fica fora para sempre**, por regra, e não por falta de tempo?

## As seções do `VISION.md`

As sete primeiras existem nos dois produtos. As quatro seguintes só no segundo, e são as que
mais renderam.

| Seção | O que responde |
|---|---|
| Frase-âncora | O que é, em uma linha, com as palavras que alguém digitaria numa busca |
| A tese | O resultado que o produto existe para entregar |
| O nome | O que o nome carrega |
| O que acreditamos | Crenças numeradas, cada uma capaz de recusar um pedido |
| Para quem | Os três públicos |
| Modelo do projeto, sem letra miúda | Quem paga o quê, e o que nunca será cobrado (capítulo 02) |
| Como falamos | As regras de comunicação |
| Norte | Onde se quer chegar, sem data |
| **A palavra central** | Uma palavra definida, com a peça do código que prova cada parte |
| **Relação com os irmãos** | O que se compartilha e o que não |
| **O que seria fracasso** | Os antiobjetivos |
| **Sistema vivo** | A doutrina herdada, nas palavras do dono (capítulo 09) |

## As regras

### 1. Defina o produto pelo resultado, não pelo canal

A tese do segundo produto é "a ligação não é o produto, é o começo de um trabalho". Ela decide o
que construir: um agente que atende bem e não faz nada está fora.

Todo produto da família é um sistema que trabalha, e não uma ferramenta que espera alguém usar.
O teste: descreva o que o sistema fez sozinho entre a entrada e o desfecho. Se a descrição
termina em "e aí o usuário...", ainda é uma ferramenta.

### 2. Cada crença tem uma peça no código

Escolha a palavra que resume o produto e escreva uma tabela: de um lado cada parte da
definição, do outro a peça do sistema que a torna verdadeira. Crença sem peça é enfeite, e vai
para o roadmap ou sai.

### 3. Escreva os antiobjetivos

"O que seria fracasso, mesmo funcionando" é a seção que mais orienta. Cada item vira um teste,
uma cerca ou um critério de revisão. Os do segundo produto:

- o agente ficar mudo sem avisar ninguém na tela;
- alguma capacidade exigir acesso ao servidor para ser ligada;
- a instalação dizer "pronto" com a capacidade central sem funcionar;
- o custo não aparecer ou não respeitar teto;
- o sistema facilitar abuso.

Os quatro primeiros valem para qualquer produto da família, trocando a capacidade. O quinto
muda com o domínio: descubra qual é o abuso do seu.

### 4. Separe três tipos de "não"

| Tipo | Onde fica | Exemplo |
|---|---|---|
| Fora do escopo desta fundação | Desenho da fundação | "Site e curso, depois" |
| Fora do horizonte por enquanto | `ROADMAP.md` | Uma integração sem caminho estável |
| Fora para sempre | Regra de produto, no documento de governança | "Nada que facilite disparo em massa" |

Todo item diz se é adiamento ou regra. Um "não" sem tipo é rediscutido a cada pedido.

### 5. O núcleo não conhece nichos

Regra de um ramo de negócio não entra no núcleo, nem atrás de configuração. O que varia por
ramo mora nas instruções do agente e em peças plugáveis.

*O porquê, escrito no segundo produto:* cada condição de nicho no núcleo é um caminho que todas
as outras instalações carregam e ninguém testa.

*O que custou no primeiro:* a fronteira entre núcleo e módulo foi decidida tarde, com
contribuições já esperando por ela, e o público passou a reclamar de sistema inchado. A fronteira
e o seu mecanismo existem antes da primeira contribuição externa.

Um caso de uso é exemplo, nunca definição. O primeiro produto nasceu descrito por um nicho e
precisou ser reposicionado.

### 6. Produto irmão é independente

Dois produtos da família compartilham criador, doutrina e fábrica. Não compartilham banco,
instalação nem dependência: cada um funciona sozinho.

**Quando uma capacidade merece virar produto, e não módulo.** O critério abaixo vem de um caso
só, a separação do segundo produto, e deve ser tratado como ponto de partida:

- ela tem uma borda técnica própria, que o produto hospedeiro não tem;
- ela tem ciclo de vida próprio (tempo real, por exemplo);
- ela tem risco legal próprio;
- quem só quer essa capacidade teria de instalar um produto inteiro que não vai usar.

Duas ou mais: é produto. Se o limite entre os dois não couber numa frase, não separe.

**Quem já instalou não perde capacidade por decisão de arquitetura.** Se um módulo vira produto,
o módulo continua funcionando onde está e depois vira um conector.

### 7. Estado real

Pronto, experimental e plano nunca aparecem na mesma lista. O README declara, por capacidade,
até onde ela foi provada: em simulação, em máquina real, em produção.

*O porquê:* para ninguém instalar esperando o que ainda não foi provado. No primeiro produto, o
público instalava uma versão que anunciava um recurso e não o encontrava.

### 8. Como falamos

- **Palavra-chave primeiro, jargão depois.** É assim que quem procura uma alternativa encontra o
  projeto, por busca ou por assistente de IA.
- **Mostrar, não descrever.** O produto precisa de algo que rode na frente de alguém sem
  credencial nem configuração.
- **Sem promessa de data.**
- **O teste da troca.** Se uma frase continua verdadeira trocando o nome do produto pelo de
  outro, ela é genérica e sai.

## Como saber que ficou pronto

- Uma pessoa de fora lê a frase-âncora e diz o que o produto faz.
- Cada crença já recusou, no papel, pelo menos um pedido plausível.
- Cada antiobjetivo aponta para o teste, a cerca ou o item de revisão que o guarda.
- A tabela da palavra central não tem linha sem peça.
- A fronteira com cada irmão cabe numa frase.

## O que este capítulo não resolve

- **Como validar que existe demanda antes de fundar.** No segundo produto o critério foi "o
  público pede exatamente o que falta no módulo existente". Não há método para um produto sem
  antecessor.
- **Quando rever a visão, e como registrar uma mudança de rumo.**
- **Como escolher o nome.**

## Origem

`VISION.md` dos dois produtos; registro de decisão `0001` e documento de governança do
DeskVoice; doutrina de extensões do DeskcommCRM.
