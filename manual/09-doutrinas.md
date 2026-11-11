# 09. Doutrinas

> A pasta de doutrinas guarda as leis do produto: o que pode, o que não pode e por quê. Este
> capítulo diz o que é uma doutrina, que forma ela tem, quais todo produto herda e como
> descobrir as do seu domínio.

## O que é cada tipo de documento

| Documento | Responde | Muda quando |
|---|---|---|
| **Doutrina** | Qual é a lei, por que ela existe e o que a cobra | A lei muda |
| **Registro de decisão** | Que alternativas foram recusadas, e em que condição se reveria | Nunca. Uma decisão nova substitui a antiga |
| **Guia** | Como se faz uma tarefa | O procedimento muda |
| **Regra de negócio** | Como o produto se comporta num caso | O produto muda |
| **Documento de governança** | Quem decide o quê, e o que se decide sem o dono | Os papéis ou as regras de produto mudam |

Mudou uma lei? A doutrina, o registro de decisão e o guia que dependem dela são atualizados na
mesma mudança. Doutrina que diverge de si mesma deixa de ser consultada em uma semana.

## O que entra como doutrina

Duas perguntas. As duas com "sim":

1. **Dá para escrever a verificação?** Um teste, ou uma pergunta de revisão com resposta
   objetiva.
2. **Violar é defeito, e não preferência?**

Fica de fora, de propósito: estilo de código, meta de cobertura de teste, escolha de stack. Uma
doutrina que fixa um framework morre com ele.

E toda doutrina nasce de um erro medido. O caso que a originou está escrito nela, para que quem
lê reconheça a situação, e não só a regra.

## A forma

O modelo está em [`modelos/doutrina.md`](../modelos/doutrina.md). As partes:

1. **Uma linha:** "Lei sobre X".
2. **O princípio, como pergunta.** "Quando isto muda, quem paga a construção?" "O que o
   operador precisa fazer?" A pergunta resolve o caso que ninguém previu.
3. **O caso que originou.**
4. **A régua,** em tabela.
5. **Como se cobra.** O caminho da cerca ou do teste, ou a frase "não há cerca; cobra-se na
   revisão".
6. **Exceções,** cada uma com motivo.

Quando uma doutrina cresce, ela se divide em **lei curta** e **manual**. O manual tem duas
partes: o princípio, sem nomes próprios, e a aplicação de referência, que cita os artefatos do
produto. A lei vence o manual.

## Os três modos de falha de uma doutrina

| Falha | Como aparece | Defesa |
|---|---|---|
| Inflação | Tudo vira doutrina, e ninguém lê | As duas perguntas de entrada |
| Divergência | O texto diz uma coisa e o código faz outra | Cerca, ou comando no lugar da afirmação |
| Cerimônia | A lista é preenchida sem pensar | Toda resposta nomeia um artefato concreto. "Nenhum" vale, com justificativa |

## As doutrinas que todo produto herda

| Doutrina | A lei | Capítulo |
|---|---|---|
| Sistema vivo | Uma demanda é responsabilidade do sistema até o desfecho registrado. Nenhuma peça é ilha | abaixo |
| Destrutivo pede confirmação | O que apaga mostra antes o alvo e o que vai junto. Vale para tela, script e agente | abaixo |
| Trabalho de agentes no repositório | Cópia descartável, caminho absoluto, quem implementa não verifica | abaixo |
| Cercas | Toda regra de forma é um teste com dono, motivo e data | 05 |
| Um caminho de schema | Instalar é aplicar todas as migrations | 05 |
| Um arquivo por peça | Peça nova é arquivo novo | 05 |
| Isolamento | Toda tabela tem organização, e há uma porta só | 07 |
| Empacotamento | Nada se constrói na máquina do cliente | 12 |
| Versionamento | O número responde ao que o operador precisa fazer | 12 |
| Prova em par | Só para produto com agente de IA que usa ferramentas | 05 |

**Um nome, um assunto.** Nos dois produtos existe um arquivo com o mesmo nome e leis
diferentes: num, é sobre o que o projeto opera e cobra; no outro, é sobre como agentes de código
trabalham. Produtos da família usam o mesmo nome para a mesma lei.

## Sistema vivo

É a doutrina que define a família. Vale a pena tê-la inteira aqui.

**A raiz.** Chegou uma demanda. O sistema responde pela linha do tempo inteira, até a resolução
ou um encerramento declarado.

**Os invariantes.** Sete, do primeiro produto:

1. **Duas conexões.** Toda peça tem o que a alimenta e o que ela alimenta, reais.
2. **Continuidade entre IA e humano, nas duas direções.** Onde a IA termina, o humano continua
   com contexto, e vice-versa. O que passa é um resumo estruturado, e não a conversa crua.
3. **Registro universal e visível.** O que aconteceu está na linha do tempo, e a linha do tempo
   está na tela.
4. **Nenhuma demanda sem próximo passo.** Algo impede que ela morra parada.
5. **Informação com propósito.** Para cada dado guardado ou mostrado: e daí?
6. **Toda configuração tem superfície.** Dá para ver, mudar e perceber quando falha.
7. **Todo laço se fecha.** Decisão automática tem um retorno que altera a decisão seguinte.

