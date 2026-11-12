# Lições

> O catálogo de erros já pagos e a regra que cada um gerou. As regras do manual apontam para
> cá. Regra sem erro de origem não entra.

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
| E10 | P2: os testes do instalador usavam um substituto do Docker, exatamente onde o defeito de E7 morava. O caminho que grava, sobe e cria o usuário só rodava numa instalação real | O CI roda o instalador de verdade num ambiente descartável, e a primeira instalação real é fase obrigatória | Conformidade 11.21; método | `manual/00-o-metodo.md`, fase 8 |
| E11 | P2: a versão gravada pelo atualizador e a etiqueta publicada pelo CI tinham formatos diferentes. A atualização nunca usava a imagem publicada | O nome da imagem e o formato da etiqueta têm uma fonte só, lida pelos dois lados | Teste (a referência contornou publicando os dois formatos) | — |
| E12 | Um pedido de atualização pela tela foi aceito pelo agente do servidor e nunca concluído. Ficou preso para sempre, e nenhum pedido novo podia ser feito | Um pedido por vez, com prazo. Pedido aceito e não concluído vira falha visível | Conformidade 12.14 | — |
| E13 | O agente de atualização falhava ao falar com o aplicativo sem deixar rastro. O sintoma era "o botão de atualizar não aparece" | Falha de comunicação do agente fica num registro que persiste | Conformidade 12.15 | — |
| E14 | Quem instala não atualizava, porque atualizar pedia terminal | Atualização pela tela, com o aplicativo só registrando o pedido e um agente do kit executando | Conformidade 12.12, 12.13 | — |
| E15 | P2: as imagens publicadas pelo CI nascem privadas no registro. Sem alguém torná-las públicas, quem instala não baixa, e o instalador cai na construção local sem ninguém perceber | Depois da primeira publicação, confere-se que a imagem baixa sem credencial | Conformidade 12.16 | — |
| E16 | P2: o instalador escolhia a última versão publicada e baixava as imagens dela, mas quem tinha clonado à mão ficava com o código do topo do ramo principal | O código instalado é o da etiqueta da versão, em todo caminho de instalação | Conformidade 12.3 | — |
| E17 | P2: o passo que cria a etiqueta olhava só o último envio, e a fila de execuções guardava uma pendente por vez. Um envio logo depois do corte faria a versão nunca virar etiqueta, sem aviso | O corte decide pelo commit que mudou a versão nas notas | Conformidade 12.17 | — |
| E18 | P2: as duas arquiteturas construíam no mesmo passo, uma delas por emulação e com tempo máximo. Se ela estourasse, nenhuma seria publicada, com a etiqueta já criada | Uma arquitetura por job | Revisão | — |
| E19 | P2: a primeira versão saiu com o título "requer atenção antes de atualizar" e instruções para quem já tinha instalado, quando não havia instalação nenhuma além da de teste | Na primeira versão, nenhum fragmento pede ação: não há quem atualize | Revisão do pedido de versão, antes do merge | — |
| E20 | P2: o PR de versão aberto pelo próprio workflow ficou com as verificações do evento de PR paradas, esperando aprovação, e a página do PR dizia que não havia verificação nenhuma. O verde que valeu veio de outra execução, disparada no ramo | O PR aberto por robô é exercitado antes de se depender dele: de onde vem o verde que libera o merge, e se a página do PR o mostra. Verde que só existe no commit e não aparece no PR é anotado como defeito, não como normal | Corte de uma versão de ensaio antes da primeira de verdade | — |
| E21 | P2: depois da ponte entre duas versões, a rota fechada respondia "não existe" pela entrada pública. Duas camadas diferentes davam a mesma resposta, e o atualizador antigo não reiniciava o proxy: o teste não dizia qual das duas respondeu | Prova de defesa em camadas distingue a camada. Cada uma responde de um jeito que se reconhece, ou a prova desliga uma para ver a outra | Leitura da prova de instalação real | — |
| E22 | P2: a atualização trocou no disco o arquivo de configuração do proxy, montado como arquivo no contêiner. O contêiner seguiu de pé por horas com a configuração da versão anterior, nas duas máquinas de teste, e a regra nova não valia | Arquivo de configuração montado só é relido quando o contêiner reinicia. O atualizador reinicia quem lê cada arquivo que mudou, na ida e na volta, e a prova confere a configuração em uso, não a do disco | Conformidade 12.19 | — |

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
| K9 | A primeira instalação sem domínio deixou a tela de login exposta na internet sem conexão segura | Sem domínio, o padrão é o painel só local | Teste do kit; conformidade 11.22 | — (a referência oferece o modo só local como opção; o padrão ainda publica pelo endereço da máquina, com aviso) |
| K10 | O dono, ao tentar entrar, descobriu que não havia como criar conta nem incluir a equipe | "O dono usa o produto" é uma fase, distinta da revisão e da instalação | Método, fase 9 | — |
| K11 | Muita coisa foi escrita e nunca rodou: fila de merge, acolhida, passo de atualização, publicação de imagens | O produto mantém a lista do que está configurado e ainda não foi exercitado | Conformidade 13.9 | — |
| K12 | No primeiro dia de público, o robô de dependências propôs versões maiores que quebravam o piso declarado | A regra para atualização automática de dependência existe antes da publicação | Conformidade 10.13 | — |
| K13 | As duas primeiras contribuições depois da fundação entraram com passagem de administrador, implementadas, verificadas e mescladas pela mesma sessão | A regra "quem escreve não aprova" vale desde a primeira contribuição, inclusive para o dono e para agentes | Proteção do ramo, sem exceção para administrador | — (a referência permite a passagem de administrador) |
| K14 | Uma capacidade nova ganhou uma porta publicada. Num dos modos de instalação a capacidade não funcionava, e a porta ficava aberta na internet mesmo assim | Toda porta publicada tem um uso que funciona naquele modo. O que não tem uso fica só local | Conformidade 11.20 | — |
| K15 | Uma capacidade nova gastava com provedor e só tinha teto por unidade. Um usuário logado podia abrir quantas unidades quisesse em paralelo | Todo gasto com provedor tem teto somado, além do teto por unidade | Conformidade 2.16 | — |
| K16 | Nasceu o estado "pessoa desativada". A entrada passou a respeitá-lo, e os lugares que escolhiam para quem mandar aviso não: quem saiu continuaria recebendo dados | Um estado que tira o acesso de alguém é conferido em todo lugar que escolhe pessoas, e não só na entrada | Busca por toda consulta à tabela de pessoas; conformidade 6.15 | — |
| K17 | Uma capacidade nova chegou por uma segunda porta. Quem acessava por túnel só tinha redirecionado a primeira, e a tela disse "confira sua internet" | O que o navegador usa chega por uma origem só. Porta a mais é um passo a mais em cada modo de instalação (proxy, túnel, firewall), e cada passo é um lugar para falhar em silêncio | Conformidade 11.23 | — |
| K18 | Na primeira instalação do zero contra a versão publicada, a opção "painel só local" foi ignorada em silêncio porque as portas estavam livres, o valor passado nem foi validado, e o instalador anunciou um endereço que de fora não respondia | Opção sem efeito no modo em que foi passada é erro, e não silêncio. O instalador anuncia o endereço que testou | Conformidade 11.25 | — |
| K19 | Uma rota recusava pedido "que veio por proxy" olhando se um cabeçalho existia. Os testes em processo passavam. Na primeira subida de verdade no CI, o servidor preenchia o cabeçalho sozinho em todo pedido, e a rota recusava o próprio chamador legítimo | Regra que depende do que o servidor ou o proxy acrescentam ao pedido só se prova com o servidor de verdade no ar. O CI sobe a instalação e exercita a regra dos dois lados: quem deve passar passa, quem não deve não passa | Conformidade 11.21 | — |
| K20 | Na máquina de teste, uma regra antiga de firewall, gravada fora da lista que o comando de estado mostra, derrubava toda entrada da internet para os contêineres. O instalador via as portas publicadas e a checagem local verde; de fora nada chegava | O que o instalador confere de dentro da máquina ele anuncia como conferido de dentro. "Abre de fora" só é dito por quem testou de fora, e a prova de instalação real inclui um pedido vindo de outra máquina | Prova da fase 8, de outra máquina | — |
| K21 | O instalador avisava que o domínio ainda não apontava, instalava tudo e terminava com erro. É o estado mais comum de quem instala com domínio pela primeira vez, e quem conduz a instalação lê o erro como instalação quebrada | O instalador separa o que é defeito (a peça local não responde) do que só falta de fora (DNS, certificado, firewall). O segundo termina com sucesso, um título que diz o que falta e o que fazer, sem dar o endereço como certo | Conformidade 11.25 | — |
| K22 | A primeira contribuição de fora fechou três brechas de um filtro de segurança. A revisão mediu a lista inteira e achou mais três da mesma família, ainda abertas | O que a revisão de um conserto de segurança acha ainda aberto não vai no comentário público do PR. O conserto do contribuidor entra como está, e o resto sai em seguida, por quem mantém, revisado por quem não escreveu | Capítulo 10; aviso privado no documento de segurança | — |
| K23 | A segunda medição do produto 2 contra a régua achou que todos os merges desde a publicação tinham revisão de uma sessão distinta, e nenhum tinha o rastro dela no PR: os pareceres foram trocados entre sessões. A medição não conseguiu conferir a revisão | A revisão se registra onde quem audita olha: no PR. Achado de segurança ainda aberto fica fora do texto público, que leva o resumo e o veredito | Conformidade 10.5 | — |
| K24 | A mesma medição achou frases de estado nos documentos de entrada que a versão publicada já tinha desmentido ("constrói as imagens no servidor", "cerca de 400 MB"), em quatro lugares que nenhum item conferia | O corte de versão confere os documentos de entrada contra o que a versão entrega | Conformidade 12.20 | — |
| K25 | P2: a atualização regravava a configuração montada da telefonia e nunca a aplicava; no proxy, o contêiner seguiu com a configuração antiga até reiniciar (observado em duas instalações). A regravação era por renomeação, que deixa o contêiner preso ao arquivo antigo: aí recarregar não basta e só reiniciar resolve, o que derruba ligação (mecanismo conhecido, não reproduzido no produto) | Arquivo montado um a um é regravado no lugar, e só quando muda. Aí a peça pode recarregar sem reiniciar, e a conferência compara o que o contêiner lê com o disco | Conformidade 12.19 | — |
| K26 | P2: a dúvida que segurava um conserto (o texto que a telefonia devolve ao recarregar, e se a conexão do processo de voz sobrevive) parecia exigir uma VPS. O CI já subia a telefonia de verdade, e respondeu as duas num passo de minutos | Antes de deixar uma dúvida para a instalação real, confira se o CI já roda a peça de verdade. A prova afirma pelo sinal da peça que importa (o registro da conexão), e não por um teste que passa sem ela | Leitura do job de instalação do CI | — |
| K27 | P2: o bloqueio de login passou a contar o par e-mail + endereço, para que errar a senha de alguém trancasse só quem errou. Lendo o código antes do merge, a revisão notou que o endereço era o IPv6 inteiro, e quem tem uma VPS recebe um /64: trocando de endereço a cada tentativa, o par não bloquearia ninguém com IPv6, e trancar o dono voltaria a pedir só 50 pedidos de uma máquina. A mesma chave por par, sem faxina, deixaria a memória do processo crescer a cada combinação nova. Achado de leitura, corrigido antes de chegar a uma versão | Limite por endereço conta IPv6 pelo prefixo /64 (e o IPv4 mapeado como IPv4). Contagem em memória apaga a chave vencida | Conformidade 6.7 | — |
| K28 | P2: a linha do motor de voz na tela de saúde passou a mostrar o último teste da chave. A rota de saúde é pública e já lia pela porta de sistema, para o resumo sem sessão, e a leitura nova foi pelo mesmo caminho: com sessão, uma organização veria o provedor, o modelo e a data do teste de outra. A revisão por leitura deixou passar; a revisão automática de segurança pegou antes do merge. Achado de leitura, corrigido antes de chegar a uma versão | A exceção da porta de sistema vale para o agregado sem sessão, e nunca para o que vai à tela de uma sessão. A prova é um teste com duas organizações na própria rota | Conformidade 7.3 | — |

