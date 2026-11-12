# Conformidade

> A lista que diz se um produto segue a Fábrica. Serve para três momentos: ao fundar (o que
> precisa existir antes do lançamento), na revisão fria (o que conferir) e ao adaptar um produto
> que já existe.

## Como usar

- Cada item tem um jeito de conferir. **Arquivo** e **comando** são mecânicos. **Leitura** pede
  abrir e julgar. **Execução** pede rodar o sistema.
- O resultado de cada item é um de cinco: **conforme**, **não conforme**, **não se aplica**
  (com o motivo), **decidido diferente** (com o registro de decisão), **não medido** (com o que
  faltou para medir).
- Item de nível F **não conforme** impede a publicação, e item de nível L impede a divulgação.
  As saídas são corrigir, registrar a decisão, ou o dono aceitar por escrito seguir com ele
  aberto.
- "Decidido diferente" é resposta legítima. A Fábrica exige a decisão escrita, e não a
  obediência. O que ela não aceita é a divergência sem motivo. Conta como decisão o registro que
  diz a alternativa da Fábrica, por que não foi seguida e o que custa divergir. Um registro que só
  descreve a consequência ("quem sabe o e-mail consegue bloquear") não é decisão: o item fica não
  conforme.
- Onde o jeito de conferir é "teste de tela, ou execução", o teste vale mais: ele prova a
  presença. Só com leitura se prova a ausência, e nunca a presença.
- Quando um item "decidido diferente" tiver uma razão melhor que a do manual, a lição volta para
  a Fábrica (fase 10 do método).

O **nível** diz quando o item passa a valer:

- **F**: fundação. Vale antes de o código ir a público.
- **L**: lançamento. Vale antes de o produto ser divulgado. Entre a publicação do código e a
  divulgação, o produto ganha o que só existe em público: a primeira versão, a atualização
  entre versões, o site, a equipe que o mantém.
- **C**: crescimento. Vale quando a condição escrita no item aparecer.

---

## 1. Visão — capítulo 01

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 1.1 | `VISION.md` na raiz, com tese, nome, crenças, públicos, modelo, antiobjetivos, como falamos e norte | Arquivo | F |
| 1.2 | A tese fala do resultado, e não do canal ou da tecnologia | Leitura | F |
| 1.3 | Cada parte da palavra central aponta para uma peça do sistema | Leitura | F |
| 1.4 | Cada antiobjetivo aponta, no `VISION.md` ou no desenho da fundação, para o teste, a cerca ou o item de revisão que o guarda | Leitura | F |
| 1.5 | Os três tipos de "não" estão separados: fora da fundação, fora do horizonte, fora para sempre | Leitura | F |
| 1.6 | Há registro de decisão da fronteira com cada produto irmão | Arquivo | F |
| 1.7 | O README declara, por capacidade, até onde ela foi provada | Leitura | F |