Dois, que o segundo produto acrescentou e que valem para qualquer sistema autônomo:

8. **Nada termina em silêncio.** Toda falha tem um aviso para quem está sendo atendido e um
   evento para a tela.
9. **Autonomia com limite visível.** Teto de custo, de duração, de ações. O limite aparece.

**A regra do tempo.** Observação em tempo real; ação no tempo do humano. O sistema nunca age
mais rápido do que alguém consegue interromper.

**As perguntas de toda mudança:**

1. Quem me alimenta?
2. Quem eu alimento?
3. Que registro eu emito?
4. Onde apareço na tela?
5. Por qual porta se chega em mim?
6. O que me impede de morrer parado?
7. Onde me configuram?
8. Qual a continuidade com o humano?
9. Qual o meu laço de retorno?
10. Atualizei o mapa?

Resposta que não nomeia um artefato concreto não vale.

**Como adotar num produto novo.** Nesta ordem:

1. O propósito, como estado final. "A chamada termina com um desfecho registrado."
2. A unidade de demanda. O que é "uma coisa a resolver" neste produto.
3. A fronteira de autoridade. O que o sistema decide sozinho e o que pede a um humano.
4. **Um** gate mecânico, para começar.
5. O par de medidas: uma de eficiência e uma de dano. Só a primeira leva a otimizar o errado.

**Em aberto.** O segundo produto reescreveu os invariantes para o seu domínio e deixou de fora
o laço de retorno, a informação com propósito e a regra do tempo, sem registrar o motivo. Até
haver um, os nove acima são o ponto de partida.

## Destrutivo pede confirmação

O que apaga, suspende ou sobrescreve mostra antes exatamente o que vai ser afetado e o que vai
junto. Vale para o botão da tela, para o script do instalador e para a ação de um agente.

Um pedido de aprovação humana tem um padrão para o caso de ninguém responder, e esse padrão é
definido pelo operador. Nunca por quem está sendo atendido nem pelo modelo (lição F5).

## Trabalho de agentes no repositório

1. Agente trabalha em cópia descartável, e nunca na pasta principal.
2. Comando destrutivo usa caminho absoluto conferido. Mudança de pasta que falha interrompe.
3. Revisor não roda comando que apaga.
4. Quem implementa não verifica.
5. O verificador mede sozinho, sem receber a conclusão.
6. Há sempre um papel instruído a contradizer.
7. O trabalho é publicado como rascunho ao fim da sessão.
8. Agente não decide versão maior, licença nem regra de produto.

Cada uma tem a sua lição no grupo H de [`licoes.md`](../licoes.md).

## As doutrinas do seu domínio

Todo domínio tem pelo menos uma lei própria, e ela costuma estar onde o produto pode causar
dano fora de si mesmo. Quatro perguntas para achá-la:

1. **Que abuso este produto facilita, se ninguém cuidar?** No primeiro: bloqueio do número por
   envio em excesso. No segundo: disparo de ligações em massa.
2. **Que canal ou recurso é regulado?**
3. **Que dado pessoal passa por aqui, e quem responde por ele?**
4. **Que ação o produto toma em nome de alguém, sem volta?**

Para cada resposta, uma doutrina com esta forma:

- **Nasce desligado.** O operador liga depois de declarar a finalidade.
- **O código impõe os limites.** Teto, janela de horário, lista de exclusão. Limite que só
  existe em documento não é limite.
- **Controle anunciado tem padrão que o cumpre.** No segundo produto, um guia dizia que um aviso
  legal era dado "sempre", e ele vinha vazio numa instalação nova (lição I3).
- **O que facilita o abuso não entra,** nem com justificativa de uso legítimo. Vira regra de
  produto no documento de governança.

### Dados pessoais

Vale para qualquer produto que guarde dado de pessoas, mesmo instalado por conta própria.

- Quem instala é o responsável pelos dados. Quem revende opera em nome dele. Documento legal
  nomeia o primeiro.
- Anonimizar é preferível a apagar, e não tem volta.
- Pedido de titular tem prazo, e cada passo fica registrado.
- Há retenção definida, executada por rotina, e não só declarada.
- Dado pessoal real nunca entra no repositório: nem em teste, nem em exemplo, nem em registro.

**Não provado:** nenhum dos dois produtos tem isto como doutrina própria. No primeiro está
espalhado no documento de autoridade; no segundo é um guia. A forma acima é proposta.

## Como saber que ficou pronto

- Cada doutrina diz o caso que a originou e como é cobrada.
- A lista de doutrinas do produto cabe numa tela.
- As quatro perguntas de domínio foram respondidas por escrito, inclusive com "nenhum".
- Uma skill de doutrina responde "isto é permitido?" apontando para o arquivo.

## Origem

Doutrinas e manual de sistema vivo do DeskcommCRM; pasta de doutrinas, registros de decisão e
documento de governança do DeskVoice; revisão fria do DeskVoice.
