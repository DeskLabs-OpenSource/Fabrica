# 05. Padrões de engenharia

> As regras de forma que valem para qualquer stack, como cada uma é cobrada, e o que a máquina
> não consegue cobrar. A ideia central: regra que depende de alguém lembrar acaba esquecida;
> regra que a máquina cobra precisa ter dono.

## O documento de autoridade

Um arquivo só, na raiz, é a autoridade para qualquer assistente de código: `AGENTS.md`. Os
arquivos específicos de cada ferramenta apenas o importam.

*O erro:* no primeiro produto há dois, um derivado do outro, e eles divergiram.

As seções, na ordem em que funcionaram no segundo produto:

1. Visão em um parágrafo, e a consequência que muda o jeito de trabalhar.
2. Stack, sem afirmar versão em prosa.
3. Mapa de pastas.
4. Comandos.
5. Convenções críticas, cada uma apontando para a cerca ou o teste que a cobra.
6. Antipadrões, **cada um com o erro que o originou**.
7. Situação → skill.
8. Definição de pronto, em duas listas.
9. Regra final: não invente.

## As regras de forma

Estas valem em todo produto. O mecanismo muda com a stack; a regra não.

| Nº | Regra | Lição |
|---|---|---|
| 1 | **Um caminho de schema.** Instalar é aplicar todas as migrations em ordem; atualizar é aplicar as que faltam. Nome por carimbo de tempo. Só para frente; publicada não se edita | A1, A2 |
| 2 | **Um arquivo por peça.** O que o produto tem em quantidade (ferramentas, rotinas, conectores, dicionários) é descoberto por pasta. Nenhuma lista central | C1 |
| 3 | **Uma porta de acesso ao dado por organização** (capítulo 07) | B1 |
| 4 | **Um ponto de escrita por entidade** | A6 |
| 5 | **Fila por notificação.** Quem consome trabalho é acordado; não consulta em laço. Trabalho periódico por natureza (sondar, agendar) usa um agendador declarado, com intervalo configurável, e não uma tarefa que se reenfileira | A5, F4 |
| 6 | **Configuração de operador tem tela.** Variável de ambiente só com padrão ou gerada pelo instalador | E1 |
| 7 | **Tudo tem registro**, com vocabulário fechado, e o registro aparece na tela | F1 |
| 8 | **Nenhum texto visível fora de dicionário** | capítulo 04 |
| 9 | **Teste sem relógio real, porta fixa ou fuso da máquina.** Código de produto recebe o relógio | D1 |
| 10 | **Sem escape de tipo e sem erro engolido** | prática de base |
| 11 | **Segredo de operador cifrado em repouso** | H7 |
| 12 | **Entrada externa validada**: corpo de rota, resposta de provedor, argumento vindo de modelo de IA | prática de base |
| 13 | **Identificadores em inglês; documentação e tela na língua do público, com tradução** | capítulo 12 |

A regra 2 tem um teste simples: se uma contribuição precisa editar uma lista para registrar uma
peça, a lista não deveria existir.

## Cercas

Uma cerca é um teste que guarda uma **regra de forma** do repositório, e não um comportamento
do produto. Ela só lê arquivos, roda rápido e mora numa pasta própria.

### Toda cerca tem dono, motivo e data de revisão

No cabeçalho do arquivo. Chegada a data, o dono renova, reescreve ou apaga. Uma cerca confere
que todas as cercas têm o cabeçalho.

*O erro:* no primeiro produto, uma trava sobreviveu ao trabalho que a justificava. Ninguém a
removia porque ninguém sabia por que existia nem de quem era. Cerca sem motivo escrito não pode
ser removida com segurança, e o que não pode ser removido só acumula.

A própria revisão segue a regra do "só mede o que mudou": cerca com a data vencida avisa na
contribuição e só reprova no ramo principal. A data venceu por causa do calendário, e não de
quem contribuiu.

### Quando criar

As três condições juntas:

1. O erro **já aconteceu**, aqui ou num produto irmão.
2. A regra é **mecânica**: decide-se olhando os arquivos.
3. A mensagem de reprovação consegue dizer **o que fazer**.

Se pede julgamento, não é cerca: vai para a lista "o que o CI não vê".

### Quando a cerca nasceria vermelha

O código existente já viola a regra. A dívida é congelada numa lista de exceções com motivo, e
a lista só pode diminuir.

### As cercas de toda fundação

Independem do produto:

- toda tabela tem organização;
- nome de migration é carimbo de tempo, sem repetição;
- nenhuma variável de ambiente sem padrão;
- acesso ao banco só pelo núcleo; porta de sistema só em arquivo listado;
- nenhum arquivo-índice nas pastas de peças;
- texto de tela só em dicionário;
- nenhum marcador de conflito esquecido;
- documento não aponta para arquivo que não existe;
- todo workflow declara as permissões que usa;
- um run por contribuição: o novo cancela o anterior;
- o workflow de acolhida não baixa código de fora;
- fragmento de versão bem formado;
- nenhum serviço de produção sem imagem publicada;
- espelho de skills em sincronia;
- toda cerca tem dono, motivo e data.

## O CI

### Check de contribuição só mede o que ela mudou

> O check de uma contribuição só pode ficar vermelho por causa do que ela mudou.

*O erro:* no primeiro produto, uma parte grande das contribuições ficou parada por vermelho de
causa alheia: o relógio do CI, uma colisão que o controle de versão não via, um limite
acumulado que estourou com a soma de várias contribuições. Quem contribuía não sabia se a culpa
era sua, e desistia.