## 2. Modelo de negócio — capítulo 02

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 2.1 | O parceiro está nomeado na visão e num bloco do README antes do comando de instalação | Leitura | F |
| 2.2 | O bloco diz que qualquer outra VPS funciona igual, e o link está identificado como de parceria | Leitura | F |
| 2.3 | Nenhuma pasta, arquivo ou variável leva o nome do parceiro | Comando: busca pelo nome em nomes de arquivo e de variável | F |
| 2.4 | Toda ocorrência do link do parceiro o identifica como de parceria, e nenhuma promete algo que as outras não prometem | Comando: busca pelo link; leitura das ocorrências | F |
| 2.5 | O instalador só menciona o parceiro sob condição testada | Arquivo: o teste | F |
| 2.6 | "Caminho genérico nunca sabotado" e "sem recurso pago" são regras de produto escritas | Leitura do documento de governança | F |
| 2.7 | Telemetria: nenhuma, ou só com consentimento declarado no README. Todo contato que o produto faz sozinho com fora (consulta de versões, busca de atualização) está listado no README, com o que envia | Leitura | F |
| 2.8 | Existe guia de custos: quais contas, como estimar, como o produto mede e limita | Arquivo | F |
| 2.9 | Existe guia do implementador | Arquivo | F |
| 2.10 | Todo custo que o produto origina e consegue medir aparece na tela e respeita um teto do operador. O que ele não mede (a VPS, a conta de um fornecedor) está dito no guia de custos | Execução, ou o teste que prova | F |
| 2.16 | Todo caminho que gasta com provedor tem teto somado (por organização e período, ou de simultâneos), além do teto por unidade | Leitura; execução | F |
| 2.17 | O roteiro de instalação para assistente começa pelo passo zero (tem servidor? se não, o parceiro, declarado), e ele está no README, no documento de autoridade e na skill de instalação | Leitura dos três | F |
| 2.18 | O endereço do parceiro tem uma grafia só no repositório, vinda de um arquivo de dados do kit | Arquivo: a cerca | F |
| 2.19 | Um assistente que recebe só o endereço do repositório e "me ajuda a instalar, não tenho servidor" chega ao link do parceiro e o declara como de parceria | Execução: uma sessão nova de assistente, sem contexto | F |
| 2.11 | Marca própria é configuração em tempo de execução e sobrevive à atualização | Execução | C: quando houver revenda com marca |
| 2.12 | O guia do implementador responde: quanto cobrar (método), quem paga os provedores, como prever o gasto, contrato, capacidade da máquina, acesso do cliente, a quem recorrer | Leitura | F |
| 2.13 | O custo mensal do caminho recomendado está estimado, com o método, e diz onde cada limite gratuito acaba | Leitura do guia de custos | F |
| 2.15 | O custo mensal foi medido em uso real, e o guia traz o número com a data | Leitura | C: depois da primeira instalação em produção de alguém de fora do projeto |
| 2.14 | Há um caso real documentado, e a lista do que é suportado em produção | Arquivo | C: depois da primeira instalação em produção de alguém de fora do projeto |

## 3. Stack — capítulo 03

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 3.1 | Cada escolha estrutural tem registro de decisão com alternativas descartadas e custos | Arquivo | F |
| 3.2 | O sistema sobe sem conta em serviço de terceiros | Execução: instalação limpa | F |
| 3.3 | Dependências de terceiros com versão fixa, inclusive a base de cada imagem que o projeto constrói | Leitura do arquivo de composição e da primeira linha de cada `Dockerfile` | F |
| 3.4 | Memória e disco do sistema parado, medidos na VPS da instalação real, estão registrados com o tamanho da máquina | Leitura do registro da instalação real | F |
| 3.5 | A peça de maior risco técnico rodou antes de o desenho ser fechado: num produto irmão, ou sozinha numa VPS | Registro de decisão | F |

## 4. Design system — capítulo 04

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 4.1 | Existe documento de design system com a direção e as proibições, cada uma com o motivo | Arquivo | F |
| 4.2 | Cada proibição mecânica (biblioteca, fonte, cor fora de token) tem cerca | Arquivo: a cerca | F |
| 4.3 | Componentes usam só token semântico | Comando: busca por valor solto de cor nos componentes | F |
| 4.4 | Uma fonte só de tokens | Leitura | F |
| 4.5 | Fontes versionadas no repositório; a construção não baixa de serviço externo | Leitura | F |
| 4.6 | Texto de tela só em dicionário, nos idiomas declarados | Arquivo: a cerca | F |
| 4.7 | O dono validou a direção | Registro | F |
| 4.8 | Existe a pasta de marca, com a marca completa, o símbolo e a imagem de capa, em vetor, para fundo claro e escuro | Arquivo | L |
| 4.9 | O README, o site e o painel usam os arquivos da pasta de marca, e o repositório tem imagem de capa | Leitura; comando | L |

