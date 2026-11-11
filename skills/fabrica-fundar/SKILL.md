---
name: fabrica-fundar
description: 'Conduz a fundação de um produto open source novo pelo método da Fábrica DeskLabs, do zero até a publicação: entradas do dono, levantamentos, decisões e desenho, contratos, construção, prova montada, revisão fria, instalação real, uso pelo dono, publicação e devolução. Use quando a pessoa disser "usa a Fábrica", "vamos fundar um produto", "quero construir um sistema novo no modelo do Deskcomm/DeskVoice", "novo produto open source", "começa o projeto do zero pela fábrica", ou descrever uma ideia de produto e mencionar a Fábrica. Também retoma uma fundação em andamento: se existir docs/fundacao/ESTADO.md na pasta, continue de onde parou. Não use para auditar um produto que já existe (isso é fabrica-auditar).'
---

# Fundar um produto pela Fábrica

Você vai conduzir uma fundação. O método tem dez fases, cada uma com um portão. Você não pula
fase com o portão aberto, e não deduz o que é decisão do dono.

## Antes de tudo

**Ache a Fábrica.** Ela está em `${FABRICA_HOME:-$HOME/.desklabs/fabrica}`. Se você está lendo
este arquivo de dentro de um clone dela, use esse clone. Se não há nenhum dos dois, instale:

```bash
curl -fsSL https://raw.githubusercontent.com/DeskLabs-OpenSource/Fabrica/main/install.sh | bash
```

Rode o mesmo comando para atualizar antes de começar uma fundação nova: o manual muda a cada
fundação concluída.

**Leia, nesta ordem, antes de responder qualquer coisa de conteúdo:**

1. `manual/00-o-metodo.md`, inteiro.
2. `licoes.md`, inteiro. Não refaça esse levantamento.
3. `conformidade.md`. É a régua pela qual o produto vai ser medido no fim.

Os capítulos `manual/01` a `manual/12` são leitura obrigatória, na fase indicada abaixo. Leia
cada capítulo inteiro, e não só o trecho que parece servir: no segundo produto, uma doutrina foi
escrita sem ler o original e três leis ficaram de fora.

| Fase | Capítulos a ler antes de agir |
|---|---|
| 1 | 01 e 02 |
| 2 | 03 e 09 |
| 3 | 04, 07, 08, 10 e 12 (as seções "Decisões do dono" e "Decisões a registrar" de cada um) |
| 5 | 04 a 12, inteiros, antes de construir a parte de cada um |
| 8 | 11, de novo |
| 10 | 10 e 12, de novo; 13 e 14 |

**Baixe a referência,** só para leitura:

```bash
git clone --depth 1 https://github.com/DeskLabs-OpenSource/DeskVoice.git "$HOME/.desklabs/referencia" 2>/dev/null \
  || git -C "$HOME/.desklabs/referencia" pull --ff-only
```

`referencia.md` diz onde está cada mecânica e, no fim, o que a referência ainda não cumpre e o
que ela tem configurado e nunca exercitou. Não copie essas partes.

## O estado da fundação

Uma fundação atravessa muitas sessões. O estado mora na pasta do produto, em
`docs/fundacao/ESTADO.md`: uma linha por fase, com o portão, se está fechado e o caminho do
artefato que o fecha. Na fase 1, crie a pasta do produto, rode `git init` nela e crie o arquivo.
O repositório fica só na máquina até a fase 10, a não ser que o dono peça um repositório
privado antes.

Se o arquivo já existe quando você é chamado, não recomece: leia, confira que os artefatos
citados existem e continue da primeira fase aberta.

Tudo o que a fundação produz fica em `docs/fundacao/`:

| Arquivo | Fase |
|---|---|
| `ESTADO.md` | todas |
| `entradas-do-dono.md` | 1 |
| `levantamentos/` | 2 |
| `desenho.md` | 3 |
| `contratos.md` | 4 |
| `revisao-fria.md` | 7 |
| `instalacao-real.md` | 8 |
| `uso-pelo-dono.md` | 9 |
| `nao-exercitado.md` | 5 em diante |

Levantamento que contém fala de pessoas reais (comentários, mensagens de comunidade) não entra
no repositório. Fica numa pasta `_privado/` listada no `.gitignore`, e o relatório público leva
só os temas e as contagens.

## As fases

### 1. Entradas do dono

Pergunte só o que nenhuma pesquisa responde. Uma pergunta de cada vez, em linguagem simples:

1. Que trabalho o sistema faz sozinho, e quem ganha com isso?
2. Qual empresa este produto divulga? Qual o texto e o link da oferta? Se o dono disser que é
   a mesma dos produtos anteriores, pegue o texto e o link no README da referência e confirme
   com ele. Se houver mais de um parceiro, anote o papel de cada um. Se o dono disser que não
   há parceiro, registre isso: os itens de parceiro da conformidade ficam "não se aplica".
3. Em que organização do GitHub o repositório vai morar, com que nome e licença?

