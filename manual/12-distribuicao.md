# 12. Distribuição

> Como uma mudança sai do repositório e chega a quem já instalou. O que a pessoa instala é o
> produto; o repositório é a receita. Este capítulo cobre imagens, versões e notas de versão.

## A pergunta que decide tudo

**Quando isto muda, quem paga a construção?** Nunca o cliente.

## Decisões do dono

1. **Onde as imagens são publicadas.** O endereço entra em toda instalação e não se troca
   depois. Por isso a organização vem antes do primeiro commit (capítulo 10).
2. **Quem corta uma versão maior.** Só o dono. Nenhum agente e nenhuma automação.

## Imagens

### 1. Nenhum serviço é construído na máquina do cliente

Todo serviço do arquivo de composição de produção aponta para uma imagem publicada. A instrução
de construir pode existir ao lado, e nunca sozinha. Ela serve a quem a pede de propósito: numa
arquitetura sem imagem publicada, numa versão de desenvolvimento ou numa emergência. O instalador
diz o que custa e por que não há imagem.

*O erro:* no primeiro produto, um dos serviços não tinha imagem publicada. Era construído na
VPS de cada cliente na instalação, e depois disso nenhuma atualização o reconstruía. Ele nunca
era atualizado.

*Como se cobra:* uma cerca reprova serviço de produção sem imagem.

**Divergência a resolver no segundo produto.** O instalador dele constrói na VPS quando a
versão ainda não tem imagem publicada. É uma saída razoável durante a fundação, antes da
primeira versão, e é o padrão que a lição acima proíbe depois dela. A revisão fria ainda achou
que um desencontro no formato do nome da versão fazia toda atualização cair nesse caminho. A
regra: depois da primeira versão publicada, instalar sem imagem é erro com mensagem clara, e
não construção silenciosa.

### 2. Publicar é ato do CI

Nunca da máquina de alguém. Uma imagem construída num processador diferente do da VPS não roda
lá, e a falha só aparece no cliente.

O CI constrói para as arquiteturas suportadas, e uma contribuição que quebra a construção de
qualquer imagem é reprovada antes de entrar. O job não só constrói: sobe cada imagem e confere
que o processo inicia (lição D8).

### 3. Instalação aponta para número de versão

Uma etiqueta móvel significa uma coisa diferente a cada dia. Uma instalação presa a ela não
sabe o que está rodando, e duas instalações "iguais" não são.

| Etiqueta | Significa | Quem usa |
|---|---|---|
| Número da versão | Imutável | Toda instalação de cliente |
| Canal estável | A última versão publicada | Ninguém instala por ele. Se existir, está escrito que não é para instalação |
| Topo do ramo principal | O que acabou de entrar | Quem desenvolve |

A política de baixar acompanha a etiqueta: imutável, baixa se faltar; móvel, baixa sempre.

**De onde o instalador tira o número.** Das etiquetas de versão do repositório, e não do
registro de imagens. O registro responde igual, a quem não tem credencial, para imagem que não
existe e para imagem privada, e por isso não serve para dizer "ainda não há versão". O
repositório é público e não avisa ninguém.

**O código e as imagens são da mesma versão.** Quem instala fica com o código da etiqueta, e
não com o topo do ramo principal: o arquivo de composição e o kit de um commit mais novo rodando
com imagens de uma versão anterior é uma combinação que ninguém testou. Vale para a entrada de
uma linha e para quem clonou à mão.

**Divergência a resolver no segundo produto.** O instalador grava o canal estável como versão
da instalação, e só o atualizador fixa um número depois.

### 4. A etiqueta nasce no CI, de um commit do ramo principal, e nunca se move

Conserto é a versão seguinte. Etiqueta movida quebra a atualização de quem já a tinha, com uma
mensagem que aponta para outro lugar.

### 5. O nome da imagem e o formato da versão têm uma fonte só

O que o CI publica e o que o instalador pede são lidos do mesmo lugar. No segundo produto, um
lado escrevia a versão com um prefixo e o outro sem, e a atualização nunca encontrava a imagem
(lição E11).

### 6. Dependência de terceiros é referenciada com versão fixa

