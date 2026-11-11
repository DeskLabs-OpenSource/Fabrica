# 08. Painel de administração

> Existem dois administradores diferentes num produto instalado por conta própria: o dono do
> servidor e o administrador de cada organização. Este capítulo diz como separar os dois, o que
> cada um precisa ver, e como garantir que toda tela tenha porta.

## Estado deste capítulo

Só o primeiro produto tem os dois painéis, e a separação existe no código e nos testes, sem um
documento que a explique. O segundo produto tem um painel só e três papéis, e deixou "várias
organizações pela tela" fora da fundação. As regras abaixo vêm de erro medido no primeiro; a
ordem de construção é proposta.

## Decisões do dono

1. **Uma instalação serve uma organização ou várias?** Se várias: quem cria a segunda, e por
   onde?
2. **Quem revende vai dar suporte entrando na conta do cliente?**

## Os dois administradores

| | Administrador da instalação | Administrador da organização |
|---|---|---|
| Quem é | O dono do servidor. Nasce no instalador | Quem responde por uma empresa dentro da instalação |
| O que vê | Todas as organizações, a saúde do sistema, a versão | Só a própria organização |
| Risco | Uma sessão dele vale por todas as organizações | Uma sessão dele vale por uma |

Se a instalação serve uma organização só, os dois podem ser a mesma pessoa e o mesmo painel.
Mesmo assim, as telas do dono do servidor são identificadas como tal: no primeiro produto, a
tela de atualização mora dentro do painel da organização, e o registro de navegação não
consegue dizer de quem ela é.

## O que cada painel precisa ter

**Da instalação.** O mínimo, para qualquer produto:

- saúde do sistema, peça por peça;
- versão em execução e atualização;
- organizações e usuários;
- administradores da instalação;
- modo de cadastro;
- e-mail e outros serviços da instalação;
- auditoria;
- pedidos sobre dados pessoais;
- consumo e custo por organização.

**Da organização.** O mínimo:

- equipe e papéis;
- segurança (segundo fator, sessões);
- tokens de API;
- configuração dos provedores da organização;
- auditoria da própria organização;
- custo e limites.

O que mais existir depende do produto. A lista do domínio se escreve na fundação.

## As regras

### 1. Tudo o que o operador configura tem tela

É a regra de todo o manual, e aqui ela vira inventário: para cada coisa que hoje se ajusta por
arquivo ou por comando, existe uma tela, ou uma decisão escrita de que fica no servidor.

*O erro:* no primeiro produto, um recurso anunciado pedia uma variável de ambiente que quase
ninguém sabia configurar. No segundo, a revisão fria achou cadastros que não podiam ser
corrigidos nem apagados pela tela: um número digitado errado ficava para sempre.

Toda entidade que a tela cria, a tela edita e remove.

### 2. Duas guardas

Uma barreira cedo, antes de a rota rodar, e a validação que vale dentro da rota ou do layout. A
primeira evita trabalho; a segunda é a autoridade. Nenhuma tela de administração depende só da
primeira.

### 3. O poder de instalação tem escopo

Nem todo administrador da instalação escreve. Há pelo menos dois níveis: leitura para suporte, e
total.

*O erro:* no primeiro produto, um papel criado como "só leitura para suporte" conseguia
suspender organizações, resolver incidentes e disparar atualização. As rotas conferiam se a
pessoa era administradora, e não com que escopo.

*Como se cobra:* uma verificação reprova rota de escrita que não confere o escopo total.

### 4. Acompanhar uma organização é sessão temporária, auditada

Quando o suporte precisa entrar numa organização, abre-se uma sessão com prazo e registro.
Nunca um vínculo permanente inventado para a ocasião.

### 5. Atalho de conveniência não abre poder de instalação

"Confiar neste dispositivo" e sessão longa valem para o uso comum. Para escrever com poder de
instalação, a prova é pedida de novo.

*O porquê:* um identificador roubado valeria por todas as organizações.

### 6. Toda tela tem porta, e o teste lê o disco

Uma tela existe quando alguém chega nela pelo menu. A lista de telas é derivada dos arquivos, e
um teste reprova tela que não está no registro de navegação nem numa lista de exceções com
motivo escrito.

*O erro:* no primeiro produto, uma auditoria achou várias telas alcançáveis só por dentro da
própria seção e outras sem link nenhum. Ter tela e ser alcançável são coisas diferentes.

### 7. Sinais da instalação são lidos uma vez

O que falta configurar na instalação (e-mail, um provedor, um módulo) é lido num ponto só, e
toda tela nova nasce sabendo. Assim nenhuma tela oferece uma ação que vai falhar por falta de
configuração.

### 8. Ação destrutiva pede confirmação nomeando o alvo

Apagar, suspender, redefinir: a confirmação mostra exatamente o que vai ser afetado, e o botão
só libera depois de a pessoa ver.

### 9. A saúde nunca resume tudo num "ok"

A tela de saúde mostra cada peça e cada ligação entre peças. Um verde geral esconde a peça que
está de pé e desconectada (capítulo 11).

### 10. Nada bloqueia em silêncio

Toda proteção ligada por padrão se anuncia na tela onde a pessoa espera o resultado: o que está
bloqueando e onde liberar.

*O erro:* "configurei tudo e não acontece nada" foi a dúvida que mais voltou na comunidade do
primeiro produto. Um modo de teste vinha ligado de fábrica e ninguém era avisado. Gente
experiente concluiu que o produto não funcionava.

### 11. Tela vazia explica o vazio; erro nomeia o que falta

Uma tela sem dados diz por que está sem dados e o que fazer. Uma mensagem de erro diz qual item
falta, e não a lista de tudo o que poderia faltar. Nunca se culpa a rede por uma opção
desligada.

### 12. A tela de conexão testa o pré-requisito

Integração com serviço de fora tem um botão de teste, e a resposta diz qual pré-requisito do
lado de lá falta: uma aprovação, um plano, um modo de teste. Não se repassa o erro cru do
fornecedor.

### 13. Recurso achável pela pergunta de quem usa

Um recurso só está pronto quando a pessoa o encontra pela pergunta que faria, na língua dela.
Se a mesma dúvida chega três vezes, o defeito é de descoberta, e vira item de produto.

### 14. Listas para dez vezes o exemplo, e o nível de cada ajuste decidido cedo

Cada lista é desenhada para dez vezes o volume do exemplo. E cada configuração tem o nível
decidido na fundação: da instalação, da organização ou da unidade (um agente, um plano). Mover
de nível depois é caro, e foi um dos pedidos mais repetidos no primeiro produto.

## Como saber que ficou pronto

- Uma tela nova sem entrada no menu é reprovada.
- Um administrador de leitura tentou cada rota de escrita e foi recusado.
- Uma instalação nova foi configurada por inteiro sem abrir o terminal depois do instalador.
- Cada cadastro feito pela tela foi editado e apagado pela tela.

## Não provado

- **A ordem de construção.** Proposta: primeiro a tela de saúde e a de configuração dos
  provedores, porque sem elas a instalação não fica utilizável; depois equipe e segurança;
  auditoria e custo em seguida; o painel de várias organizações por último, quando o produto
  for servir mais de uma.
- **Quando separar em dois painéis.** No segundo produto ainda é um. O critério proposto é a
  resposta à primeira decisão do dono.

## Origem

Rotas e testes de administração, de navegação e de escopo do DeskcommCRM; painel, papéis e
registro de decisão `0007` do DeskVoice; revisão fria do DeskVoice.