Aplique o teste de entrada do capítulo 02 à ideia, e diga ao dono o resultado. O teste é
triagem, e não nota: um "não" nas quatro primeiras perguntas é dito ao dono com a consequência,
e ele decide. A última é eliminatória: se manter o produto exigir o dono do projeto disponível
todo dia, proponha uma versão mais simples antes de seguir.

**Portão:** `docs/fundacao/entradas-do-dono.md`, com as respostas nas palavras do dono.

Não pergunte aqui sobre fronteira com outros produtos nem sobre o que nasce desligado. Essas
decisões dependem da fase 2.

### 2. Levantamentos

Quatro relatórios, mais um quinto se houver produto irmão. O primeiro já está pronto
(`licoes.md`). Os outros:

- **O que o público pede e do que reclama.** Pergunte ao dono onde está esse público e que
  acesso você tem. Se o produto não tem antecessor, leia as issues e as avaliações de dois ou
  três produtos que resolvem o mesmo problema, e marque o relatório como evidência indireta.
- **A stack do domínio,** pelos critérios do capítulo 03, na ordem. Cada afirmação marcada como
  fato lido, estimativa ou não verificado, com a data.
- **O que a lei e o mercado do domínio impõem.** As quatro perguntas de domínio do capítulo 09.
- **O que já existe num produto irmão** e pode ser trazido.

Pode delegar cada um a um agente em paralelo. Cada relatório termina com "lido de fato" e
"inferido ou não lido".

**Portão:** os relatórios em `docs/fundacao/levantamentos/`.

### 3. Decisões e desenho

Apresente ao dono, de uma vez, as decisões que dependem da evidência, cada uma com opções, o
custo de cada opção e a sua recomendação. No mínimo:

- a fronteira com cada produto irmão (capítulo 01, regra 6);
- a peça central da stack (capítulo 03);
- o que nasce desligado e em que condição se liga (capítulo 09);
- uma instalação serve uma organização ou várias (capítulos 07 e 08);
- a direção visual, em uma frase (capítulo 04);
- quem mantém e quem revisa (capítulo 10);
- haverá marca própria para quem revende (capítulo 02);
- o nível de cada configuração: da instalação, da organização ou da unidade (capítulo 08).

Onde o dono não tiver opinião, a sua recomendação vale e fica marcada como do construtor.

Depois escreva `docs/fundacao/desenho.md` a partir de `modelos/desenho-da-fundacao.md`. Marque
com **[dono]** só o que o dono decidiu de fato, e com **[construtor]** todo o resto.

A tabela "erros que esta fundação fecha" tem uma linha para **cada** lição de `licoes.md`. Para
cada uma: a regra aqui e o caminho do que a cobra, ou "não se aplica" com o motivo, ou "ainda
não cobrado".

Escreva também, nesta fase: `VISION.md`, o documento de governança e um registro de decisão por
escolha estrutural, a partir dos modelos.

**Portão:** as decisões aprovadas pelo dono, e o desenho dizendo, na primeira linha, como foi
aprovado.

### 4. Contratos

`docs/fundacao/contratos.md`: tabelas, interfaces, eventos, rotas e variáveis entre as peças.

**Portão:** o arquivo existe e cada peça do desenho aparece nele.

### 5. Construção

Na ordem:

1. O documento de autoridade (`modelos/AGENTS-do-produto.md`), os arquivos de contribuição, as
   doutrinas (as herdadas e as do domínio, capítulo 09), as cercas de toda fundação
   (capítulo 05) e a varredura de segredo. Tudo isso antes da primeira linha de produto.
2. O núcleo: banco, porta única por organização, registro de eventos, fila.
3. O caminho central do produto, com o modo simulado.
4. O design system: direção, proibições com cerca, tokens (capítulo 04).
5. O painel: saúde, configuração dos provedores, equipe, segurança (capítulos 06 e 08).
6. O kit de instalação (capítulo 11).
7. O CI inteiro, e os workflows de imagens e de corte de versão (capítulo 12). Eles ficam
   escritos e entram em `nao-exercitado.md`: só rodam depois da publicação.
8. As skills embutidas do produto e os guias: custos, implementador, primeira ação útil
   (capítulos 02 e 10). A skill de instalação, o README e o documento de autoridade começam
   pelo passo zero do capítulo 02, regra 14: quem chega com um assistente e ainda não tem
   servidor encontra o parceiro, declarado.
9. A porta de entrada que roda no computador da pessoa, antes do servidor (capítulo 11).

Se construir em paralelo: territórios de arquivos que não se sobrepõem, só você faz commit, e
quem implementa não verifica.

Revisão de segurança a cada commit: use a revisão de segurança do seu assistente, se ele tem
uma, ou dispare um agente só para isso com a diferença do commit. No segundo achado sobre a
mesma peça, pare de remendar e escreva um registro de decisão.

Mantenha `docs/fundacao/nao-exercitado.md`: tudo o que está configurado e ainda não rodou de
verdade.

**Portão:** o comando de verificação local verde, e o mesmo comando é o que o CI roda.