E nunca republicada pelo projeto. Republicar software de terceiros pode violar a licença dele.

## Versões

### O número responde a uma pergunta

**O que quem opera uma instalação precisa fazer?**

Cada mudança que o operador percebe traz um fragmento: um arquivo pequeno numa pasta própria.
Ele declara o efeito no operador, e o número é calculado a partir do conjunto.

| O fragmento declara | Versão |
|---|---|
| Nada mudou para quem opera (conserto) | Correção |
| Dá para fazer algo que antes não dava | Menor |
| Quem atualiza precisa fazer algo | Menor, com o aviso em destaque |
| — | Maior: só por decisão do dono |

*Por que um arquivo por mudança:* um arquivo de notas editado por todos dá conflito em toda
contribuição paralela, e um número digitado depende de alguém lembrar o último. É a regra de um
arquivo por peça (capítulo 05) aplicada às notas.

### "Exige ação" é um campo, e não um número

Quem atualiza precisa fazer algo? Isso é dito num bloco próprio do fragmento, com o passo
exato. Não se usa o número maior para avisar.

*O erro:* no primeiro produto, um aviso de ação necessária saiu rebaixado, porque marcá-lo
forçaria uma versão maior que ninguém queria cortar.

Antes disso vale a regra do capítulo 11: uma atualização não deveria pedir ação. Se pede, vira
um pedido de decisão com plano de migração.

### A primeira versão não pede ação a ninguém

Antes da primeira versão não existe instalação a atualizar. Os fragmentos escritos durante a
fundação que diziam "quem já instalou precisa..." falam de instalações de teste. No primeiro
corte eles entram como mudança comum, e a nota da versão não sai com o aviso de "requer
atenção".

*O erro:* a primeira versão do segundo produto foi publicada com o título "requer atenção antes
de atualizar" e três instruções para quem já tinha instalado. Era a primeira coisa que quem
chegava ao repositório lia.

### O fragmento é escrito para quem opera

Um parágrafo, na voz de quem usa e nunca viu o código, terminando com o crédito a quem fez. O
título vira a linha da nota de versão: confere-se que ele afirma o que a mudança faz, porque a
máquina só valida a forma.

### Forma, e não presença

O CI confere que todo fragmento é bem formado. Não reprova contribuição sem fragmento: isso
barraria atualização automática de dependência, contribuição de fora e a própria contribuição
de versão. A presença é cobrada na revisão, e escrever o fragmento que falta é trabalho do
projeto.

## Cortar uma versão

Dois atos, os dois pelo CI.

1. **Abrir.** Um comando lê os fragmentos, calcula o número, monta a seção das notas, apaga os
   fragmentos e abre uma contribuição de versão.
2. **Cortar.** Aceitar essa contribuição cria a etiqueta, publica as imagens, promove o canal
   estável e confere que as imagens estão no registro.

Regras:

- **Só se corta com o ramo principal verde.**
- **Nada entra durante o corte.** No primeiro produto, contribuições aceitas minutos antes
  ficaram fora das notas. O congelamento é feito pela máquina.
- **A nota é gerada do que está na etiqueta,** e não do que se lembrava.
- **O canal estável só é promovido depois de todas as imagens publicadas.**
- **"Versão publicada" quer dizer instalável.** A página da versão no repositório só aparece
  depois de as imagens estarem no registro e baixarem sem credencial. Senão existe uma janela em
  que a versão está anunciada e ninguém consegue instalá-la.
- **O corte não depende de ser o último envio.** O passo que cria a etiqueta decide pelo commit
  que mudou a versão nas notas, e não pelo envio que o disparou. Outro envio ao ramo principal,
  logo em seguida, não pode fazer o corte se perder.
- **Uma arquitetura lenta não segura a outra.** Cada arquitetura constrói no seu job; a falha ou
  a demora de uma não impede a publicação da outra antes de se saber o motivo.

## Atualizar pela tela

Todo produto deixa quem opera atualizar pela própria interface: ver a versão que está rodando,
a versão nova, o que mudou entre as duas, e um botão. Quem instala não é de infraestrutura, e
uma atualização que pede terminal é uma atualização que não acontece.