Três consequências:

1. **Estado acumulado é check do ramo principal.** Tamanho total, soma de avisos, tempo da
   suíte. Se ficar vermelho, é trabalho de quem mantém e não bloqueia ninguém.
2. **Cada job termina dizendo de quem é a culpa.**
3. **Teste instável se conserta antes de qualquer outra coisa.**

O primeiro produto ainda reprova contribuição pelo tempo da suíte, com uma mensagem que diz
"isto não é defeito da sua contribuição". É o exemplo do que esta regra proíbe: se não é defeito
dela, não é check dela.

### Um check obrigatório, que agrega os outros

A proteção do ramo exige um check só. Job novo entra como dependência dele, e nunca na
configuração do repositório. O agregador roda sempre, e trata job pulado de forma explícita.

### O que o CI prova em toda fundação

| Job | Prova |
|---|---|
| Verificação | Lint, tipos, cercas, testes de unidade |
| Banco | Instalação do zero, e atualização a partir da última versão publicada, com dados |
| Ponta a ponta simulada | O caminho central do produto, sem credencial |
| Construção | O painel e as imagens constroem, **e sobem** |
| Instalador | Os scripts do kit |
| Segredos | Varredura no que mudou |

Um job que decide, pelo caminho alterado, o que precisa rodar evita gastar fila com o que a
contribuição não tocou.

Dois jobs que nenhum dos dois produtos tem ainda, e que os defeitos medidos pedem: testes que
dirigem o navegador nos caminhos de primeira impressão, e o instalador rodando de verdade, com
contêineres, num ambiente descartável. Sem o primeiro, "tem tela" só se prova à mão. Sem o
segundo, o caminho que grava, sobe e cria o usuário só roda na máquina de um cliente.

"Constroem e sobem": no primeiro produto, um processo ficou morto por várias versões porque
quebrava na partida, com o teste que o vigiava verde. Construir não é subir.

## Definição de pronto, em duas listas

**O que o CI reprova** e **o que o CI não vê**. Misturar as duas faz o contribuidor marcar tudo
de boa-fé e ser barrado por algo que ninguém contou a ele.

A segunda lista é onde moram os defeitos caros. O núcleo dela, para qualquer produto:

- A peça tem duas conexões?
- O que aconteceu aparece na linha do tempo, na tela?
- Se falhar, quem depende do sistema naquele momento percebe o quê? E a tela mostra o quê?
- Tem tela, ou pede acesso ao servidor?
- O custo é medido e respeita o teto?
- A ação destrutiva pede confirmação nomeando o alvo?
- É código de nicho?
- Quem já instalou precisa fazer alguma coisa?
- Trouxe algo de fora? Está nos créditos?
- Outra pessoa verificou?

## Prova

### Pela tela, em ambiente igual ao de quem instala

O que muda a experiência se prova dirigindo o navegador, num banco criado pelo caminho do
instalador, **com as configurações opcionais ausentes**. É o estado de uma primeira instalação,
e é onde moram os piores defeitos de primeira impressão. Chamada direta à API prova o servidor,
e não o que a pessoa vê.

Efeito externo se prova com um receptor de verdade.

A primeira impressão vem antes de tudo: instalação, primeiro acesso, primeira ação útil.

### Pelo caminho de produção

Dado inserido à mão prova a tela e não diz nada sobre a origem. Use o emissor real.

### Por sabotagem

Um teste novo só vale depois de ser visto falhando. Desfaz-se a linha do conserto, confere-se o
vermelho previsto, restaura-se. Em cópia descartável, e depois de restaurar confere-se que o
conserto está presente (lição H3).

### A sonda mede o caminho do usuário?

Toda mensagem de sucesso responde: o que eu conferi é o mesmo que a pessoa vai usar? O
instalador do primeiro produto chegou a dizer "concluído" com o site fora do ar.

### Em par, quando há um agente de IA no caminho

O caso de aceite pelo agente vem junto com a medição direta da ferramenta que ele usa, com o
mesmo texto. Sem o par, não se sabe se o erro é do modelo ou da ferramenta.

## Afirmações

- **Onde a afirmação puder virar comando, troque.** Uma auditoria do primeiro produto achou
  mais da metade das afirmações de estado desatualizadas. Número corrigido envelhece de novo;
  um "rode isto para saber" não.
- **Não afirme versão de dependência em prosa.**
- **Retrato tem data e identificador do commit**, e para de ser atualizado.
- **Rode a suíte, e não os checks de que você lembra.** O código de saída é a autoridade. Não
  corte a saída.

## Regra final: não invente

- **Capacidade.** Se o contrato não está no plano nem no código, ele não existe.
- **Estado.** "Funciona" e "passou" só depois de rodar e ler a saída.
- **Decisão.** O que é do dono está no documento de governança. Faltou regra? Pedido de
  decisão, com padrão.
- **Fato externo.** Preço, regulação e comportamento de provedor mudam. Fonte e data, ou "não
  conferi".
- **Na dúvida entre dois caminhos, o menor**, dizendo o que ficou de fora.

## Como saber que ficou pronto

- `AGENTS.md` existe e cada convenção aponta para o que a cobra.
- Cada cerca foi vista reprovando.
- Uma contribuição que não toca em nada sensível passa sem depender do estado do ramo
  principal.
- O comando de verificação local roda o mesmo que o CI.

## Origem

`AGENTS.md`, doutrina de cercas e CI do DeskVoice; doutrina, auditoria de afirmações e CI do
DeskcommCRM. A regra do check agregador e a seleção calculada de cercas já existem nos dois.
