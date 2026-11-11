# 13. Site

> O site apresenta o produto, ensina a instalar e a usar, e encaminha para o código e para o
> parceiro. O que se repete entre produtos: quase nada no site é escrito no site. Cada página
> tem uma fonte, e a ligação com a fonte é vigiada.

## Estado deste capítulo

Só o primeiro produto tem site. O método abaixo vem do que funciona lá e, em parte igual, do
que apodreceu lá: a lista de guias ficou atrás das skills, a página de instalação tem uma data
fixa, a data da página inicial ficou velha. As regras de ligação com a fonte nasceram desses
três. O segundo produto deixou o site fora da fundação, e é o primeiro a aplicar este capítulo.

## Decisões do dono

1. **Quando o site entra.** Pode ficar para depois da publicação do código. A fundação só
   exige que o repositório, sozinho, já sirva a quem chega (capítulo 02, regra 14).
2. **O endereço,** e os idiomas.
3. **A personalidade,** em três palavras, e o que o site nunca faz.

## Um repositório separado

O site mora num repositório próprio, e nunca dentro do produto.

*O porquê, escrito no primeiro produto:* o produto é instalado e revendido. Se a página de
apresentação morasse na raiz do aplicativo, toda instalação feita por um revendedor serviria a
página de vendas do projeto aos clientes dele.

## As páginas, e a fonte de cada uma

| Página | O que responde | De onde vem o conteúdo |
|---|---|---|
| Inicial | O que é, para quem, o que resolve, quanto custa, como começar | Escrita no site, a partir de um plano que mora no produto |
| Instalar | O passo a passo, do "não tenho servidor" ao primeiro acesso | **Da fonte:** os comandos e os requisitos vêm do kit de instalação do produto |
| Guias | O que cada skill do projeto faz, para quem, e como cada assistente de código a carrega | **Da fonte:** uma entrada por skill do repositório do produto |
| Para quem desenvolve | Como contribuir, a arquitetura, a doutrina | Ligações para os arquivos do repositório. Sem cópia |
| Curso | Como usar, tela por tela | **Gerado:** capturado do aplicativo real e montado por script |
| Notas de versão | O que mudou em cada versão | **Lido da fonte:** o arquivo de notas do produto, em tempo de execução |
| Design system | A identidade visual, viva | A vitrine do próprio produto, ou uma página gerada dos tokens dele |
| Para quem implementa | Como ganhar dinheiro implementando | Ligação para o guia do repositório |

Três tipos de página, e uma regra para cada:

- **Lida da fonte:** nada é escrito no site. Se a leitura falha, a página falha alto, em vez de
  mostrar "nenhuma versão" por cima do conteúdo certo.
- **Gerada:** um script produz, e um recibo diz de qual commit do produto ela saiu.
- **Escrita no site:** só a página inicial e as molduras. Tudo o que nelas afirma um fato sobre
  o produto aponta para onde conferir.

## As regras

### 1. O que pode vir da fonte, vem da fonte

*O erro:* no primeiro produto, a página de guias é uma cópia feita à mão da pasta de skills.
Ela lista menos guias do que o repositório tem, e o próprio arquivo admite que "mente até
alguém mudar". A página de instalação foi "conferida contra o kit" numa data fixa, e o comando
da página inicial é escrito de um jeito e o da página de instalação de outro.

O que deu certo no mesmo site: as notas de versão. Nada é escrito ali; o site lê o arquivo do
produto.

### 2. O corte de versão confere a consequência

Ao cortar uma versão, o produto consulta o site e reprova se a versão não aparecer lá.
Confere-se o efeito, e não um passo "atualizar o site" que poderia passar verde sem mudar nada.

### 3. Toda cópia tem um teste de paridade

O que não der para ler nem gerar, e precisar ser copiado (tokens visuais, a lista de guias
enquanto não for gerada), tem um teste que compara a cópia com a fonte e reprova a diferença.
O teste roda no CI do site, baixando a fonte.

### 4. Número social se busca; não se escreve

Contagem de estrelas, de contribuidores, de testes: lida da fonte em tempo de execução, e some
da página se a leitura falhar. Prova social escrita à mão apodrece.

### 5. Uma data de atualização, de uma constante só

A data visível vem de um lugar. No primeiro produto ela é fixa dentro de um componente e ficou
meses atrás do conteúdo.

### 6. Cada seção responde uma pergunta de quem visita

A página inicial nasce de um plano em que cada seção é a resposta a uma pergunta real. Seção
que não responde nenhuma sai.

### 7. Todo o conteúdo está no texto servido

A interação é uma camada por cima. Buscadores e assistentes de IA que leem a página não
executam scripts. Vale também para o **arquivo de resumo para assistentes**, na raiz do site: o
que é o produto, como instalar, o passo zero com o parceiro declarado (capítulo 02, regra 14),
e as ligações para os guias.

### 8. Afirmação técnica aponta para onde conferir