### O desenho

O aplicativo roda em contêiner e **nunca toca no orquestrador da máquina**. Quem atualiza é um
agente pequeno do kit de instalação, que roda no servidor de tempos em tempos:

1. O agente anuncia ao aplicativo a versão instalada.
2. A tela mostra a versão em execução, a mais recente publicada e as notas das versões entre
   as duas, com os avisos de "exige ação" em destaque. A versão mais recente é lida do registro
   público; a instalação não avisa ninguém.
3. Quem administra a instalação clica em atualizar. O aplicativo só registra o pedido.
4. Na próxima passada, o agente lê **um sim ou não**, e não um comando. Se sim, roda o
   atualizador da versão publicada: backup, troca, migrations, saúde, volta se quebrar
   (capítulo 11).
5. O agente devolve o resultado, e a tela mostra: funcionou, ou voltou e por quê.

### As regras

- **O aplicativo pede; não executa.** Entre os dois passa um booleano. Um aplicativo capaz de
  mandar comandos ao servidor seria uma porta de administração remota.
- **Só quem administra a instalação pede,** e com a identidade confirmada de novo.
- **Um pedido por vez, e todo pedido termina.** Um pedido que o agente aceitou e não concluiu
  tem prazo: vencido, vira falha visível, e outro pode ser feito.
- **Falha de comunicação do agente fica num registro que persiste.** Senão o sintoma vira "o
  botão não aparece" e ninguém sabe por quê.
- **O agente confere que a pasta de onde roda é a dona da instalação,** antes até de anunciar a
  versão.
- **O agente não morre calado.** Nenhum passo dele pode derrubar o script depois de ter dito ao
  aplicativo que ia executar.
- **A tela de versão lê o que está em execução.** Nunca afirma "é a mais recente" com dado
  guardado.
- **O agente que roda é o da versão antiga.** O que ele precisa fazer de novo numa atualização
  tem de estar no atualizador da versão de destino, e é testado a partir da versão anterior.

*Os erros,* todos do primeiro produto: uma atualização pela tela deixou a instalação fora do ar
sem recuperação; um pedido aceito e nunca concluído travou todos os seguintes; a tela anunciou
por dias uma versão que não estava no ar; o agente falhava em silêncio e o botão sumia.

O segundo produto ainda não tem a atualização pela tela. É item de fundação.

## Depois de publicar

- **A versão aparece onde o público lê.** No primeiro produto, o corte confere que a página
  pública de notas mostra a versão nova.
- **A instalação descobre a versão nova sem telemetria.** Ela consulta o registro público; não
  avisa ninguém.
- **Aviso de segurança sai junto com a versão corrigida,** com uma forma de quem opera conferir
  se foi afetado.

## Documentação de uso

**Vídeo divulga; a documentação mora no repositório.** O "como fazer" é escrito, conferido
contra o produto a cada versão, e todo vídeo aponta para ele.

*O erro:* no primeiro produto o vídeo era a documentação, e envelhecia mais rápido que o
produto. A tela mudava depois do vídeo, e "faltou esse pedaço no vídeo" virou resposta padrão.

O material mais elogiado pela comunidade foi um curso navegável, que se percorre em vez de só
assistir. Ele é gerado a partir do produto, e por isso acompanha as versões.

## Idiomas

Documentação e tela nascem na língua do público principal, com tradução para as outras que o
projeto declara. Os identificadores do código ficam em inglês. No primeiro produto, o pedido de
outros idiomas veio depois e custou um retrabalho em toda a tela; no segundo, os três
dicionários existem desde o primeiro commit.

## Como saber que ficou pronto

- O arquivo de composição de produção não tem serviço sem imagem.
- Uma instalação nova grava um número de versão.
- Uma versão foi cortada inteira pelo CI, sem ninguém digitar número.
- Uma instalação da versão anterior foi atualizada para ela, com dados.
- A nota de versão diz, para cada item, o que muda para quem opera.

## Origem

Doutrinas de empacotamento e de versionamento e registro de decisão de distribuição do
DeskcommCRM; fragmentos, workflows de versão e de imagens do DeskVoice; revisão fria do
DeskVoice.