## L. O que a comunidade ensinou

Do que quem usa e quem revende o P1 mais pergunta e reclama, lido nos comentários do canal, nas
issues e no espaço da comunidade. Nenhuma destas é defeito de código: são decisões de fundação
que não foram tomadas.

O erro de cada linha foi medido. **A regra ainda não rodou em nenhum produto:** nem o P1 nem o
P2 a cumprem por inteiro. Trate como o ponto de partida da terceira fundação.

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| L1 | A dúvida mais frequente era "como faço X?" para algo que já existia. A mesma pergunta chegou várias vezes num mês, de pessoas diferentes | Um recurso só está pronto quando é achável pela pergunta de quem usa. Dúvida repetida três vezes é defeito de descoberta, e vira item de produto | Triagem da comunidade | — |
| L2 | O caminho de instalação recomendado usava a camada gratuita de um serviço de terceiros que não aguentava uso real. Quem descobria já tinha cliente dentro | O padrão do instalador sustenta produção. Onde não sustenta, diz isso na mesma tela | Conformidade 3.2, 11.15 | — |
| L3 | Quem fechava um cliente não sabia prever quanto ele gastaria por mês | O custo mensal real do caminho recomendado é medido e publicado antes do lançamento, com o ponto em que cada limite acaba | Guia de custos | `docs/guides/custos.md` |
| L4 | "Configurei tudo e não acontece nada": uma proteção ligada de fábrica bloqueava o resultado sem avisar. Foi a dúvida que mais voltou, e fez gente experiente concluir que o produto não funcionava | Toda proteção ligada por padrão se anuncia na tela onde a pessoa espera o resultado, dizendo o que bloqueia e onde liberar | Revisão; conformidade 8.8 | — |
| L5 | Tela vazia para sempre, sem dizer por quê. Erro que listava todos os requisitos em vez do que faltava. Erro que culpava a conexão quando a causa era uma opção desligada | Tela vazia explica o vazio. Erro nomeia o item que falta | Revisão; conformidade 8.9 | — |
| L6 | Integrações travavam num passo do lado do fornecedor (aprovação, plano mínimo, modo de teste) que o material não cobria | O guia de cada integração cobre também o lado do terceiro, e a tela de conexão testa o pré-requisito e diz qual falta | Revisão; conformidade 8.10 | — |
| L7 | Quem revende perguntava preço, contrato, prova de uso real e o que é suportado em produção. A comunidade improvisava as respostas | Produto feito para ser revendido nasce com o kit de quem revende | Conformidade 2.12 | `docs/guides/ganhar-dinheiro-implementando.md` |
| L8 | A instalação "concluía" e a tela de login nunca abria. Quem instalava em ambiente fora do recomendado ficava sem saída | O instalador termina provando que a pessoa consegue entrar. Os ambientes suportados são declarados, e os outros têm um caminho escrito | Conformidade 11.5, 11.16 | — |
| L9 | O espaço da comunidade abriu dizendo que não havia suporte, e perguntas ficaram semanas sem resposta. Quem resolvia eram dois ou três membros | Quem responde, em quanto tempo e por onde é decisão escrita antes do lançamento, mesmo que a resposta seja "ninguém, e este é o caminho". Pergunta sem resposta no prazo tem dono | Conformidade 10.12 | — |
| L10 | O vídeo era a documentação, e envelhecia mais rápido que o produto. "Faltou esse pedaço no vídeo" virou resposta padrão | Vídeo divulga. O "como fazer" mora no repositório, é conferido a cada versão, e todo vídeo aponta para ele | Conformidade 12.11 | — |
| L11 | Quem personalizava tinha medo de atualizar. Mudar um texto da página inicial fazia a instalação ser tratada como modificada | Tudo o que quem revende vai querer mudar é configuração ou extensão que sobrevive à atualização. O que só muda editando código é dívida declarada | Conformidade 2.11 | — |
| L12 | Telas desenhadas para três itens recebiam trinta. Ajustes globais precisavam ser por unidade | Cada lista é desenhada para dez vezes o exemplo. O nível de cada configuração (instalação, organização, unidade) é decidido na fundação | Revisão; conformidade 8.11 | — |
| L13 | Pedidos pequenos atendidos em dias, com crédito a quem pediu, geraram os agradecimentos mais fortes. O material de ensino navegável foi o mais elogiado | Manter curto o ciclo pedido → versão → crédito. Investir em material que se percorre, e não só se assiste | Revisão | — |
| L14 | O público reclamou de interface complexa e de sistema que incha a cada versão | O que não é do trabalho central nasce como peça opcional, desligada por padrão | Regra de produto | — |
| L15 | Quem chegava ao projeto colando o endereço no assistente de IA não via a recomendação do parceiro: o link estava no README e num script, e não no que o assistente carrega. No P2, a skill de instalação começava pela pergunta sobre o sistema da VPS, sem caminho para quem não tinha uma | O passo zero de todo roteiro de instalação para assistente é "tem servidor?", e a recomendação declarada do parceiro mora em todo lugar por onde um assistente entra | Conformidade 2.17 a 2.19 | — |

