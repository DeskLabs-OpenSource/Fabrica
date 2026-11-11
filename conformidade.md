# Conformidade

> A lista que diz se um produto segue a Fábrica. Serve para três momentos: ao fundar (o que
> precisa existir antes do lançamento), na revisão fria (o que conferir) e ao adaptar um produto
> que já existe.

## Como usar

- Cada item tem um jeito de conferir. **Arquivo** e **comando** são mecânicos. **Leitura** pede
  abrir e julgar. **Execução** pede rodar o sistema.
- O resultado de cada item é um de quatro: **conforme**, **não conforme**, **não se aplica**
  (com o motivo), **decidido diferente** (com o registro de decisão).
- "Decidido diferente" é resposta legítima. A Fábrica exige a decisão escrita, e não a
  obediência. O que ela não aceita é a divergência sem motivo.
- Quando um item "decidido diferente" tiver uma razão melhor que a do manual, a lição volta para
  a Fábrica (fase 10 do método).

O **nível** diz quando o item passa a valer:

- **F**: fundação. Vale antes do primeiro lançamento.
- **C**: crescimento. Vale quando a condição escrita no item aparecer.

---

## 1. Visão — capítulo 01

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 1.1 | `VISION.md` na raiz, com tese, nome, crenças, públicos, modelo, antiobjetivos, como falamos e norte | Arquivo | F |
| 1.2 | A tese fala do resultado, e não do canal ou da tecnologia | Leitura | F |
| 1.3 | Cada parte da palavra central aponta para uma peça do sistema | Leitura | F |
| 1.4 | Cada antiobjetivo aponta para o teste, a cerca ou o item de revisão que o guarda | Leitura | F |
| 1.5 | Os três tipos de "não" estão separados: fora da fundação, fora do horizonte, fora para sempre | Leitura | F |
| 1.6 | Há registro de decisão da fronteira com cada produto irmão | Arquivo | F |
| 1.7 | O README declara, por capacidade, até onde ela foi provada | Leitura | F |

## 2. Modelo de negócio — capítulo 02

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 2.1 | O parceiro está nomeado na visão e num bloco do README antes do comando de instalação | Leitura | F |
| 2.2 | O bloco diz que qualquer outra VPS funciona igual, e o link está identificado como de parceria | Leitura | F |
| 2.3 | Nenhuma pasta, arquivo ou variável leva o nome do parceiro | Comando: busca pelo nome em nomes de arquivo e de variável | F |
| 2.4 | O texto da oferta tem uma redação só | Comando: busca pelo link do parceiro; as ocorrências dizem o mesmo | F |
| 2.5 | O instalador só menciona o parceiro sob condição testada | Arquivo: o teste | F |
| 2.6 | "Caminho genérico nunca sabotado" e "sem recurso pago" são regras de produto escritas | Leitura do documento de governança | F |
| 2.7 | Telemetria: nenhuma, ou só com consentimento declarado no README | Leitura | F |
| 2.8 | Existe guia de custos: quais contas, como estimar, como o produto mede e limita | Arquivo | F |
| 2.9 | Existe guia do implementador | Arquivo | F |
| 2.10 | Todo custo de provedor aparece na tela e respeita um teto do operador | Execução | F |
| 2.11 | Marca própria é configuração em tempo de execução e sobrevive à atualização | Execução | C: quando houver revenda com marca |

## 3. Stack — capítulo 03

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 3.1 | Cada escolha estrutural tem registro de decisão com alternativas descartadas e custos | Arquivo | F |
| 3.2 | O sistema sobe sem conta em serviço de terceiros | Execução: instalação limpa | F |
| 3.3 | Dependências de terceiros com versão fixa | Leitura do arquivo de composição | F |
| 3.4 | Consumo do sistema parado medido na menor VPS do parceiro | Execução | F |

## 4. Design system — capítulo 04

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 4.1 | Existe documento de design system: direção, tokens, componentes, antipadrões, voz | Arquivo | F |
| 4.2 | Cada proibição mecânica (biblioteca, fonte, cor fora de token) tem cerca | Arquivo: a cerca | F |
| 4.3 | Componentes usam só token semântico | Comando: busca por valor solto de cor nos componentes | F |
| 4.4 | Uma fonte só de tokens | Leitura | F |
| 4.5 | Fontes versionadas no repositório; a construção não baixa de serviço externo | Leitura | F |
| 4.6 | Texto de tela só em dicionário, nos idiomas declarados | Arquivo: a cerca | F |
| 4.7 | O dono validou a direção | Registro | F |