## 5. Engenharia — capítulo 05

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 5.1 | Um documento de autoridade (`AGENTS.md`); os específicos de ferramenta só o importam | Arquivo | F |
| 5.2 | Cada convenção do documento aponta para a cerca ou o teste que a cobra, ou diz que é cobrada na revisão | Leitura | F |
| 5.3 | Cada antipadrão traz o erro que o originou | Leitura | F |
| 5.4 | Definição de pronto em duas listas: o que o CI reprova e o que o CI não vê | Leitura | F |
| 5.5 | Um caminho de schema; migrations por carimbo de tempo | Arquivo: a cerca; não existe segundo retrato do banco | F |
| 5.6 | Um arquivo por peça; nenhuma lista central | Arquivo: a cerca | F |
| 5.7 | Quem consome trabalho é acordado por notificação. Trabalho periódico usa um agendador declarado; nenhuma tarefa se reenfileira sozinha para esperar | Leitura do consumidor da fila e das rotinas | F |
| 5.8 | Nenhuma variável de ambiente sem padrão | Arquivo: a cerca | F |
| 5.9 | Toda cerca tem dono, motivo e data de revisão | Arquivo: a cerca das cercas | F |
| 5.10 | Cada cerca guarda o que o texto diz que ela guarda | Leitura, cerca por cerca, contra o documento | F |
| 5.11 | Um check obrigatório que agrega os outros | Comando: a proteção do ramo | F |
| 5.12 | Check de contribuição só mede o que ela mudou; estado acumulado é do ramo principal | Leitura dos workflows | F |
| 5.13 | Cada job do CI que pode reprovar uma contribuição tem o passo que diz se a causa está nela ou fora | Leitura dos workflows | F |
| 5.14 | O CI cria o banco do zero, só pelas migrations | Leitura do workflow | F |
| 5.20 | O CI atualiza a partir da última versão publicada, com dados nas tabelas que guardam o trabalho de quem usa, e esse passo já rodou | Execução | L |
| 5.21 | O painel tem testes que dirigem o navegador nos caminhos de primeira impressão: entrar, configurar, a primeira ação útil | Arquivo: os testes | F |
| 5.15 | O caminho central roda de ponta a ponta sem credencial, num job do CI | Leitura do workflow: o job e o teste que ele roda | F |
| 5.16 | As imagens constroem **e sobem** no CI | Leitura do workflow | F |
| 5.17 | Varredura de segredo no CI e antes do commit | Leitura | F |
| 5.18 | Toda afirmação "o CI prova X", em documento, aponta para um job que existe e faz isso (as cercas são do item 5.10) | Leitura, afirmação por afirmação | F |
| 5.19 | Testes sem relógio real, porta fixa ou fuso | Comando: busca por data e porta literais em teste | F |

## 6. Autenticação — capítulo 06

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 6.1 | A tabela de decisões de autenticação está escrita, **incluindo o que não existe** | Leitura | F |
| 6.2 | Uma função só decide o papel; nenhuma rota compara nível à mão | Comando: busca | F |
| 6.3 | A instalação nova chega à primeira tela útil sem passo de segurança não anunciado | Teste de tela, ou execução | F |
| 6.4 | Primeiro usuário nasce pelo instalador; senha nunca como argumento | Leitura | F |
| 6.5 | Recuperação de emergência de dentro do servidor encerra as sessões | Execução | F |
| 6.6 | Login não revela quem tem conta | Execução | F |
| 6.7 | Bloqueio por tentativas não permite trancar outra pessoa só sabendo o e-mail. O endereço conta IPv6 pelo prefixo /64, e a contagem em memória tem faxina | Leitura; teste com vários endereços do mesmo /64 | F |
| 6.8 | Segredo de operador cifrado em repouso | Leitura | F |
| 6.9 | O que o produto não tem está em "limites conhecidos" | Leitura do documento de segurança | F |
| 6.10 | Segundo fator opcional, ligado pela tela, com cadastro e prova separados | Execução | C: quando houver segundo fator |
| 6.11 | Token de API: em claro uma vez, resumo no banco, nunca em endereço | Leitura | C: quando houver API pública |
| 6.12 | A sessão é validada no servidor a cada requisição | Leitura | F |
| 6.13 | Cada controle de segurança da tela tem um teste que prova que ligar e desligar mudam o comportamento | Arquivo: o teste | F |
| 6.14 | Quando a leitura de uma configuração de segurança falha, nunca vale o valor mais permissivo: a operação falha, ou vale o último valor bom | Leitura | F |
| 6.15 | Conta desativada ou removida não entra, não recebe aviso e não decide nada: toda consulta que escolhe pessoas confere o estado | Comando: busca por toda consulta à tabela de pessoas | F |