## M. Tela, acesso e marca

Erros do P1 que os capítulos 04, 06 e 08 narram.

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| M1 | Uma proibição visual existia só em prosa, e os próprios componentes de base a violavam | Proibição visual mecânica vira cerca no primeiro commit | Cerca | — |
| M2 | As fontes eram baixadas de serviço externo na construção, e a construção caía quando ele não respondia | Fonte versionada no repositório | Revisão | — (a referência ainda baixa) |
| M3 | Um gráfico usava um token de cor que não existia e sumia da tela, com tudo verde | Token consumido tem de existir | Teste | — |
| M4 | A marca de quem revende era gravada na construção, e aparecia errada na instalação dele | Marca é lida em tempo de execução | Teste | — |
| M5 | O segundo fator era forçado ao administrador, e toda instalação nova recebia um bloqueio de tela cheia que ninguém anunciou | Segurança opcional nasce desligada e se liga pela tela | Revisão | — |
| M6 | Rotas que comparavam o nível do papel à mão pulavam a conferência do segundo fator | Uma função só decide o papel | Verificação que reprova a comparação direta | `apps/panel/src/server/context.ts` |
| M7 | Uma opção de segurança era gravada e nunca lida | Controle que aparece na tela tem teste de efeito | Teste | — |
| M8 | A documentação dizia um formato de chave e o código gerava outro | Um formato só, conferido por teste | Teste | — |
| M9 | Um papel de suporte "só leitura" conseguia escrever, porque as rotas conferiam o papel e não o escopo | O poder de instalação tem escopo, conferido em toda rota de escrita | Verificação | — |
| M10 | Telas existiam e não tinham porta no menu | A lista de telas vem do disco, e um teste a amarra ao menu | Teste | — (a referência não tem) |
| M11 | O banco de teste não reproduzia as permissões do banco real, e funções internas ficavam alcançáveis com o teste verde | A prova de isolamento roda com o papel e as permissões do banco real | Teste | `packages/core/test/isolation.db.test.ts` |

