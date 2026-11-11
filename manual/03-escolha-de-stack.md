# 03. Escolha de stack

> A stack não é herdada do produto anterior nem escolhida por gosto. Ela é a consequência de
> restrições, aplicadas numa ordem. Este capítulo dá as restrições, a ordem e a forma de
> registrar a escolha.

## O que é fixo em todo produto

Estas condições vêm do modelo de negócio (capítulo 02) e não se discutem por produto:

- **O destino é uma VPS.** Uma máquina Linux, sem GPU, do tamanho que o parceiro vende para
  quem está começando. O produto inteiro cabe nela.
- **Instala-se com um comando**, e quem instala não é programador.
- **Nada depende de uma conta em serviço de terceiros para subir.** Provedores que fazem parte
  do próprio trabalho do produto (um modelo de IA, uma operadora) são a exceção, e entram por
  tela, depois da instalação.
- **O código é aberto e pode ser revendido.** Toda peça da stack precisa permitir isso.
- **Muita gente contribui, quase sempre com um assistente de código.** A stack precisa ser
  legível por quem chega hoje.

Uma stack que viola qualquer uma dessas não é candidata, por melhor que seja.

## Os critérios, na ordem em que eliminam

Aplique na ordem. Cada critério corta candidatos, e o seguinte só olha para o que sobrou.

### 1. Não reconstrua o que o domínio já resolveu

Todo domínio tem uma parte difícil que alguém resolve há muito tempo. Descubra qual é e use a
peça madura para ela. O produto existe para o trabalho autônomo em cima disso, e não para
refazer a base.

*No segundo produto:* falar com operadoras de telefonia (registro, negociação de áudio,
travessia de rede, transferência) é a parte difícil. Recebê-la direto no código próprio
significaria reimplementar décadas de trabalho. Entrou uma central telefônica madura na borda.

### 2. Aceite o que o mercado do usuário realmente usa

A peça precisa funcionar com os fornecedores e as práticas do público do produto, e não com os
do país onde a ferramenta foi criada. Este critério só se responde com pesquisa.

*No segundo produto:* a opção mais moderna do mercado não aceitava uma forma de autenticação
que operadoras brasileiras usam. Para o público do produto, isso excluiria a operadora antes de
a conversa começar. Foi o primeiro de três motivos do descarte; os outros dois foram o suporte
mais atrasado na linguagem do projeto e mais um servidor para manter.

Marque o que é fato e o que é estimativa. Aqui, "a ferramenta não aceita" foi lido na
documentação dela; "muitas operadoras usam" foi estimativa do construtor, e nenhuma operadora
foi testada. Um critério que elimina candidatos merece o fato medido.

### 3. Uma linguagem só, e de preferência a do produto irmão

Cada linguagem a mais reduz quem consegue contribuir com o todo, e impede de trazer as
mecânicas já provadas (cercas, release, skills, instalador). Só adote uma segunda linguagem se
o critério 1 obrigar, e então isole-a atrás de um contrato estreito.

*No segundo produto:* o framework mais usado para o domínio era de outra linguagem. Seria a
segunda do projeto. Descartado.

### 4. Cada serviço a mais é memória, instalação e um ponto de falha

Conte os processos que a VPS vai rodar. Para cada um, pergunte se outro que já está lá resolve.
O estado do produto mora na máquina.

*No segundo produto:* o banco roda na própria VPS, e a mesma instância serve de fila, por
notificação. Um serviço de fila à parte e um banco na nuvem foram descartados. No primeiro
produto, a cota e a lentidão do banco na nuvem foram a reclamação operacional mais repetida, e
uma consulta em laço curto consumia recursos com o sistema parado.

### 5. A peça está viva, e a licença deixa distribuir

Confira na fonte, com data:

- a licença permite redistribuir e revender;
- instalar por conta própria não exige chave presa a domínio nem versão paga;
- o projeto recebeu mudanças recentemente e não avisa que está instável.

Dependência de terceiros é referenciada por versão fixa e nunca republicada pelo projeto.

*No segundo produto:* uma candidata exigia chave de licença para instalação própria; outra não
recebia mudança havia um ano; uma terceira avisava no próprio README que estava em reforma.

### 6. Prefira o que todo contribuidor já sabe ler

Entre duas opções que passaram nos critérios anteriores, vence a que pede menos conhecimento
novo de quem chega.