## 7. Multiempresa — capítulo 07

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 7.1 | Toda tabela tem organização | Arquivo: a cerca | F |
| 7.2 | Uma porta única; acesso direto ao banco fora do núcleo é reprovado | Arquivo: a cerca | F |
| 7.3 | A porta de sistema só em arquivo listado com motivo. Numa rota que também atende sessão, ela só serve ao agregado de quem não tem sessão; o que vai à tela de uma sessão é lido pela porta da organização dela | Arquivo: a cerca e a lista; teste com duas organizações na rota | F |
| 7.4 | O teste de isolamento tenta atravessar, e descobre as tabelas pelo catálogo | Leitura do teste | F |
| 7.5 | O teste roda com o papel da aplicação, em banco criado pelo caminho do instalador | Leitura | F, se o banco tem papéis |
| 7.6 | Chaves entre tabelas levam a organização | Leitura do schema | F, se o banco tem chaves estrangeiras |
| 7.7 | Todo recurso compartilhado tem regra de posse que falha fechado. Operação que é da instalação, e não de uma organização (atualizar, ligar um serviço), tem registro de decisão dizendo quem pode pedi-la | Leitura; registro de decisão | F |
| 7.8 | Nenhuma rota assume "só existe uma organização", e rota pública não mostra dado de organização | Leitura das rotas | F |
| 7.9 | A organização vem da sessão, da chave ou do segredo de quem chama, e nunca do corpo de uma requisição de fora. Chamada entre processos do próprio produto, autenticada por segredo interno, pode levá-la no corpo | Leitura das rotas | F |
| 7.10 | O papel da aplicação não contorna o isolamento | Leitura | F, se o banco tem papéis |
| 7.11 | Registro de auditoria é só de acréscimo, por permissão do banco | Comando: as permissões da tabela | C: quando houver auditoria |

## 8. Administração — capítulo 08

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 8.1 | Tudo o que o operador configura tem tela, ou decisão escrita de que fica no servidor | Leitura do inventário, em `docs/fundacao/configuracao.md` | F |
| 8.2 | Toda entidade criada pela tela se edita e se remove pela tela | Teste de tela, ou execução | F |
| 8.3 | Toda tela tem porta no menu, e um teste deriva a lista de telas do que o framework declara | Arquivo: o teste | F |
| 8.4 | A tela de saúde mostra cada peça e cada ligação. A entrada pela qual a própria tela é aberta pode ficar só na checagem do terminal, que a confere de fora | Teste de tela, ou execução | F |
| 8.5 | Ação destrutiva pede confirmação nomeando o alvo | Teste de tela, ou execução | F |
| 8.6 | Gestão de equipe e papéis pela tela | Execução | F |
| 8.7 | Painel da instalação separado, com escopo de leitura e de escrita | Execução | C: quando a instalação servir mais de uma organização |
| 8.8 | Toda proteção ligada por padrão se anuncia na tela onde a pessoa espera o resultado | Teste de tela, ou execução numa instalação nova | F |
| 8.9 | Tela vazia diz por quê; erro nomeia o item que falta | Teste de tela, ou execução | F |
| 8.10 | Cada integração externa tem teste de conexão que diz o pré-requisito que falta, e guia que cobre o lado do terceiro | Execução; arquivo | F |
| 8.11 | O nível de cada configuração (instalação, organização, unidade) está decidido e escrito | Leitura do desenho | F |
| 8.12 | Toda rota de administração valida o papel dentro dela, e não só numa barreira anterior | Leitura | F |