## 5. Engenharia — capítulo 05

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 5.1 | Um documento de autoridade (`AGENTS.md`); os específicos de ferramenta só o importam | Arquivo | F |
| 5.2 | Cada convenção do documento aponta para a cerca ou o teste que a cobra | Leitura | F |
| 5.3 | Cada antipadrão traz o erro que o originou | Leitura | F |
| 5.4 | Definição de pronto em duas listas: o que o CI reprova e o que o CI não vê | Leitura | F |
| 5.5 | Um caminho de schema; migrations por carimbo de tempo | Arquivo: a cerca; não existe segundo retrato do banco | F |
| 5.6 | Um arquivo por peça; nenhuma lista central | Arquivo: a cerca | F |
| 5.7 | Fila por notificação; nenhuma tarefa que se reagenda em intervalo curto | Comando: busca por reagendamento e intervalos | F |
| 5.8 | Nenhuma variável de ambiente sem padrão | Arquivo: a cerca | F |
| 5.9 | Toda cerca tem dono, motivo e data de revisão | Arquivo: a cerca das cercas | F |
| 5.10 | Cada cerca guarda o que o texto diz que ela guarda | Leitura, cerca por cerca, contra o documento | F |
| 5.11 | Um check obrigatório que agrega os outros | Comando: a proteção do ramo | F |
| 5.12 | Check de contribuição só mede o que ela mudou; estado acumulado é do ramo principal | Leitura dos workflows | F |
| 5.13 | Cada job diz se a causa está na contribuição ou fora | Execução: um vermelho de propósito | F |
| 5.14 | O CI instala do zero e atualiza a partir da última versão, com dados | Leitura do workflow | F |
| 5.15 | O caminho central roda de ponta a ponta sem credencial, no CI | Comando: o comando de demonstração | F |
| 5.16 | As imagens constroem **e sobem** no CI | Leitura do workflow | F |
| 5.17 | Varredura de segredo no CI e antes do commit | Leitura | F |
| 5.18 | Toda afirmação "o CI prova X" aponta para um job que existe e faz isso | Leitura, afirmação por afirmação | F |
| 5.19 | Testes sem relógio real, porta fixa ou fuso | Comando: busca por data e porta literais em teste | F |

## 6. Autenticação — capítulo 06

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 6.1 | A tabela de decisões de autenticação está escrita, **incluindo o que não existe** | Leitura | F |
| 6.2 | Uma função só decide o papel; nenhuma rota compara nível à mão | Comando: busca | F |
| 6.3 | A instalação nova chega à primeira tela útil sem passo de segurança não anunciado | Execução | F |
| 6.4 | Primeiro usuário nasce pelo instalador; senha nunca como argumento | Leitura | F |
| 6.5 | Recuperação de emergência de dentro do servidor encerra as sessões | Execução | F |
| 6.6 | Login não revela quem tem conta | Execução | F |
| 6.7 | Bloqueio por tentativas não permite trancar outra pessoa só sabendo o e-mail | Leitura | F |
| 6.8 | Segredo de operador cifrado em repouso | Leitura | F |
| 6.9 | O que o produto não tem está em "limites conhecidos" | Leitura do documento de segurança | F |
| 6.10 | Segundo fator opcional, ligado pela tela, com cadastro e prova separados | Execução | C: quando houver segundo fator |
| 6.11 | Token de API: em claro uma vez, resumo no banco, nunca em endereço | Leitura | C: quando houver API pública |

## 7. Multiempresa — capítulo 07

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 7.1 | Toda tabela tem organização | Arquivo: a cerca | F |
| 7.2 | Uma porta única; acesso direto ao banco fora do núcleo é reprovado | Arquivo: a cerca | F |
| 7.3 | A porta de sistema só em arquivo listado com motivo | Arquivo: a cerca e a lista | F |
| 7.4 | O teste de isolamento tenta atravessar, e descobre as tabelas pelo catálogo | Leitura do teste | F |
| 7.5 | O teste roda com o papel da aplicação, em banco criado pelo caminho do instalador | Leitura | F |
| 7.6 | Chaves entre tabelas levam a organização | Leitura do schema | F |
| 7.7 | Todo recurso compartilhado tem regra de posse que falha fechado | Leitura; registro de decisão | F |
| 7.8 | Nenhuma rota assume "só existe uma organização" | Leitura das rotas | F |

## 8. Administração — capítulo 08

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 8.1 | Tudo o que o operador configura tem tela, ou decisão escrita de que fica no servidor | Leitura: o inventário | F |
| 8.2 | Toda entidade criada pela tela se edita e se remove pela tela | Execução | F |
| 8.3 | Toda tela tem porta no menu, e um teste lê as telas do disco | Arquivo: o teste | F |
| 8.4 | A tela de saúde mostra cada peça e cada ligação | Execução | F |
| 8.5 | Ação destrutiva pede confirmação nomeando o alvo | Execução | F |
| 8.6 | Gestão de equipe e papéis pela tela | Execução | F |
| 8.7 | Painel da instalação separado, com escopo de leitura e de escrita | Execução | C: quando a instalação servir mais de uma organização |

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
| 9.8 | Doutrina de dados pessoais: responsável, retenção executada, anonimização | Arquivo | F |
| 9.9 | Nomes de doutrina iguais aos da família para a mesma lei | Leitura | F |
| 9.10 | Existe skill de doutrina que responde "isto é permitido?" | Arquivo | F |