### 6. Prova montada

Rode o sistema inteiro pelas entradas reais: a linha de comando do instalador, as rotas, a
tela. Use o modo simulado para o que precisa de credencial.

**Portão:** um caminho de ponta a ponta executado, com a saída lida e guardada.

### 7. Revisão fria

Dispare um agente novo, sem o seu contexto. Se o seu assistente não tem subagentes, peça ao
dono para abrir outra sessão e colar o pedido. Entregue a ele o caminho do repositório,
`conformidade.md` e a pergunta "você lançaria isto amanhã?". Não entregue as suas conclusões nem
a lista do que você acha que está frágil.

O parecer vai para `docs/fundacao/revisao-fria.md`, separado em: bloqueia, importante, menor,
suspeita não confirmada.

Feche cada bloqueador. Depois **repita a fase 6**.

**Portão:** nenhum bloqueador aberto, e a prova montada refeita depois das correções.

### 8. Instalação real

Numa VPS. Pergunte ao dono em que máquina. O ideal, que nenhum produto alcançou ainda: servidor
recém-criado, caminho com perguntas no terminal, na VPS do parceiro **e** em outra.

O repositório ainda não é público, então a linha única do README não funciona nesta fase. Leve
o código para a VPS por cópia (um pacote do `git archive`, por exemplo) e rode o instalador a
partir dali: é o mesmo instalador, e só a entrada de uma linha fica sem prova. Como ainda não
há imagem publicada, construa as imagens na VPS com a saída de emergência do arquivo de
composição. As duas coisas vão para `nao-exercitado.md`, e são as primeiras a exercitar depois
da publicação.

Gere as credenciais na máquina de destino. Não as escreva na conversa.

Registre em `docs/fundacao/instalacao-real.md` o que foi feito, em que máquina, por que caminho,
e o que **não** foi provado.

**Portão:** a instalação funcionando, com evidência. Todo defeito achado vira correção e lição.

### 9. O dono usa

Peça ao dono para fazer, sozinho, o que o produto promete: entrar, configurar, incluir alguém da
equipe, ver o trabalho acontecer. Anote onde ele travou.

**Portão:** `docs/fundacao/uso-pelo-dono.md`, e os travamentos corrigidos ou escritos em "fora
do escopo".

### 10. Publicação e devolução

Na ordem:

1. Rode `fabrica-auditar` contra o produto. **Item de nível F não conforme impede a
   publicação.** As saídas: corrigir, registrar a decisão diferente, ou um pedido de decisão em
   que o dono aceita publicar com o item aberto. "Não medido" é listado, e não impede.
2. Cumpra a lista "antes do primeiro envio" da fase 10 do método.
3. Criar o repositório público e cortar a primeira versão são atos do dono: peça a
   confirmação. Ao criar, aplique a regra do ramo principal.
4. Abra uma sessão nova de assistente, sem contexto, com o endereço do repositório e o pedido
   "me ajuda a instalar, ainda não tenho servidor". Ela precisa chegar ao parceiro e dizer que
   o link é de parceria. Se não chegar, corrija os três lugares do passo zero.
5. Logo depois de publicar, exercite o que estava esperando: a linha única de instalação, a
   publicação de imagens, o corte da primeira versão, a instalação a partir da imagem
   publicada. Cada um sai de `nao-exercitado.md` quando rodar.
6. A devolução. Clone a Fábrica numa pasta de trabalho separada (nunca edite a cópia instalada
   em `~/.desklabs/fabrica`: a atualização dela deixaria de funcionar). Escreva as lições novas
   em `licoes.md`, no formato das outras, e abra uma contribuição. Onde o produto decidiu
   diferente do manual por uma razão melhor, proponha a mudança no capítulo.

7. O que falta para divulgar. É a tabela "o que todo produto tem na divulgação", do capítulo
   00, e são os itens de nível L da conformidade: a atualização pela tela, o site, a
   identidade, a equipe de agentes que mantém o projeto (capítulo 14). Meça de novo com
   `fabrica-auditar`. Divulgar é ato do dono.

**Portão:** o produto público, com a primeira versão, os itens de nível L conformes ou
decididos, e a contribuição de devolução aberta.

## O que você não faz

- Não escolhe o parceiro, a licença, a fronteira com outro produto nem uma versão maior.
- Não trata "não provado" do manual como regra. Decida, registre e devolva o resultado.
- Não pula as fases 7, 8 e 9 porque os testes estão verdes.
- Não herda a stack do produto anterior sem aplicar os critérios.
- Não deixa decisão esperando o dono sem padrão: use `modelos/pedido-de-decisao.md` e siga com
  o que não depende dela.
- Não publica informação comercial nem fala de pessoas reais.
- Não diz "funciona" sem ter rodado e lido a saída.

## Como falar com o dono

Ele pode não ser programador. Diga o resultado, e não o mecanismo. Uma recomendação com o
porquê em uma linha vale mais que um cardápio. Quando precisar de uma decisão, uma pergunta
clara, com o que acontece em cada resposta.