## 9. Doutrinas — capítulo 09

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 9.1 | Cada doutrina tem o caso de origem e a forma de cobrança | Leitura | F |
| 9.2 | Sistema vivo adotado: propósito, unidade de demanda, fronteira de autoridade, um gate, par de medidas | Leitura | F |
| 9.3 | Invariante do manual que o produto deixou de fora tem motivo escrito | Leitura | F |
| 9.4 | As quatro perguntas de domínio estão respondidas por escrito | Leitura | F |
| 9.5 | Capacidade de risco nasce desligada, e o código impõe os limites | Execução | F |
| 9.6 | Controle legal anunciado tem padrão que o cumpre numa instalação nova | Execução | F |
| 9.7 | O padrão de uma aprovação humana é do operador | Leitura | F |
| 9.8 | Está escrito quem responde pelos dados pessoais, a retenção e como ela é executada | Arquivo: doutrina ou guia | F |
| 9.9 | As doutrinas herdadas usam os nomes da tabela do capítulo 09 para a mesma lei | Leitura | F |
| 9.11 | Cada doutrina da tabela "as que todo produto herda" existe no produto, ou tem a ausência registrada com o motivo | Arquivo | F |
| 9.10 | Existe skill de doutrina que responde "isto é permitido?" | Arquivo | F |

## 10. Contribuição — capítulo 10

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 10.1 | Repositório em organização | Comando | F |
| 10.2 | `CONTRIBUTING`, `GOVERNANCE`, `CREDITS`, `SECURITY`, `CODE_OF_CONDUCT` | Arquivo | F |
| 10.3 | Regras de produto com o porquê de cada uma | Leitura | F |
| 10.4 | Formato de pedido de decisão com padrão e prazo | Leitura | F |
| 10.5 | Proteção do ramo: aprovação de quem não escreveu, e fila de merge. Com um mantenedor só, está registrado quem revisa (um agente revisor distinto de quem implementou conta), e o parecer fica no próprio PR: revisão que só existe numa conversa entre sessões não se confere | Comando; registro; leitura dos PRs mesclados | F |
| 10.6 | Skill de contribuição com pré-voo que só mede e hooks que barram o irreversível | Arquivo | F |
| 10.7 | As ferramentas do contribuidor medem contra o repositório original | Leitura dos scripts | F |
| 10.8 | Acolhida automática que não avalia e não baixa código de fora | Arquivo: workflow e cerca | F |
| 10.9 | O modelo de contribuição diz o que é trabalho do projeto | Leitura | F |
| 10.10 | Fonte das skills em pasta neutra; espelhos gerados e conferidos | Arquivo: a cerca | F |
| 10.11 | Procedimento de triagem com medidor, reprodutor e cético | Arquivo | C: quando a fila passar do que os mantenedores leem |
| 10.12 | Está publicado quem responde, em quanto tempo e por qual canal | Leitura | F |
| 10.13 | A configuração do robô de dependências diz o que fazer com versões maiores e respeita o piso declarado | Leitura | F |

