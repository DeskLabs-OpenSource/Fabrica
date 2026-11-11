# 02. Modelo de negócio

> O código é gratuito e completo. O projeto se sustenta alugando distribuição: cada produto
> divulga um parceiro de infraestrutura, de forma declarada, a quem vai instalar. Este capítulo
> diz como isso entra no repositório sem quebrar a confiança de quem usa.

## O modelo, em quatro frases

1. O software é 100% open source, sem versão paga e sem recurso travado.
2. Quem instala paga a própria infraestrutura: a VPS e os provedores que o trabalho do produto
   exige. Nada disso passa pelo projeto.
3. Um parceiro de infraestrutura sustenta o projeto e ganha destaque na instalação, como
   recomendação.
4. Quem instala para terceiros pode cobrar por isso, e não deve nada ao projeto.

## Decisões do dono

Estas são **entrada obrigatória da fundação**. No segundo produto, o construtor só soube depois
de publicar que o parceiro precisava de destaque, e o instalador e o README foram refeitos.

1. **Qual empresa este produto divulga?**
2. **Qual é o texto único da oferta e o link?**
3. **Que outros custos de terceiros o usuário vai ter**, e algum deles tem parceria?
4. **O implementador vai precisar de marca própria?** E de cobrar pelo próprio sistema?

## O teste de entrada de uma ideia

Antes de fundar, a ideia passa por cinco perguntas. Elas vêm do modelo, e não do gosto.

| Pergunta | Por que importa para este modelo |
|---|---|
| Economiza ou gera dinheiro para quem usa? | É o que faz alguém instalar, e não só assistir |
| Surpreende numa demonstração? | A descoberta vem de vídeo |
| Tem motivo para ficar ligado o tempo todo? | É o uso contínuo que gera consumo de infraestrutura |
| Outra pessoa consegue vender a instalação? | Um implementador com vários clientes vale mais que muitos curiosos |
| Mantém-se sem o dono disponível todo dia? | **Eliminatória.** Se não, simplifique antes de avançar |

A terceira pergunta separa este modelo de um canal de conteúdo. Uma ferramenta que se usa uma
vez pode ter muita audiência e não sustentar nada.

## Os quatro públicos

| Público | O que quer | O que o repositório dá a ele |
|---|---|---|
| Empresa | Economizar e automatizar | Instalação em um comando, tela para tudo, custo visível |
| Implementador | Uma solução pronta para vender | Guia comercial, instalação repetível, atualização segura |
| Contribuidor | Projeto real e crédito | Skills embutidas, CI que diz de quem é a culpa, crédito como regra |
| Parceiro | Clientes recorrentes | Destaque declarado no caminho de instalação |

## As regras

### 1. O caminho genérico nunca é sabotado

Nada no instalador ou no código funciona melhor num provedor do que em outro por escolha do
projeto. O mesmo comando, em qualquer VPS, dá o mesmo resultado. A recomendação é um atalho,
nunca um pedágio.

*O porquê, escrito na visão do primeiro produto:* percepção de pegadinha mata a marca.

*Como se cobra:* é regra de produto no documento de governança, para a triagem recusar sem
consultar o dono. E o instalador é testado numa máquina que não é do parceiro (capítulo 11).

### 2. O parceiro aparece declarado, nos lugares certos

| Lugar | O que entra |
|---|---|
| `VISION.md`, seção do modelo | A parceria, nomeada |
| README, abrindo a seção de instalação | O bloco da oferta, com o link identificado como de parceria e a frase de que qualquer outra VPS funciona igual |
| Tabela de requisitos e guia de custos | A VPS do parceiro como a recomendação conveniente |
| Fim do instalador | Uma linha, e só em certa condição (regra 4) |
| Arquivo de créditos | A parceria, ao lado das dependências |

O link diz o que é e o que faz: "usar este link apoia o projeto". Nunca escondido.

### 3. Uma oferta, uma redação, um lugar de origem

O texto da oferta é escrito uma vez e os outros lugares o repetem. Duas redações da mesma oferta
viram duas ofertas.

### 4. O instalador só menciona o parceiro quando tem certeza

No segundo produto, o instalador lê o fabricante da máquina e só mostra a linha do parceiro se
reconhecer outro provedor. Na dúvida (fabricante genérico, vazio, desconhecido, ou o próprio
parceiro), não mostra. Há um teste para isso.

