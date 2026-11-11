---
name: fabrica-fundar
description: 'Conduz a fundação de um produto open source novo pelo método da Fábrica DeskLabs, do zero até a publicação: entradas do dono, levantamentos, decisões e desenho, contratos, construção, prova montada, revisão fria, instalação real, uso pelo dono, publicação e devolução. Use quando a pessoa disser "usa a Fábrica", "vamos fundar um produto", "quero construir um sistema novo no modelo do Deskcomm/DeskVoice", "novo produto open source", "começa o projeto do zero pela fábrica", ou descrever uma ideia de produto e mencionar a Fábrica. Também retoma uma fundação em andamento: se existir docs/fundacao/ESTADO.md na pasta, continue de onde parou. Não use para auditar um produto que já existe (isso é fabrica-auditar).'
---

# Fundar um produto pela Fábrica

Você vai conduzir uma fundação. O método tem dez fases, cada uma com um portão. Você não pula
fase com o portão aberto, e não deduz o que é decisão do dono.

## Antes de tudo

**Ache a Fábrica.** Ela está em `${FABRICA_HOME:-$HOME/.desklabs/fabrica}`. Se a pasta não
existir, instale:

```bash
curl -fsSL https://raw.githubusercontent.com/DeskLabs-OpenSource/Fabrica/main/install.sh | bash
```

Rode o mesmo comando para atualizar antes de começar uma fundação nova: o manual muda a cada
fundação concluída.

**Leia, nesta ordem, antes de responder qualquer coisa de conteúdo:**

1. `manual/00-o-metodo.md`, inteiro.
2. `licoes.md`, inteiro. Não refaça esse levantamento.
3. `conformidade.md`. É a régua pela qual o produto vai ser medido no fim.

Os capítulos `manual/01` a `manual/12` você lê quando a fase pedir. Leia o capítulo inteiro, e
não só o trecho que parece servir: no segundo produto, uma doutrina foi escrita sem ler o
original e três leis ficaram de fora.

**Baixe a referência,** só para leitura:

```bash
git clone --depth 1 https://github.com/DeskLabs-OpenSource/DeskVoice.git "$HOME/.desklabs/referencia" 2>/dev/null \
  || git -C "$HOME/.desklabs/referencia" pull --ff-only
```

`referencia.md` diz onde está cada mecânica e, no fim, o que a referência ainda não cumpre e o
que ela tem configurado e nunca exercitou. Não copie essas partes.

## O estado da fundação

Uma fundação atravessa muitas sessões. O estado mora no repositório do produto, em
`docs/fundacao/ESTADO.md`: uma linha por fase, com o portão, se está fechado e o caminho do
artefato que o fecha. Crie o arquivo na fase 1 e atualize ao fechar cada portão.

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
2. Qual empresa este produto divulga? Qual o texto e o link da oferta? (Se o dono disser que é
   a mesma dos outros produtos, confirme o link.)
3. Em que organização do GitHub o repositório nasce, com que nome e licença?

Aplique o teste de entrada do capítulo 02 à ideia, e diga ao dono o resultado. A última
pergunta do teste é eliminatória: se o produto exigir o dono disponível todo dia, proponha uma
versão mais simples antes de seguir.

**Portão:** `docs/fundacao/entradas-do-dono.md`, com as respostas nas palavras do dono.

Não pergunte aqui sobre fronteira com outros produtos nem sobre o que nasce desligado. Essas
decisões dependem da fase 2.

### 2. Levantamentos

Quatro relatórios, mais um quinto se houver produto irmão. O primeiro já está pronto
(`licoes.md`). Os outros:

- **O que o público pede e do que reclama.** Pergunte ao dono onde está esse público e que
  acesso você tem.
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
- uma instalação serve uma organização ou várias (capítulos 07 e 08).

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

1. O repositório, na organização, com o documento de autoridade (`modelos/AGENTS-do-produto.md`),
   os arquivos de contribuição, as cercas de toda fundação (capítulo 05) e a varredura de
   segredo. Tudo isso antes da primeira linha de produto.
2. O núcleo: banco, porta única por organização, registro de eventos, fila.
3. O caminho central do produto, com o modo simulado.
4. O painel: saúde, configuração dos provedores, equipe, segurança.
5. O kit de instalação.
6. O CI inteiro e o corte de versão.

Se construir em paralelo: territórios de arquivos que não se sobrepõem, só você faz commit, e
quem implementa não verifica. Revisão de segurança a cada commit; no segundo achado sobre a
mesma peça, pare de remendar e escreva um registro de decisão.

Mantenha `docs/fundacao/nao-exercitado.md`: tudo o que está configurado e ainda não rodou de
verdade.

**Portão:** o comando de verificação local verde, e o mesmo comando é o que o CI roda.

### 6. Prova montada

Rode o sistema inteiro pelas entradas reais: a linha de comando do instalador, as rotas, a
tela. Use o modo simulado para o que precisa de credencial.

**Portão:** um caminho de ponta a ponta executado, com a saída lida e guardada.

### 7. Revisão fria

Dispare um agente novo, sem o seu contexto. Entregue a ele o caminho do repositório,
`conformidade.md` e a pergunta "você lançaria isto amanhã?". Não entregue as suas conclusões nem
a lista do que você acha que está frágil.

O parecer vai para `docs/fundacao/revisao-fria.md`, separado em: bloqueia, importante, menor,
suspeita não confirmada.

Feche cada bloqueador. Depois **repita a fase 6**.

**Portão:** nenhum bloqueador aberto, e a prova montada refeita depois das correções.

### 8. Instalação real

Numa VPS, pelo caminho que o README ensina. Pergunte ao dono em que máquina. O ideal, que
nenhum produto alcançou ainda: servidor recém-criado, caminho com perguntas no terminal, na VPS
do parceiro **e** em outra.

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

Antes do primeiro envio ao repositório público, cumpra a lista da fase 10 do método. Tornar o
repositório público e cortar a primeira versão são atos do dono: peça a confirmação.

Rode `fabrica-auditar` contra o produto e guarde o resultado.

Por fim, a devolução: escreva as lições novas em `licoes.md` da Fábrica, no formato das outras,
e abra uma contribuição no repositório da Fábrica. Onde o produto decidiu diferente do manual
por uma razão melhor, proponha a mudança no capítulo.

**Portão:** a contribuição de devolução aberta.

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