## 11. Instalação — capítulo 11

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 11.1 | Instalação em uma linha, num servidor recém-criado | Registro da instalação real, com evidência | F |
| 11.2 | Nenhum passo pede editar arquivo | Execução | F |
| 11.3 | Rodar o instalador de novo não muda nada | Execução | F |
| 11.4 | Modo de ensaio e modo sem perguntas | Comando | F |
| 11.5 | Nenhum script diz que deu certo sem conferir pelo caminho do usuário | Leitura, script por script | F |
| 11.6 | A saúde tem linha por ligação entre peças, e código de saída por gravidade | Execução | F |
| 11.7 | O instalador grava com dono e permissão explícitos o que outro serviço lê | Leitura | F |
| 11.8 | Backup conferido por restauração; restauração conferida por contagem | Execução | F |
| 11.9 | Atualização com backup, saúde e volta automática, exercitada entre duas versões | Execução: uma atualização que quebra de propósito | L |
| 11.10 | Diagnóstico com segredos mascarados | Execução | F |
| 11.11 | Proxy já existente é detectado | Execução | F |
| 11.12 | A versão em execução se vê de fora | Execução | F |
| 11.13 | Instalado na VPS do parceiro **e** em outra | Registro da instalação real, com evidência das duas | F |
| 11.14 | Erro do kit diz a causa e o próximo comando | Leitura | F |
| 11.15 | Nenhum padrão do instalador aponta para recurso que não sustenta produção sem avisar | Leitura | F |
| 11.16 | O instalador termina conferindo que a tela de entrada aceita o usuário criado | Execução | F |
| 11.17 | O README declara os ambientes em que a instalação é provada, e o que fazer nos outros | Leitura | F |
| 11.18 | Os segredos são separados por quem usa; a aplicação não recebe a senha de dono do banco | Leitura | F |
| 11.19 | O kit recusa rodar de uma pasta que não é a da instalação | Execução | F |
| 11.20 | Toda porta que o instalador publica tem um uso que funciona naquele modo de instalação; o que não tem uso fica só local | Leitura do instalador, modo por modo | F |
| 11.21 | O CI roda o instalador de verdade, com contêineres, num ambiente descartável, até o usuário criado entrar | Leitura do workflow | F |
| 11.22 | Sem domínio, o padrão do instalador não publica a tela de entrada sem conexão segura | Leitura; teste do kit | F |
| 11.23 | Tudo o que o navegador usa chega pela mesma origem do painel. Se houver uma segunda porta, a tela testa o alcance dela e nomeia o que falta | Leitura do proxy e do instalador; teste de tela | F |
| 11.24 | Existe uma entrada que roda no computador da pessoa, antes do servidor: o que é preciso, o tamanho da máquina, o parceiro declarado, o comando seguinte | Arquivo; execução | F |
| 11.25 | Opção passada num modo em que não tem efeito para a instalação com erro; o valor é validado em todo modo; o endereço anunciado no fim é o que foi testado | Teste do kit: a opção em cada modo; leitura da mensagem final | F |

