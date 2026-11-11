# 11. Instalação

> Quem instala numa VPS é o usuário, e a experiência de instalar é o produto. Uma mudança que
> funciona na máquina de quem desenvolve e quebra numa instalação nova é defeito de produto.

## A promessa

Uma pessoa que não programa entra numa VPS recém-criada, cola uma linha, responde poucas
perguntas e chega a um painel funcionando. Daí em diante, tudo é pela tela.

*Por que isso pesa tanto:* instalação e erros depois dela foram a reclamação mais repetida do
público do primeiro produto, à frente de qualquer recurso.

## Decisões a registrar

| Decisão | Ponto de partida |
|---|---|
| Que perguntas o instalador faz | Domínio, nome da empresa, nome, e-mail e senha do dono. Nada além |
| Que arquiteturas de processador são suportadas | As duas comuns em VPS, desde a primeira versão |
| O que acontece se a VPS já tem um proxy | O instalador detecta e se adapta |
| A atualização volta sozinha se quebrar? | Sim |
| Atualizar pela tela ou pelo terminal | Terminal na fundação; tela depois |
| Onde fica o backup | Na máquina, com aviso de que copiar para fora é de quem opera |

## O kit

Uma pasta com nome genérico (`install/`), sem o nome do parceiro (capítulo 02).

| Script | Faz | Confere antes de dizer que deu certo |
|---|---|---|
| Entrada de uma linha | Baixa o repositório e abre o instalador | — |
| Instalador | Confere a máquina e a rede, pergunta, gera os segredos, sobe tudo, cria o primeiro usuário | Cada peça essencial respondendo |
| Checagem de saúde | Uma linha por peça e por ligação entre peças | Não resume |
| Backup | Copia o banco e a configuração | Restaura num banco de rascunho e conta as linhas |
| Restauração | Substitui o banco por um backup, com confirmação digitada | Compara as contagens com o manifesto do backup |
| Atualizador | Backup, troca de versão, migrations, saúde | Se uma peça essencial não responde, volta e restaura |
| Diagnóstico | Gera um arquivo para enviar a quem vai ajudar | Segredos mascarados, dados pessoais encurtados |
| Recuperação de senha | Troca a senha do dono de dentro do servidor | Encerra as sessões |
| Testes do kit | Rodam sem Docker | Saem com erro se algo falhar |

## As regras

### 1. Nada que exija editar arquivo na VPS

Nem na instalação, nem na atualização, nem para ligar um recurso. Variável nova nasce com
padrão, ou é o atualizador que a acrescenta. O arquivo de ambiente só guarda o que o instalador
gera.

*Como se cobra:* uma cerca reprova variável de ambiente sem padrão que não esteja na lista do
que o instalador gera.

### 2. Rodar de novo não quebra nada

O instalador retoma de onde parou e nunca troca um segredo que já existe. Se um valor precisa
mudar (endereço novo, domínio novo), roda-se o instalador de novo.

Ele tem um modo que mostra o que faria sem alterar nada, e um modo sem perguntas, que lê as
respostas de variáveis. O segundo é o que torna o instalador testável.

### 3. "Pronto" só depois de conferir

Nenhum script do kit diz que deu certo sem ter verificado o resultado.

*Os erros:* no primeiro produto, o instalador dizia "concluído" com o site fora do ar; o backup
dizia "concluído" sem parte dos dados; a restauração dizia "restaurado" sem restaurar.

A conferência usa o mesmo caminho que o usuário vai usar. Um contêiner "saudável" por uma
verificação interna não prova que o domínio responde.

### 4. A saúde confere as ligações, e nunca resume

Cada peça de pé não significa que elas se falam. A checagem de saúde tem uma linha para cada
peça e uma para cada ligação entre peças.

Três estados: funcionando, aviso (falta configurar, não é defeito) e falha. O código de saída
distingue falha de peça essencial de falha de peça secundária, para servir a monitoramento.

*O erro:* na primeira instalação real do segundo produto, todos os serviços estavam de pé e um
não conseguia ler o que o outro gravava. A capacidade central não funcionava, e nada dizia.

