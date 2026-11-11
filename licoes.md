# Lições

> O catálogo de erros já pagos e a regra que cada um gerou. Toda regra do manual aponta para
> uma linha daqui. Regra sem erro de origem não entra.

## Como ler

- **P1** é o primeiro produto (DeskcommCRM). **P2** é o segundo (DeskVoice).
- A coluna "Onde ver" aponta para a implementação de referência no repositório do P2, quando
  existe. **Ela mostra onde a peça está, e não que a peça já rodou.** O que a referência tem
  configurado e ainda não exercitou está em [`referencia.md`](referencia.md).
- Os erros estão descritos sem números e sem nomes: o que interessa é reconhecer a situação.

## Como acrescentar

Uma linha nova precisa de três coisas: o que aconteceu de fato, a regra que evita, e como a
regra é cobrada (uma cerca, um teste, um job, ou "revisão"). Se a cobrança é "revisão", a regra
também entra na lista "o que o CI não vê" do produto.

---

## A. Banco e schema

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| A1 | P1 mantinha dois retratos do banco: as migrations e um arquivo que o instalador aplicava. Eles divergiram, e mudanças chegavam a quem desenvolvia e não a quem instalava | Um caminho só de schema. Instalar é aplicar todas as migrations; atualizar é aplicar as que faltam | CI instala do zero e atualiza a partir da última versão | `docs/doctrine/um-caminho-de-schema.md` |
| A2 | Migrations numeradas em sequência: contribuições paralelas escolhiam o mesmo número | Nome por carimbo de tempo, nunca número sequencial | Cerca | `fences/migrations-are-timestamped-and-unique.test.ts` |
| A3 | Os testes só rodavam em banco novo. Uma mudança grande funcionava em instalação nova e quebraria toda instalação existente | O CI aplica a mudança sobre um banco da última versão, com dados | Job de CI | `docs/decisions/0005-um-caminho-de-schema.md` |
| A4 | Banco na nuvem como dependência: cota e lentidão foram a reclamação operacional mais repetida, e uma mudança do fornecedor atingiu dezenas de tabelas de uma vez | O estado mora na VPS. Nenhum serviço de terceiros é necessário para o sistema subir | Revisão; instalação real | `docs/decisions/0003-postgres-na-vps.md` |
| A5 | Um processo consultava a fila em laço curto e consumia recursos com o sistema parado | Fila por notificação. Sem consulta de intervalo curto | Revisão (ver F4) | `packages/core/src/queue.ts` |
| A6 | Um dado era gravado por vários caminhos com formatos diferentes, e um filtro novo quebrou uma função inteira por duas versões | Um ponto de escrita por entidade | Revisão | `AGENTS.md`, convenção 5 |

## B. Isolamento entre organizações

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| B1 | O isolamento dependia de cada caminho lembrar de filtrar a organização. Foi furado várias vezes, quase sempre por uma checagem esquecida | Uma porta única de acesso ao dado por organização. Ninguém filtra à mão | Cerca que reprova acesso direto fora do núcleo; teste de isolamento gerado para toda tabela | `docs/doctrine/isolamento.md` |
| B2 | O teste de isolamento cobria uma lista fixa de tabelas, e tabela nova ficava de fora | O teste é gerado a partir do catálogo do banco | Teste | `packages/core/test/isolation.db.test.ts` |
| B3 | P2: banco com várias organizações e tela de uma só. Recursos compartilhados entre organizações geraram três rodadas de correção de segurança | Quando um recurso é compartilhado e não se consegue provar a posse, falha fechado | Revisão; registro de decisão | `docs/decisions/0007-endereco-de-operadora-compartilhado.md` |
| B4 | O acesso que atravessa organizações se espalhou por arquivos de produto | Esse acesso só existe em arquivo listado, com motivo | Cerca com lista de permissão | `fences/system-access-allowlist.ts` |