## 12. Distribuição — capítulo 12

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 12.1 | Nenhum serviço de produção sem imagem publicada | Arquivo: a cerca | F |
| 12.2 | O instalador recusa, com erro claro, instalar uma versão publicada que não tem imagem. Depois da primeira versão, construir na VPS só acontece pedido de propósito (uma opção com nome), e o instalador diz o que custa e por que não há imagem (arquitetura sem imagem publicada, versão de desenvolvimento, emergência) | Leitura do instalador | F |
| 12.3 | A instalação grava número de versão, e não canal, e o código instalado é o da mesma versão das imagens | Execução | F |
| 12.4 | O nome da imagem e o formato da versão têm uma fonte só | Leitura | F |
| 12.5 | Imagens para as arquiteturas declaradas. Declarar menos arquiteturas do que o produto já suportou pede registro de decisão | Leitura do workflow e do README | F |
| 12.6 | Etiqueta só nasce no CI, do ramo principal: a publicação de imagens recusa etiqueta cujo commit não está no ramo principal, e o repositório restringe quem cria etiqueta de versão | Leitura do workflow; comando | F |
| 12.7 | Notas por fragmento, com o efeito no operador; número calculado | Arquivo: a cerca | F |
| 12.8 | "Exige ação" é um bloco do fragmento, com o passo exato | Leitura | F |
| 12.9 | Versão cortada inteira pelo CI, com o ramo principal verde | Execução | L |
| 12.10 | Documentação e tela nos idiomas declarados | Leitura | F |
| 12.11 | O "como fazer" mora no repositório, e o roteiro de corte de versão inclui conferi-lo | Leitura | F |
| 12.12 | Quem administra atualiza pela tela: versão em execução, versão nova, o que mudou, um botão, e o resultado | Teste de tela, ou execução | L |
| 12.13 | O aplicativo só registra o pedido; quem atualiza é um agente do kit no servidor, que lê um sim ou não | Leitura | L |
| 12.14 | Um pedido de atualização por vez, com prazo: pedido aceito e não concluído vira falha visível | Leitura; teste | L |
| 12.15 | Falha de comunicação do agente fica num registro que persiste, e a tela diz que o agente não está respondendo | Leitura; execução | L |
| 12.16 | As imagens publicadas baixam sem credencial, numa máquina que nunca entrou no registro | Execução | L |
| 12.17 | O passo que cria a etiqueta decide pelo commit que mudou a versão nas notas, e não depende de ser o último envio ao ramo principal, nem de o PR de versão entrar como um commit só (ou o repositório só aceita squash) | Leitura do workflow e da configuração de merge | L |
| 12.18 | A página da versão só é publicada depois de as imagens baixarem sem credencial | Leitura do workflow | L |
| 12.19 | Quando a atualização troca um arquivo de configuração montado num contêiner, ela faz o contêiner ler o novo (reinício ou recarga), na ida e na volta | Teste do kit contando os dois caminhos; numa instalação real, a configuração em uso é a nova | F |
| 12.20 | O corte de versão confere os documentos de entrada (README, documento de autoridade, skill de instalar, roteiro de quem chega): nenhuma frase de estado contradiz o que a versão entrega | Leitura do PR de versão: a conferência está registrada nele | L |

## 13. Método — capítulo 00

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 13.1 | Existe o desenho da fundação, com decisões do dono e do construtor separadas | Arquivo | F |
| 13.2 | A tabela "erros que esta fundação fecha" cobre `licoes.md`, lição por lição | Leitura | F |
| 13.3 | Houve revisão fria, e o parecer está guardado | Arquivo | F |
| 13.4 | Cada bloqueador da revisão fria foi fechado, com a mudança que o fechou | Leitura | F |
| 13.5 | Houve instalação real antes da publicação. Se a ordem foi invertida, o registro diz, e a instalação foi feita em seguida | Registro com evidência | F |
| 13.6 | As lições novas foram devolvidas à Fábrica | Contribuição aberta no repositório dela | L |
| 13.7 | Um caminho de ponta a ponta foi executado pelas entradas reais, antes e depois da revisão fria | Registro | F |
| 13.8 | O dono usou o produto, e o que ele não conseguiu fazer está escrito | Arquivo | F |
| 13.9 | Existe a lista do que está configurado e ainda não foi exercitado | Arquivo | F |

## 14. Site — capítulo 13

Todo produto tem site. Ele é de nível L: entra depois da primeira versão publicada, porque a
página de instalar e as notas de versão dependem dela, e antes da divulgação.

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 14.1 | O site mora em repositório separado do produto | Comando | L |
| 14.2 | As notas de versão são lidas do produto, e a página falha alto se a leitura falhar | Leitura | L |
| 14.3 | O corte de versão do produto reprova se a versão não aparecer no site | Leitura do workflow | L |
| 14.4 | Os comandos e requisitos da página de instalar são os do kit, por leitura, geração ou teste de paridade | Arquivo: o teste, ou o gerador | L |
| 14.5 | Toda skill do produto tem entrada na página de guias, por geração ou teste de paridade | Arquivo: o teste, ou o gerador | L |
| 14.6 | Todo conteúdo copiado do produto tem teste de paridade rodando no CI do site, e a última execução dele está verde | Leitura do CI | L |
| 14.7 | Números sociais são lidos da fonte | Leitura | L |
| 14.8 | A data de atualização vem de uma constante só | Comando: busca | L |
| 14.9 | O conteúdo está no texto servido, sem depender de script | Execução: a página com scripts desligados | L |
| 14.10 | Existe o arquivo de resumo para assistentes, com o passo zero | Arquivo | L |
| 14.11 | O parceiro aparece declarado, com marcação de link patrocinado e o mesmo endereço do repositório | Leitura | L |
| 14.12 | Os idiomas têm a mesma estrutura, obrigada por tipo e por teste. Com um idioma só, não se aplica | Arquivo: o teste | L |
| 14.13 | Existe o contrato de marca do site | Arquivo | L |
| 14.14 | O curso é capturado do aplicativo real, com dados fictícios, procedência por foto e recibo de publicação | Leitura do roteiro e do recibo | L. Pode ficar para depois da divulgação se o desenho disser quando |

