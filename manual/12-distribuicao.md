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
de construir pode existir ao lado, como saída de emergência, e nunca sozinha.

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
| Canal estável | A última versão publicada | O instalador, para descobrir o número. Ele grava o número, e não o canal |
| Topo do ramo principal | O que acabou de entrar | Quem desenvolve |

A política de baixar acompanha a etiqueta: imutável, baixa se faltar; móvel, baixa sempre.

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

## Depois de publicar

- **A versão aparece onde o público lê.** No primeiro produto, o corte confere que a página
  pública de notas mostra a versão nova.
- **A instalação descobre a versão nova sem telemetria.** Ela consulta o registro público; não
  avisa ninguém.
- **Aviso de segurança sai junto com a versão corrigida,** com uma forma de quem opera conferir
  se foi afetado.

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