## C. Colisão entre contribuições

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| C1 | Arquivos-índice que toda contribuição editava (dicionário único, lista de rotinas, manifesto). Duas contribuições que acrescentavam a mesma entrada mesclavam sem conflito e quebravam o ramo principal | Um arquivo por peça, descoberto por pasta. Nenhuma lista central | Cerca | `docs/doctrine/um-arquivo-por-peca.md` |
| C2 | Duas contribuições verdes separadas ficavam vermelhas juntas | Fila de merge: cada contribuição é testada sobre o estado em que vai entrar | Proteção do ramo | `GOVERNANCE.md` |
| C3 | Arquivos compartilhados viraram pedágio: cada linha neles pedia autorização do dono | Registro por arquivo; proteção só contra apagar | Desenho | — |

## D. CI e verificação

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| D1 | Contribuição boa ficava vermelha por causa alheia: o relógio, uma porta, o fuso, um teste dependente da hora | Teste não usa relógio real, porta fixa nem fuso da máquina | Convenção; revisão | `AGENTS.md`, convenção 10 |
| D2 | Um check cobrava do contribuidor um estado acumulado que só os mantenedores podiam resolver. Todas as contribuições abertas ficaram vermelhas juntas | Check de contribuição só mede o que ela mudou. Estado acumulado é check do ramo principal | Desenho do CI | `docs/doctrine/cercas.md` |
| D3 | O contribuidor via vermelho e não sabia se era culpa dele | Cada job termina dizendo se a causa está na contribuição ou fora dela | Desenho do CI | `.github/workflows/ci.yml` |
| D4 | Um limite de tempo declarado, e não medido, matava execuções saudáveis, que apareciam como "canceladas" | Limite de tempo vem de medição, com folga, e a mensagem diz que não é defeito da contribuição | Desenho do CI | — |
| D5 | A fila de CI entupiu pelo teto da conta pessoal | O repositório nasce numa organização. Um run por contribuição: o novo cancela o anterior | Cerca | `fences/workflows-cancel-superseded-runs.test.ts` |
| D6 | Uma trava sobreviveu ao motivo que a criou, valia só na máquina local e ninguém sabia de quem era | Toda cerca tem dono, motivo e data de revisão, e mora no CI | Cerca sobre as cercas | `fences/fences-have-owner-and-review-date.test.ts` |
| D7 | Regras escritas em prosa que nenhum job conferia | A definição de pronto tem duas listas: o que o CI reprova e o que o CI não vê | Documento de autoridade | `AGENTS.md`, "Definition of Done" |
| D8 | Um processo ficou morto por várias versões porque uma importação pesada quebrava a partida. O teste que o vigiava ficou verde | Teste de fumaça do processo real, e não de uma parte dele | Job de CI que sobe as imagens | — (a referência só constrói) |
| D9 | Documentos afirmavam cobertura que o CI não tinha | Toda afirmação "o CI prova X" aponta para o job. Prefira o comando à frase | Revisão fria | `manual/00-o-metodo.md`, fase 7 |