## N. Site e material de ensino

Do site do P1. O que está em "Onde ver" fica no repositório do site dele, e não na referência.

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| N1 | A página de apresentação moraria na raiz do aplicativo, e toda instalação de revendedor a serviria aos clientes dele | O site mora em repositório separado | Conformidade 14.1 | — |
| N2 | A página de guias era cópia manual da pasta de skills, e ficou listando menos guias do que o produto tinha | O que pode vir da fonte, vem da fonte. Toda cópia tem teste de paridade | Conformidade 14.5, 14.6 | — |
| N3 | A página de instalar foi conferida contra o kit numa data fixa, e o mesmo comando aparecia escrito de dois jeitos no site | Os comandos da página são os do kit, por leitura, geração ou teste | Conformidade 14.4 | — |
| N4 | As notas de versão, lidas do arquivo do produto, nunca ficaram atrás. E o corte de versão confere que a versão apareceu no site | Página lida da fonte, e o corte confere a consequência | Conformidade 14.2, 14.3 | — |
| N5 | A data de atualização da página inicial era fixa num componente e ficou meses atrás | Uma data, de uma constante só | Conformidade 14.8 | — |
| N6 | O curso capturado do aplicativo real, com dados fictícios e recibo de publicação, foi o material mais elogiado. Produzi-lo ainda achou defeitos de uso | Curso por captura do aplicativo real, com procedência por foto | Conformidade 14.14 | — |