**Não provado:** a razão de fundo não está escrita em nenhum dos dois produtos. A leitura mais
provável é não oferecer a VPS do parceiro a quem já está nela.

### 5. O nome do parceiro não entra em nome de pasta nem de arquivo

No primeiro produto o kit de instalação se chama pelo nome do parceiro. Isso acoplou o
instalador ao patrocinador, virou reclamação de quem usa outra hospedagem, e impede trocar de
parceiro sem renomear o que todo guia cita. No segundo, a pasta se chama `install/`.

### 6. Sem chave, sem licença, sem serviço do projeto

Nenhuma capacidade depende de algo que o projeto fornece ou pode desligar.

### 7. Telemetria: nenhuma, ou só com consentimento declarado

O primeiro produto nasceu com telemetria ligada por omissão e corrigiu para consentimento. O
segundo não envia nada. A consequência precisa ser aceita: sem telemetria, o retorno da parceria
se mede pelo lado do parceiro, e não pelo produto.

### 8. O custo de terceiros é medido e tem teto

Tudo o que o produto gasta com provedor aparece na tela, por unidade de trabalho, e respeita um
limite que o operador define. São dois limites: um por unidade (uma chamada, uma conversa) e um
somado (por organização e período, ou de unidades simultâneas). Só o primeiro deixa um usuário
logado multiplicar o gasto abrindo várias unidades de uma vez.

*O porquê:* custo imprevisível de IA foi uma das reclamações mais repetidas no primeiro produto,
e a capacidade que virou o segundo produto não entrava no limite de gasto.

O repositório traz um guia de custos que diz quais são as contas, como estimar e como o produto
mede e limita. Ele não publica preço de provedor como fato permanente.

### 9. O guia do implementador faz parte do produto

Cada repositório traz um guia "como ganhar dinheiro implementando". As seções do segundo
produto:

- o que você vende;
- para quem vender, e para quem não;
- como descobrir se vale a pena para o cliente;
- como precificar: implantação, manutenção, repasse de custos;
- o que entregar;
- o que não prometer;
- como demonstrar;
- o que separa quem dura de quem some;
- como devolver ao projeto.

Três regras dentro dele:

- **Contas no nome do cliente.** Se ele trocar de implementador, nada se perde.
- **Sem tabela de preço.** Mudaria de cidade para cidade e envelheceria em meses.
- **Não vender o que o produto não cumpre.**

### 10. Marca própria, quando existir, é configuração, e sobrevive à atualização

Só no primeiro produto. As lições:

- uma imagem serve todas as marcas. Marca feita por alteração de código ou imagem própria é
  apagada pela primeira atualização, sem ninguém perceber;
- o que está no banco vence o que está no arquivo de ambiente;
- o código que resolve a marca nunca falha: degrada para o padrão do produto;
- **documento legal nomeia quem é responsável pelos dados**, e nunca a marca de quem revende.

### 11. Três eixos de dinheiro, sem misturar

| Eixo | Quem ganha | De onde |
|---|---|---|
| Projeto | O mantenedor | Parceria de infraestrutura |
| Implementação | O implementador | Do cliente, por instalar e manter |
| Revenda | O revendedor | Dos clientes dele, pelo uso |

Os três convivem. Nenhum deles vira cobrança de licença, porque isso contraria a licença aberta.

Se o produto oferece cobrança para o revendedor, ela mora no núcleo, desligada por padrão e
falhando fechada. Fora do núcleo, a atualização a apagaria.

### 12. O kit de quem revende nasce com o produto

A comunidade do primeiro produto mostrou onde quem revende trava, e não é no código:

- quanto cobrar, e o que entra na implantação;
- quem paga o provedor de IA, e como prever o gasto de um cliente antes de fechar;
- alguém já usa isto com cliente de verdade?;
- contrato;
- a máquina recomendada basta para quantos clientes;
- como dar acesso ao cliente sem ele mexer em servidor;
- a quem recorrer.

O guia do implementador responde cada uma. Sobre preço, a regra 9 continua valendo: o guia dá
o método para chegar ao número e o piso de custo, e não uma tabela.

Dois itens só existem depois do lançamento, e por isso têm dono e data: um caso real
documentado, e o que é ou não suportado em produção.

### 13. O custo real do caminho recomendado é publicado

