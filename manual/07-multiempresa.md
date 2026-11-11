# 07. Multiempresa

> Uma instalação pode servir várias organizações, e os dados de uma nunca aparecem para outra.
> A lição dos dois produtos é a mesma: isolamento que depende de alguém lembrar acaba furado, e
> lista mantida à mão deixa de fora a tabela nova.

## Decisões a registrar

| Decisão | Ponto de partida |
|---|---|
| Toda tabela nasce com dono? | Sim, desde a primeira migration, mesmo que a tela opere uma organização |
| Qual é a porta única de acesso? | Uma função do núcleo que abre a transação já presa à organização |
| Que operações atravessam organizações? | Uma lista curta, escrita |
| Com que papel do banco a aplicação conecta? | Um papel sem poder de contornar o isolamento |
| Como o teste descobre as tabelas? | Lendo o catálogo do banco |
| Onde a organização é resolvida? | Na sessão, na chave ou no segredo de quem chama |
| Há recurso físico compartilhado? | Regra de posse escrita, que falha fechado |

## As regras

### 1. Toda tabela tem organização desde a primeira migration

Com as exceções nomeadas (a própria tabela de organizações e a de controle de migrations).

*O porquê:* acrescentar isolamento depois é a migração mais cara que existe. O banco nasce
multiempresa mesmo quando a tela ainda não é.

### 2. Uma porta única, e ninguém filtra à mão

O código de produto não escolhe a organização em cada consulta. Ele entra por uma porta que já
prende a transação à organização, e o banco recusa o resto.

*O erro:* no primeiro produto, o caminho com poder total sobre o banco pedia que cada rota
lembrasse de filtrar. A maior parte dos avisos de segurança do projeto veio de um filtro
esquecido, e uma mensagem chegou a poder cair na organização errada.

| | Primeiro produto | Segundo produto |
|---|---|---|
| Mecanismo | Regras de linha no banco, mais filtro manual no caminho privilegiado | Função única no núcleo, mais regras de linha forçadas |
| Cobrança | Análise do código, criada depois dos incidentes | Cerca que reprova acesso direto fora do núcleo, desde o início |

### 3. O acesso que atravessa organizações é nomeado e listado

Algumas operações são de sistema: migrations, rotinas agendadas, o primeiro usuário. Elas usam
uma segunda porta, com outro nome, e só em arquivos que constam de uma lista com o motivo de
cada um.

*O erro, no segundo produto:* antes da lista, uma rota nova que usasse a porta de sistema
passava em todas as cercas.

### 4. A organização vem de fonte confiável

Da sessão, de uma chave de API, do segredo de um webhook, de um token no caminho. Nunca do corpo
da requisição.

### 5. A prova é de comportamento, e a lista de tabelas vem do catálogo

O teste cria duas organizações, grava em uma e tenta ler e alterar pela outra, para toda tabela.
A lista de tabelas é lida do banco.

*Os erros:* uma regra de isolamento escrita com uma condição sempre verdadeira deixava tudo
passar, com a proteção "ligada" e o teste verde. E o teste cobria uma lista fixa, então tabela
nova entrava sem prova.

Conferir que a proteção está ligada não prova nada. O que prova é a tentativa de atravessar.

### 6. A prova roda com o papel e as permissões do banco real

*O erro:* o banco de teste do primeiro produto não reproduzia as permissões padrão do banco de
produção. O teste ficou verde enquanto funções internas eram alcançáveis por quem não estava
logado.

O teste conecta com o mesmo papel que a aplicação usa, num banco criado pelo mesmo caminho que o
instalador usa.

### 7. Toda função privilegiada responde três perguntas

Para cada função do banco que roda com poder elevado: quem pode executá-la, se ela recebe a
organização como argumento, e se confere que quem chamou pertence a ela. Um teste varre todas, e
não uma lista.

Função nova nasce fechada: o acesso é retirado de todos e concedido só a quem precisa.

### 8. Ligação entre tabelas leva a organização junto

A verificação de chave estrangeira do banco não passa pelas regras de isolamento. Uma linha
poderia apontar para outra de uma organização diferente. A chave composta com a organização
impede.

### 9. O papel da aplicação não contorna o isolamento

O papel com que a aplicação conecta não tem poder de ignorar as regras, e não é membro do papel
de sistema.

### 10. Recurso compartilhado: sem prova de posse, falha fechado

Alguns recursos existem fora do banco e são compartilhados por natureza: um endereço de rede, um
número, uma conta num provedor. Quando duas organizações podem reivindicar o mesmo e não há
como provar de quem é, a operação é recusada, e a mensagem não revela a outra organização.

*O erro, no segundo produto:* o banco era multiempresa e a tela operava uma organização. A
conferência de posse foi deixada de lado com o argumento "só existe uma". Isso custou três
rodadas de correção de segurança.

A regra geral que sai daí: **o banco multiempresa e a tela de uma organização não autorizam
nenhum atalho no código.** Toda rota é escrita como se houvesse duas.

### 11. Auditoria é só de acréscimo, e isso é do banco

Nenhum papel tem permissão de alterar ou apagar registro de auditoria. Confere-se nas
permissões do banco, e não na documentação. A retenção é executada por uma função que não
aceita escolher linha, só idade, com um piso mínimo dentro dela.

## Como saber que ficou pronto

- O teste de isolamento falha quando uma tabela nova entra sem regra.
- Uma rota nova que use a porta de sistema fora da lista é reprovada.
- Uma segunda organização foi criada e um usuário dela tentou cada rota da primeira.
- O que o mecanismo não cobre está escrito em limites conhecidos. No segundo produto: uma
  injeção de SQL poderia trocar de organização dentro da transação.

## O que este capítulo não resolve

Não há método geral para modelar recurso externo compartilhado. A regra 10 diz o que fazer
quando a posse não se prova; não diz como desenhar para que ela se prove.

## Origem

Doutrina de isolamento, registros de decisão `0006` e `0007`, cercas e testes do DeskVoice;
testes de invariante, análise do caminho privilegiado e doutrina de auditoria do DeskcommCRM.