Cada "o produto faz X" traz o caminho no repositório. E o site não promete o que não foi
medido: tempo de instalação, por exemplo.

### 9. O parceiro, declarado

Um bloco na página inicial e a primeira etapa da página de instalação. O link diz que é de
parceria e que usá-lo apoia o projeto, e leva a marcação de link patrocinado. O endereço é o
mesmo do repositório, letra por letra. Em idioma onde a oferta não vale, o bloco aparece sem a
promessa.

### 10. Idiomas com a mesma estrutura, por tipo e por teste

Um dicionário por idioma, com o mesmo formato obrigado pelo tipo: chave que falta quebra a
construção. Um teste compara a estrutura do que o tipo não cobre. Tradução que encolhe é
conteúdo perdido. As versões não precisam ser literais: cada uma fala com o seu público.

### 11. Os testes do site rodam no CI

Uma suíte que só protege quem lembra de rodá-la não protege ninguém.

### 12. O contrato de marca do site

Um arquivo curto na raiz: quem visita, para que o site serve, a personalidade, o que ele nunca
faz, e a acessibilidade. Inclui não pressupor que a pessoa sabe o que é um servidor.

## A página de guias

Cada skill do produto vira uma entrada, com os mesmos campos:

- para quem é: quem opera, ou quem programa;
- o que ela faz, em uma frase e em uma lista curta;
- frases que a acionam, em linguagem comum;
- a ligação para o arquivo oficial no repositório.

A página traz também, por assistente de código: onde ele procura as skills, se as carrega
sozinho, como chamar pelo nome. E diz o que foi medido e o que veio só da documentação do
assistente.

**A forma certa:** a lista é gerada a partir do cabeçalho de cada skill no repositório do
produto. Os campos que a página precisa moram no cabeçalho da skill, e um teste do produto
exige que existam.

## O curso

O material mais elogiado pela comunidade do primeiro produto foi um curso que se percorre, com
as telas reais, em vez de um vídeo. O método:

1. **Lições em dados.** Um arquivo por lição: a rota, os passos, o texto, a dica, e o que
   destacar na tela, apontado por identificadores estáveis do próprio aplicativo.
2. **Triagem do que mudou.** Um comando compara o commit da última publicação com o atual e diz
   se é preciso recapturar tudo, só candidatos, ou nada.
3. **Bancada isolada.** O aplicativo de verdade, numa construção de teste, com banco local. O
   script recusa rodar contra um banco que não seja local.
4. **Dados de demonstração.** Uma empresa fictícia, semeada por script, que pode ser refeita
   antes de cada lição. Nunca dados reais.
5. **Capturas do aplicativo real.** Um navegador dirigido tira a foto e mede a posição de cada
   destaque. Cada foto guarda a versão e o commit em que foi tirada. Falha deixa a lição
   pendente, e não com foto velha.
6. **Idiomas.** Onde a interface existe no idioma, captura-se de novo nele. Nunca se reaproveita
   a medida de um idioma em outro. Onde não existe, traduz-se o texto por cima das fotos, com
   aviso.
7. **Montagem.** Um script gera a página. O menu do curso sai do registro de navegação do
   produto, e por isso tela nova aparece como "em breve" sem ninguém lembrar.
8. **Publicação com recibo.** O curso vai para o site, passa pela prova visual da página no ar,
   e só então o recibo no produto avança: commit de origem, idiomas, data.

Um efeito colateral que vale o esforço: percorrer o produto tela por tela para o curso achou
uma lista de defeitos de uso.

**O que ainda é manual no primeiro produto,** e a terceira fundação pode fechar: copiar a
página montada do produto para o site.

## A ordem de construção

1. O arquivo de resumo para assistentes e a página de instalar. São o que serve a quem chegou
   para instalar.
2. As notas de versão, lidas da fonte, com a conferência no corte de versão.
3. A página inicial.
4. Guias e "para quem desenvolve".
5. O curso, quando as telas pararem de mudar toda semana.

## Como saber que ficou pronto

- Uma versão nova do produto apareceu no site sem ninguém tocar no site.
- Uma skill nova no produto apareceu na página de guias, ou o CI do site ficou vermelho.
- Os comandos da página de instalar são, letra por letra, os do kit.
- Um assistente de IA, recebendo só o endereço do site e "quero instalar", chegou ao passo zero.
- A página inicial foi lida com os scripts desligados e todo o conteúdo estava lá.

## Não provado

- **A página de guias gerada do cabeçalho das skills.** No primeiro produto ela é copiada à mão.
- **O teste de paridade rodando no CI do site contra o repositório do produto.** Não existe lá.
- **O arquivo de resumo para assistentes.** Nenhum dos dois produtos tem.
- **A página de design system no site.** No primeiro produto a vitrine mora dentro do
  aplicativo.

## Origem

Repositório do site, plano da página, skill e roteiro do curso, workflow de corte de versão e
doutrina de versionamento do DeskcommCRM; relatos da comunidade do primeiro produto.