## 10. Contribuição — capítulo 10

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 10.1 | Repositório em organização | Comando | F |
| 10.2 | `CONTRIBUTING`, `GOVERNANCE`, `CREDITS`, `SECURITY`, `CODE_OF_CONDUCT` | Arquivo | F |
| 10.3 | Regras de produto com o porquê de cada uma | Leitura | F |
| 10.4 | Formato de pedido de decisão com padrão e prazo | Leitura | F |
| 10.5 | Proteção do ramo: aprovação de outra pessoa e fila de merge | Comando | F |
| 10.6 | Skill de contribuição com pré-voo que só mede e hooks que barram o irreversível | Arquivo | F |
| 10.7 | As ferramentas do contribuidor medem contra o repositório original | Leitura dos scripts | F |
| 10.8 | Acolhida automática que não avalia e não baixa código de fora | Arquivo: workflow e cerca | F |
| 10.9 | O modelo de contribuição diz o que é trabalho do projeto | Leitura | F |
| 10.10 | Fonte das skills em pasta neutra; espelhos gerados e conferidos | Arquivo: a cerca | F |
| 10.11 | Procedimento de triagem com medidor, reprodutor e cético | Arquivo | C: quando a fila passar do que os mantenedores leem |

## 11. Instalação — capítulo 11

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 11.1 | Instalação em uma linha, num servidor recém-criado | Execução | F |
| 11.2 | Nenhum passo pede editar arquivo | Execução | F |
| 11.3 | Rodar o instalador de novo não muda nada | Execução | F |
| 11.4 | Modo de ensaio e modo sem perguntas | Comando | F |
| 11.5 | Nenhum script diz que deu certo sem conferir pelo caminho do usuário | Leitura, script por script | F |
| 11.6 | A saúde tem linha por ligação entre peças, e código de saída por gravidade | Execução | F |
| 11.7 | O instalador grava com dono e permissão explícitos o que outro serviço lê | Leitura | F |
| 11.8 | Backup conferido por restauração; restauração conferida por contagem | Execução | F |
| 11.9 | Atualização com backup, saúde e volta automática | Execução: uma atualização que quebra de propósito | F |
| 11.10 | Diagnóstico com segredos mascarados | Execução | F |
| 11.11 | Proxy já existente é detectado | Execução | F |
| 11.12 | A versão em execução se vê de fora | Execução | F |
| 11.13 | Instalado na VPS do parceiro **e** em outra | Registro com evidência | F |
| 11.14 | Erro do kit diz a causa e o próximo comando | Leitura | F |

## 12. Distribuição — capítulo 12

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 12.1 | Nenhum serviço de produção sem imagem publicada | Arquivo: a cerca | F |
| 12.2 | Depois da primeira versão, instalar sem imagem é erro claro, e não construção na VPS | Leitura do instalador | F |
| 12.3 | A instalação grava número de versão, e não canal | Execução | F |
| 12.4 | O nome da imagem e o formato da versão têm uma fonte só | Leitura | F |
| 12.5 | Imagens para as arquiteturas declaradas | Leitura do workflow | F |
| 12.6 | Etiqueta só nasce no CI, do ramo principal | Leitura do workflow | F |
| 12.7 | Notas por fragmento, com o efeito no operador; número calculado | Arquivo: a cerca | F |
| 12.8 | "Exige ação" é um bloco do fragmento, com o passo exato | Leitura | F |
| 12.9 | Versão cortada inteira pelo CI, com o ramo principal verde | Execução | F |
| 12.10 | Documentação e tela nos idiomas declarados | Leitura | F |

## 13. Método — capítulo 00

| Nº | Exigência | Como conferir | Nível |
|---|---|---|---|
| 13.1 | Existe o desenho da fundação, com decisões do dono e do construtor separadas | Arquivo | F |
| 13.2 | A tabela "erros que esta fundação fecha" cobre `licoes.md`, lição por lição | Leitura | F |
| 13.3 | Houve revisão fria, e o parecer está guardado | Arquivo | F |
| 13.4 | Cada bloqueador da revisão fria foi fechado, com a mudança que o fechou | Leitura | F |
| 13.5 | Houve instalação real antes do lançamento | Registro com evidência | F |
| 13.6 | As lições novas foram devolvidas à Fábrica | Leitura de `licoes.md` | F |