## E. Instalação e atualização

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| E1 | Ligar um recurso exigia editar arquivo no servidor. O recurso nascia quebrado para quem não sabia | Configuração de operador tem tela. Variável de ambiente só com valor padrão ou gerada pelo instalador | Cerca | `fences/env-vars-have-defaults.test.ts` |
| E2 | Backup dizia "concluído" sem parte dos dados; restauração dizia "restaurado" sem restaurar | "Sucesso" só depois de conferir. A restauração compara contagens | Teste do instalador | `install/restore.sh` |
| E3 | O atualizador que roda é o da versão antiga, e ninguém o testava contra a versão nova. Instalações ficaram presas na página de manutenção | O atualizador é testado. Atualização com backup antes, checagem de saúde depois e volta automática se quebrar | Job de CI | `install/update.sh` |
| E4 | Um serviço era construído na máquina do cliente e por isso nunca era atualizado | Nenhum serviço constrói na máquina do cliente. Todos são imagens publicadas pelo CI | Cerca | — (a referência ainda viola; capítulo 12) |
| E5 | Instalador acoplado ao parceiro e a uma arquitetura de processador | O mesmo comando em qualquer VPS. Imagens para as duas arquiteturas desde a primeira versão | Job de CI | capítulo 11 |
| E6 | A tela anunciou por dias uma versão que não estava no ar | A tela de versão lê o que está rodando, e não o que foi anunciado | Revisão | — |
| E7 | P2, primeira instalação real: a sessão de quem instalava tinha permissões padrão restritas, o instalador herdou, e um serviço não lia o que ele gravava. Um servidor endurecido teria o mesmo efeito | O instalador grava com permissão explícita tudo o que outro serviço vai ler. Não depende da configuração de quem baixou | Teste do instalador | `install/_common.sh` |
| E8 | P2: cada serviço estava de pé e a ligação entre eles não | A checagem de saúde confere a ligação entre as peças, e nunca resume tudo num "ok" | Teste do instalador | `install/test/07-healthcheck.sh` |
| E9 | P2: um comando chamado pelo instalador falhava de um jeito que o teste da função não via | O que o instalador chama é testado pela linha de comando | Teste do auxiliar; o comando real ainda só foi provado à mão | `apps/routines/src/cli/args.test.ts` |
| E10 | P2: os testes do instalador usavam um substituto do Docker, exatamente onde o defeito de E7 morava | A primeira instalação real é fase obrigatória, antes do lançamento | Método | `manual/00-o-metodo.md`, fase 8 |
| E11 | P2: a versão gravada pelo atualizador e a etiqueta publicada pelo CI tinham formatos diferentes. A atualização nunca usava a imagem publicada | O nome da imagem e o formato da etiqueta têm uma fonte só, lida pelos dois lados | Teste (a referência contornou publicando os dois formatos) | — |

## F. Sistema vivo

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| F1 | Uma capacidade inteira não devolvia o resultado ao resto do sistema, e o custo dela não entrava no limite de gasto | Toda peça tem duas conexões: o que a alimenta e o que ela alimenta. Todo custo é medido | Revisão | `docs/doctrine/sistema-vivo.md` |
| F2 | O agente ficava calado e ninguém era avisado | Nenhum caminho de erro termina em silêncio. Toda falha tem um aviso para quem está sendo atendido e um evento na tela | Revisão; antiobjetivo | `VISION.md` |
| F3 | P2: capacidades anunciadas sem caminho para funcionar. Nenhuma tela gravava o dado de que dependiam | Capacidade anunciada tem o caminho inteiro: quem grava o dado, quem dispara, onde aparece | Revisão fria | `apps/panel/src/app/api/v1/auth/me/route.ts` |
| F4 | P2: uma tarefa que se reagendava a cada poucos segundos era consulta em laço com outro nome | A regra de fila por notificação vale para o efeito, e não para o nome | Revisão fria | `apps/routines/src/routines/expire_approval.ts` |
| F5 | P2: quem estava sendo atendido conseguia induzir a resposta padrão de uma aprovação humana | O padrão de uma aprovação é do operador, e nunca de quem está do outro lado nem do modelo | Revisão | `packages/tools/src/approval.ts` |

## G. Governança e contribuição

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| G1 | O dono virou gargalo: centenas de decisões pequenas esperavam por ele | Regras de produto escritas, para a triagem decidir sozinha. Todo pedido de decisão traz o padrão que vale se ninguém responder | Documento de governança | `GOVERNANCE.md` |
| G2 | Contribuidores desistiram por silêncio | Acolhida automática em minutos, sem avaliar mérito, com prazo humano declarado | Workflow | `.github/workflows/welcome.yml` |
| G3 | O workflow de acolhida roda com permissão do repositório | Ele nunca baixa código da contribuição | Cerca | `fences/welcome-does-not-checkout.test.ts` |
| G4 | Código de terceiros entrou sem crédito, e isso virou reclamação pública | Arquivo de créditos desde o primeiro commit, atualizado na mesma mudança | Revisão | `CREDITS.md` |
| G5 | Dois documentos de autoridade para assistentes de código divergiram | Um documento só. Os outros apenas o importam | Desenho | `AGENTS.md`, `CLAUDE.md` |
| G6 | P2: o pré-voo do contribuidor media contra a referência errada para quem contribui de uma cópia | As ferramentas do contribuidor são testadas a partir de uma cópia de verdade | Prova à mão; sem teste automático | `.agents/skills/deskvoice-contribuir/scripts/` |
| G7 | Uma versão saiu com avisos rebaixados porque marcar "exige ação" forçaria um número maior | "O operador precisa fazer algo?" é um campo separado do número da versão | Cerca | `docs/doctrine/versionamento.md` |