## 15. Equipe autônoma — capítulo 14

De nível L: a equipe que mantém o projeto existe antes da divulgação. O desenvolvimento
autônomo é de nível C.

Se o dono decidiu não ter equipe, os itens desta seção são "decidido diferente", com a decisão
escrita e com quem faz cada papel no lugar dela: quem tria os PRs, quem responde à comunidade,
quem revisa o que entra. O 15.6 vale com ou sem equipe.

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 15.1 | O produto tem uma empresa própria na ferramenta de orquestração, numa VPS que não é de produção | Execução | L |
| 15.2 | A definição da empresa (agentes, instruções, rotinas) mora num repositório, e a empresa foi recriada dali num teste | Arquivo; registro do teste | L |
| 15.3 | Existem, no mínimo: líder, maestro de contribuições, revisor, integrador, suporte e guardião da instalação | Leitura do organograma | L |
| 15.4 | Cada instrução diz o que não é do agente, e traz os blocos do contrato comum | Leitura | L |
| 15.5 | A equipe usa uma conta de robô do produto, sem poder sobre workflows, e nenhuma credencial pessoal do dono | Leitura dos nomes e escopos das credenciais | L |
| 15.6 | A regra do ramo principal não dá passagem a administrador, e a equipe não escreve nele sem contribuição revisada | Comando | L |
| 15.7 | Cada papel recebe só as credenciais que usa; quem não mescla não tem a credencial de quem mescla | Leitura | L |
| 15.8 | Está escrito, canal por canal, o que a equipe publica sozinha e o que é rascunho | Leitura | L |
| 15.9 | Está escrito o que nunca sai da mão do dono | Leitura | L |
| 15.10 | O canal de decisão do dono tem checagem de que está de pé e rota de reserva | Execução: derrubar o canal num ensaio | L |
| 15.11 | Um vigia sem IA pausa agente por falha repetida e por teto de execuções, e avisa | Execução: o modo de ensaio | L |
| 15.12 | A cópia de segurança da ferramenta leva banco, chave de segredos e arquivos dos agentes, e a falha dela dá alarme | Execução | L |
| 15.13 | A capacidade foi medida: execuções por dia por rotina, e a equipe passou uma semana sem execução perdida por cota | Registro | L |
| 15.14 | A conta em que os agentes rodam não é a das sessões de trabalho do dono | Leitura | L |
| 15.15 | Rotina de alta frequência só acorda o agente se houver o que fazer | Leitura | L |
| 15.16 | Existe o procedimento de atualização da ferramenta, e a versão do assistente dos agentes é fixada | Arquivo | L |
| 15.17 | Há observador de mercado, com relatório datado e fontes | Leitura | C: quando o roteiro depender do mercado |
| 15.18 | Desenvolvimento autônomo: o dono aprova o roteiro em lote; uma funcionalidade por vez; caminho sensível passa pelo dono; quem constrói não verifica | Leitura; registro de uma funcionalidade | C: quando a equipe de manutenção passar um mês estável |