## O. Equipe autônoma

Da equipe de agentes que mantém o P1. Nada disto está na referência; mora na instalação da
ferramenta de orquestração.

| Nº | O que aconteceu | Regra | Como se cobra | Onde ver |
|---|---|---|---|---|
| O1 | A execução de um agente não recebe aviso de tarefa em segundo plano. Agente que encerrava "esperando" virava falha | Bloco comum "esperar sem se perder" em toda instrução | Conformidade 15.4 | — |
| O2 | Um orçamento em dinheiro, com agentes em assinatura, parou a empresa inteira no começo do mês. E o orçamento não media nada, porque a assinatura cobra zero por uso | O teto é de execuções, num vigia fora da ferramenta | Conformidade 15.11 | — |
| O3 | Dois terços das execuções que falharam, falharam por cota. Houve dias com uma execução só | A capacidade é medida antes de ligar uma rotina | Conformidade 15.13 | — |
| O4 | Os agentes consumiam o limite da conta em que o dono trabalha | A conta da equipe não é a do dono | Conformidade 15.14 | — |
| O5 | A conexão de repositório gerenciada pela ferramenta passou por cima da credencial de cada agente, e todos viraram administradores | Credencial por agente; conexão gerenciada desligada; nenhuma credencial pessoal do dono | Conformidade 15.5, 15.7 | — |
| O6 | Quem mescla, quem fecha e quem publica eram limites só de instrução, com a mesma credencial em papéis diferentes | O que pode causar dano tem trava fora da instrução | Conformidade 15.6, 15.7 | — |
| O7 | A concorrência padrão da ferramenta saturou a máquina | Um ou dois agentes ao mesmo tempo | Configuração | — |
| O8 | Um agente novo entrou e o líder continuou distribuindo para a equipe antiga. O texto de uma rotina ainda falava de uma fase que já tinha acabado | Agente novo atualiza o organograma e as instruções do líder na mesma ação. Texto de rotina é instrução e envelhece | Revisão | — |
| O9 | Uma primeira issue, feita para atrair quem está começando, foi resolvida por um agente | Quem cura a porta de entrada nunca implementa | Conformidade 15.4 | — |
| O10 | Canais de divulgação têm regra própria sobre conteúdo de IA, e alguns proíbem até rascunho | Antes de dar um canal a um agente, lê-se a regra do canal na fonte | Conformidade 15.8 | — |
| O11 | Começar com tudo em rascunho afogou o dono em aprovações | Liberação gradual, canal por canal | Conformidade 15.8 | — |
| O12 | O canal em que o dono decide caiu, e os agentes avisaram dentro da ferramenta, onde ele não olha | O canal de decisão tem vigia e rota de reserva | Conformidade 15.10 | — |
| O13 | A cópia de segurança falhou dois dias seguidos sem alarme | Vigia precisa de vigia | Conformidade 15.12 | — |
| O14 | As tarefas que o disjuntor abria para o dono ficaram abertas, acumulando | Alarme tem dono e prazo; sem quem feche, vira ruído | Revisão | — |
| O15 | O atendimento, rodando de meia em meia hora, gerou mais da metade de todas as tarefas | Rotina de alta frequência só acorda o agente se houver o que fazer | Conformidade 15.15 | — |
| O16 | A frente mais parecida com arquiteto, desenvolvedor e verificador foi a mais cara e ficou bloqueada esperando decisão. Uma tarefa dela foi cancelada porque o dono tinha feito o mesmo em outra sessão | No desenvolvimento autônomo, o difícil é o fluxo de decisão: roteiro aprovado em lote, e um dono por frente, registrado | Conformidade 15.18 | — |
| O17 | Um agente ficou preso em "pausando" e só um conserto no banco o soltou. A ferramenta lança versão toda semana, quase sempre quebrando algo | Atualizar a ferramenta é um procedimento, com cópia antes e conferência depois | Conformidade 15.16 | — |