## H. Operação com agentes de IA

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| H1 | Um agente apagou a pasta principal de trabalho, duas vezes. Um comando de mudança de pasta falhou e o comando destrutivo seguinte rodou no lugar errado | Agente trabalha em cópia descartável. Comando destrutivo usa caminho absoluto conferido. Revisor não roda comando que apaga | Doutrina | `docs/doctrine/operacao-de-agentes.md` |
| H2 | Trabalho válido ficou só no disco, em dezenas de pastas | Ao fim de cada sessão, o trabalho é publicado como rascunho | Doutrina | — |
| H3 | Um agente quebrou um conserto de propósito, para provar o teste, e publicou a versão quebrada | Prova por sabotagem só em cópia descartável. Depois de restaurar, confere-se a presença do conserto | Doutrina | — |
| H4 | Um número errado foi herdado por vários verificadores, porque todos receberam a conclusão junto com a tarefa | O verificador mede sozinho, sem receber a conclusão. Sempre há um papel instruído a contradizer | Doutrina; fase 7 do método | — |
| H5 | Uma rotina agendada rodou por semanas sem acesso ao que precisava, e não entregou nada | Automação agendada confere o acesso antes e avisa quando entrega zero | Revisão | — |
| H6 | Dois grupos de agentes mesclavam sem regra comum | Um único dono do merge, ou a regra imposta pela proteção do ramo | Proteção do ramo | `GOVERNANCE.md` |
| H7 | Segredo e dado pessoal foram parar no repositório público | Varredura de segredo no CI e antes do commit, desde o primeiro commit. Dados de teste são inventados | Job de CI; hook | `AGENTS.md`, antipadrão 10 |
| H8 | Quem implementa também verificava | Quem implementa não é quem verifica. Vale para pessoa e para agente | Governança | `GOVERNANCE.md` |

## I. Afirmações

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| I1 | A documentação afirmava como o mundo estava, e mais da metade das afirmações medidas numa auditoria estava desatualizada | Onde a afirmação puder virar um comando, troque. Um número corrigido envelhece de novo | Cerca: documento não aponta para arquivo que não existe | `fences/docs-point-to-existing-files.test.ts` |
| I2 | Documentos afirmavam versões de dependência que já tinham mudado | A versão exata é a do arquivo de dependências. Não se afirma em prosa | Convenção | `AGENTS.md`, seção "Stack" |
| I3 | P2: um guia de conformidade dizia "sempre" sobre um controle que vinha ausente por padrão | Controle legal anunciado tem valor padrão que o cumpre | Revisão fria | `apps/voice/src/call-session.ts` |
| I4 | P2: uma cerca guardava menos do que os documentos diziam | O texto descreve o que a cerca reprova de fato. A revisão fria confere | Revisão fria | `fences/system-access-is-allowlisted.test.ts` |