### 5. O instalador grava com permissão explícita

Tudo o que um serviço vai ler é gravado pelo instalador com dono e permissão declarados. Não se
depende da configuração da máquina nem do usuário que rodou.

*O erro:* é o defeito da primeira instalação real do segundo produto. Quem instalava tinha
restringido as permissões padrão da sessão, para proteger um arquivo de senha, e o instalador
herdou. Um servidor endurecido daria o mesmo resultado. Nenhum teste viu, porque os testes do
kit usam um substituto do Docker.

*Como se cobra:* o teste do kit roda o instalador com as permissões padrão restritas.

### 6. Segredos separados por quem usa

O instalador gera os segredos e os divide em arquivos, para cada contêiner receber só o que
usa. A aplicação não recebe a senha de dono do banco.

A senha do primeiro usuário nunca passa como argumento de comando.

### 7. Atualização com backup antes e volta automática

O atualizador faz backup, troca a versão, aplica as migrations e confere a saúde. Se uma peça
essencial não responde, volta para a versão anterior e restaura o banco.

*O erro:* no primeiro produto, atualizações deixaram instalações presas numa página de
manutenção, e houve atualização sem backup.

**O atualizador que roda é o da versão antiga.** Por isso o CI testa a atualização a partir da
última versão publicada, e não só a partir do código atual (lição E3).

### 8. Uma instalação, um dono dos contêineres

Duas cópias do repositório na mesma máquina, as duas mandando nos mesmos contêineres, derrubam
o serviço. O kit confere de qual pasta a instalação foi feita e recusa rodar de outra.

### 9. O que o instalador chama é testado pela linha de comando

Um comando usado pelo instalador é testado como o instalador o chama, com os argumentos de
verdade. O teste da função interna não vê o erro de argumento.

### 10. A versão em execução se vê de fora

Uma rota pública diz que versão está rodando, lendo o que está em execução. A tela de versão
não afirma "é a mais recente" com dado guardado.

### 11. A mensagem de erro diz a causa e o próximo passo

Toda falha do kit termina com o que aconteceu e o comando a rodar. Um defeito de infraestrutura
nunca aparece para o usuário como outra coisa: no primeiro produto, o banco sobrecarregado
aparecia como "e-mail ou senha incorretos".

### 12. Proxy já existente

Muitas VPS já têm um proxy reverso. O instalador detecta e usa um arquivo de composição
adicional. Todo comando posterior carrega os dois arquivos; o kit faz isso por uma função só,
para ninguém esquecer.

## Como o kit é provado

| Nível | O que prova | O que não prova |
|---|---|---|
| Testes do kit, com um substituto do Docker | A lógica dos scripts: perguntas, retomada, validações | Nada sobre a máquina real |
| CI: instalação do zero e atualização com dados | O banco chega ao mesmo estado pelos dois caminhos | Rede, permissões, proxy |
| CI: as imagens constroem e sobem | Os processos iniciam | Que se falam |
| **Primeira instalação real** | O produto que se distribui | — |

O último nível é a fase 8 do método, e não tem substituto. No segundo produto ele achou o que
os três primeiros deixaram passar.

Meta, ainda não alcançada em nenhum dos dois produtos: uma instalação limpa numa VPS de verdade
como portão de cada versão, numa máquina que não é a do parceiro e em cada arquitetura
suportada.

## Como saber que ficou pronto

- Uma pessoa que não programa instalou seguindo só o README.
- A instalação foi feita na VPS do parceiro **e** em outra.
- O instalador foi rodado duas vezes seguidas sem efeito na segunda.
- Um backup foi restaurado em outra máquina e o sistema voltou.
- Uma atualização que quebra de propósito voltou sozinha.
- A checagem de saúde acusou uma ligação cortada de propósito.

## Origem

Kit de instalação e primeira instalação real do DeskVoice; kit, doutrina de empacotamento e
issues de instalação do DeskcommCRM; comentários do público do primeiro produto.