Antes do lançamento, mede-se quanto custa por mês rodar o produto pelo caminho que o README
recomenda, em uso de verdade, e onde cada limite gratuito acaba. O padrão do instalador
sustenta produção; onde não sustenta, diz isso na mesma tela.

*O erro:* o caminho recomendado do primeiro produto usava a camada gratuita de um serviço que
não aguentava uso real, e quem descobria já tinha cliente dentro.

### 14. Quem chega com um assistente de IA encontra o parceiro

Muita gente descobre o projeto por uma busca ou uma indicação, cola o endereço do repositório
no assistente de código e pede "me ajuda a instalar". Nesse caminho ninguém lê o README: quem lê
é o assistente. Se a recomendação do parceiro só existe para olhos humanos, ela se perde
exatamente em quem ainda não tem servidor, que é quem mais precisa dela.

*O erro:* no primeiro produto, o link de parceria estava no README e num script. O documento de
autoridade e a skill de instalação, que são o que o assistente carrega, não o traziam. No
segundo, a skill de instalação começava perguntando qual era o sistema da VPS, sem caminho para
quem não tinha uma.

**O passo zero.** Todo roteiro de instalação escrito para assistente começa assim:

1. Pergunte se a pessoa já tem um servidor.
2. Se não tem: diga qual tamanho de máquina basta, recomende a VPS do parceiro, diga com todas
   as letras que o link é de parceria e que usá-lo apoia o projeto, e diga que qualquer outra
   VPS funciona igual. Então abra o link no navegador dela, ou mostre-o inteiro, e espere ela
   voltar com o acesso.
3. Se tem: siga, sem mencionar o parceiro de novo.

**Onde o passo zero mora.** Em todo lugar por onde um assistente entra:

| Lugar | O que traz |
|---|---|
| README | Uma seção curta "Instalando com um assistente de IA": o que a pessoa cola no assistente, e o passo zero |
| Documento de autoridade (`AGENTS.md`) | Uma seção "Se a pessoa quer instalar ou usar", que manda para a skill de instalação e repete o passo zero |
| Skill de instalação | O passo zero, antes de qualquer pergunta técnica |
| A porta de entrada do kit (capítulo 11) | O mesmo, para quem roda um comando em vez de conversar |
| Site, e o arquivo de resumo para assistentes (capítulo 13) | O mesmo |

**As regras do passo zero.** São as mesmas da parceria inteira, ditas para uma máquina:

- o assistente nunca diz que a VPS do parceiro é obrigatória, nem que outra não serve;
- nunca abre o link sem dizer antes o que ele é;
- nunca troca o link por outro, nem inventa um;
- recomenda uma vez. Se a pessoa já escolheu outra hospedagem, ajuda nela do mesmo jeito.

**Uma grafia só.** O endereço do parceiro e o texto da oferta ficam num arquivo de dados do kit
de instalação, com nome genérico. Os scripts leem dali. Os documentos repetem, e uma cerca
confere que todo endereço do domínio do parceiro, em qualquer arquivo do repositório, é
exatamente aquele.

## Como saber que ficou pronto

- O bloco do parceiro está no README antes do comando de instalação, e diz que qualquer VPS
  funciona igual.
- A instalação foi feita numa máquina de outro provedor e deu o mesmo resultado.
- Nenhuma pasta, arquivo ou variável leva o nome do parceiro.
- O guia de custos e o guia do implementador existem.
- Um assistente de código, recebendo só o endereço do repositório e o pedido "me ajuda a
  instalar, ainda não tenho servidor", chegou sozinho ao link do parceiro e disse que era de
  parceria.
- Cada custo de provedor tem medição na tela e teto.

## Fora do repositório

Termos de parceria, valores, metas e qualquer número de negócio. O repositório é público; o que
é comercial fica em outro lugar.

## O que este capítulo não resolve

- Critério para escolher ou trocar de parceiro, e o que acontece se a parceria acabar.
- Regra para mais de um parceiro no mesmo produto.
- Quando um produto novo deve ganhar marca própria e cobrança.

## Origem

`VISION.md` dos dois produtos; documento de governança, instalador e guias do DeskVoice;
documento de marca própria e registro de decisão sobre cobrança do DeskcommCRM; relato do
construtor do DeskVoice sobre a entrada tardia do parceiro.