## J. Produto e comunicação

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| J1 | A fronteira entre núcleo e módulo foi decidida tarde, com contribuições esperando. O público reclamou de sistema inchado | A fronteira e o mecanismo existem antes da primeira contribuição externa. Código de nicho nunca no núcleo | Regra de produto | `GOVERNANCE.md`, regras 1 e 2 |
| J2 | Um recurso foi anunciado e quem atualizou não o encontrou | Pronto, experimental e plano nunca na mesma lista. O README diz até onde cada capacidade foi provada | Revisão | `README.md` |
| J3 | O parceiro de distribuição só foi informado ao construtor depois do lançamento | O parceiro é entrada obrigatória da fundação | Método | `manual/00-o-metodo.md`, fase 1 |
| J4 | O público pedia como começar e uma demonstração antes de instalar | O produto tem um modo simulado que roda sem credencial | Job de CI | `apps/voice/src/simulated-call.db.test.ts` |
| J5 | Custo de IA imprevisível foi reclamação recorrente | Custo por unidade de trabalho na tela, com teto | Antiobjetivo; revisão | guia de custos |

## K. Fundação

Lições da própria fundação do P2. Nenhuma tem cerca: são cobradas pelo método
([`manual/00-o-metodo.md`](manual/00-o-metodo.md)).

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| K1 | O repositório foi publicado antes da primeira instalação real. O defeito que ela achou ficou no ar até ser corrigido | A publicação vem depois da instalação real e do uso pelo dono | Método, fases 8 a 10 | — |
| K2 | A revisão de segurança entrou em três rodadas seguidas no mesmo ponto, cada remendo criando o achado seguinte | No segundo achado sobre a mesma peça, pare de remendar: decida o princípio e escreva um registro de decisão | Método, fase 5 | `docs/decisions/0007-endereco-de-operadora-compartilhado.md` |
| K3 | Um teste passava com e sem a proteção que devia provar, porque entregava o script por arquivo e o uso real é por cano | O teste imita o uso real. Sabotagem que não derruba o teste revela um teste fraco | Revisão | `install/test/10-get.sh` |
| K4 | Agentes de construção foram interrompidos no meio | Territórios de arquivos que não se sobrepõem; só o orquestrador faz commit; cada agente relê a própria diferença | Método, fase 5 | — |
| K5 | A tabela "erros que esta fundação fecha" afirmava cobertura de CI que não existia | Cada linha da tabela aponta para o job, o teste ou a cerca. Sem caminho, a linha diz "ainda não cobrado" | Revisão fria | `docs/specs/2026-11-10-fundacao-design.md` |
| K6 | Um levantamento não leu o corpo de uma doutrina, e três leis ficaram de fora do produto sem ninguém decidir | Todo levantamento declara o que não leu. O que entra por herança é lido inteiro antes | Método, fase 2 | — |
| K7 | Uma doutrina recebeu o nome de um arquivo do produto irmão que trata de outro assunto | Nome visto num inventário não diz o que o arquivo contém. Um nome, um assunto, na família inteira | Conformidade 9.9 | — |
| K8 | O dono aprovou as decisões numa conversa e não leu o documento | Só leva a marca do dono o que ele decidiu. O documento diz como foi aprovado | Método, fase 3 | `docs/specs/2026-11-10-fundacao-design.md` |
| K9 | A primeira instalação sem domínio deixou a tela de login exposta sem conexão segura | Sem domínio, o painel sobe só local | Teste do instalador | `install/install.sh` |
| K10 | O dono, ao tentar entrar, descobriu que não havia como criar conta nem incluir a equipe | "O dono usa o produto" é uma fase, distinta da revisão e da instalação | Método, fase 9 | — |
| K11 | Muita coisa foi escrita e nunca rodou: fila de merge, acolhida, passo de atualização, publicação de imagens | O produto mantém a lista do que está configurado e ainda não foi exercitado | Revisão | [`referencia.md`](referencia.md) |
| K12 | No primeiro dia de público, o robô de dependências propôs versões maiores que quebravam o piso declarado | A regra para atualização automática de dependência existe antes da publicação | Configuração do robô | — |
| K13 | As duas primeiras contribuições depois da fundação entraram com passagem de administrador, implementadas, verificadas e mescladas pela mesma sessão | A regra "quem escreve não aprova" vale desde a primeira contribuição, inclusive para o dono e para agentes | Proteção do ramo, sem exceção para administrador | `scripts/github/apply-ruleset.sh` |