*No segundo produto:* mudança de banco é um arquivo de SQL. Uma ferramenta que compara o banco
com um modelo declarado foi descartada por pedir uma forma de pensar que a maioria não conhece.
É um argumento, e não uma comparação medida: nenhuma ferramenta dessas foi avaliada.

## A peça de risco precisa estar provada antes

Identifique a peça da qual o produto inteiro depende e que ninguém do projeto fez funcionar
ainda. Antes de fechar o desenho, uma de duas coisas é verdade:

- ela já rodou em produção num produto irmão, e é trazida de lá com crédito; ou
- ela é construída sozinha, no menor tamanho possível, e roda numa VPS.

*No segundo produto:* a ponte de áudio entre a central e o modelo de IA já rodava no primeiro
produto, e foi trazida de lá. Isso reduziu o risco, e não o eliminou: até a publicação, nenhuma
ligação real tinha passado por ela no produto novo. Trazer uma peça provada não dispensa
prová-la de novo no lugar novo.

**Não provado:** a segunda saída (construir a peça sozinha antes) ainda não foi exercitada em
nenhuma fundação. Está aqui por ser o complemento lógico da primeira.

## O ponto de partida, quando o domínio não pede outra coisa

É a stack do segundo produto. Ela não é obrigatória; é a que já tem as mecânicas da Fábrica
funcionando, e por isso é a mais barata de adotar.

| Camada | Ponto de partida | Troque quando |
|---|---|---|
| Linguagem | TypeScript estrito, uma versão de Node fixada | O critério 1 obrigar outra |
| Banco | Postgres na VPS | Quase nunca. Um arquivo local só serve se um único processo escreve |
| Fila | A notificação do próprio banco | O volume medido passar do que o banco aguenta |
| Painel | Um framework web com tela e API no mesmo processo | O produto não tiver tela de operador (raro) |
| Borda | Um proxy que emite certificado sozinho | A VPS já tiver um proxy; o instalador detecta |
| Empacotamento | Imagens publicadas pelo CI, orquestradas num arquivo de composição | Nunca construir na máquina do cliente (capítulo 12). A referência ainda não cumpre isto |
| Organização do código | Pacotes separados só quando cada um tem dois consumidores no primeiro dia | — |

## O que não muda com a stack

A escolha de stack decide o mecanismo. As regras de forma do capítulo 05 valem para qualquer
uma: um caminho só de schema, um arquivo por peça, uma porta única de acesso ao dado por
organização, configuração de operador pela tela, tudo com registro. Se a stack escolhida torna
alguma delas impraticável, ela está errada para a Fábrica.

## Como registrar

Cada escolha estrutural vira um registro de decisão, no formato de
[`modelos/registro-de-decisao.md`](../modelos/registro-de-decisao.md). O que não pode faltar:

- **as restrições que pesaram**, escritas antes da decisão;
- **cada alternativa descartada, com o motivo.** É a parte mais útil do registro: impede que a
  mesma discussão recomece a cada contribuidor novo;
- **os custos da decisão**, e não só os benefícios;
- **quem decidiu**: o dono ou o construtor.

A pesquisa que sustentou a escolha marca cada afirmação como fato lido, estimativa ou não
verificado, com a data.

## Antes de fechar, meça

Duas medições que a pesquisa não dá, e que a revisão fria do segundo produto apontou como
suspeitas em aberto:

- **O produto parado cabe na menor VPS que o parceiro vende?** Memória e disco, com tudo de pé e
  ninguém usando.
- **A atualização cabe nela?** Se algum passo constrói na máquina, mede-se o pico.

## Perguntas para o dono

Só duas, e só quando a pesquisa não decidir sozinha:

1. Existe uma peça de produto irmão que você quer ver reaproveitada?
2. Há um fornecedor do domínio que o seu público já usa e que o produto precisa aceitar?

## Origem

- Critérios 1 a 3 e a peça de risco: registro de decisão `0002` do DeskVoice e relato do
  construtor, que declarou que nada no primeiro produto orientava essa escolha.
- Critério 4: registro de decisão `0003` do DeskVoice; reclamações operacionais do DeskcommCRM.
- Critério 5: pesquisa de fundação do DeskVoice.
- Critério 6: registro de decisão `0005` do DeskVoice.
- Regra de dois consumidores: desenho da fundação do DeskVoice.
