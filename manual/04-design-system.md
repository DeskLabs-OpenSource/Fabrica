# 04. Design system

> Todo produto tem um design system próprio. O que se repete entre produtos é o método: declarar
> uma direção, reduzir tudo a tokens, e pôr sob teste o que puder ser testado. Este capítulo não
> traz paleta nem fonte.

## Estado deste capítulo

É o capítulo com menos prova. O primeiro produto tem um design system documentado e cercas para
a parte técnica. O segundo tem só um arquivo de tokens e nenhuma validação do dono. O que está
abaixo como regra veio de erro medido; o que está em "Não provado" é método proposto.

## Decisões do dono

1. **Qual é a direção, em uma frase?** A do primeiro produto: "calmo, anti-genérico".
2. **O produto novo é da mesma família visual dos irmãos?** Se sim, o que muda nele?
3. **Haverá marca própria para quem revende?** (Capítulo 02.)

## O que um design system precisa ter

| Parte | O que responde |
|---|---|
| Visão geral | A direção e o porquê dela, ligado ao público |
| Tokens de fundação | Cor, tipografia, espaço, raio, sombra, movimento |
| Componentes | O inventário do que existe, com o estado real de cada um |
| Antipadrões | O que não se usa, cada um com o motivo |
| Voz | O tom dos textos de tela |

## As regras

### 1. Declare a direção e as proibições, cada uma com o porquê

Sem direção declarada, um assistente de código produz o padrão de todo mundo. A direção se
escreve junto com a lista do que fica de fora: fontes, bibliotecas de ícones e efeitos que o
produto não usa.

*O porquê, do primeiro produto:* a maioria dos produtos da categoria converge para o mesmo
molde, e parecer igual a eles é parecer genérico.

### 2. Proibição visual precisa de cerca

**Este é o erro medido deste capítulo.** No primeiro produto, a regra "não use a biblioteca de
ícones X" existia só em prosa. Resultado: mais de uma dúzia de arquivos a importam, inclusive
componentes de base, e o arquivo de configuração do gerador de componentes declara essa mesma
biblioteca como padrão.

Regra visual que cabe numa verificação mecânica (importação proibida, cor fora de token, fonte
fora da lista) vira cerca no primeiro commit. O que não cabe vai para a revisão.

### 3. Componente usa só token semântico

Nenhum valor solto de cor, espaço ou raio dentro de componente. O componente pede "superfície",
"texto secundário", "acento", e o token decide o valor.

### 4. Uma fonte só de tokens

Os tokens moram num arquivo. No primeiro produto, um segundo arquivo de configuração voltou a
existir e metade dos tokens passou a vir de cada um. Há um teste que reprova a volta.

### 5. Token consumido tem de existir

No primeiro produto, um gráfico usava um token que resolvia para nada. O gráfico sumia da tela,
com a construção e os testes verdes. Há um teste que confere que toda cor consumida existe.

### 6. Claro e escuro saem da mesma declaração

Cada token declara os dois valores no mesmo lugar. Tema mantido em dois arquivos diverge.

### 7. Fonte versionada no repositório

No primeiro produto, as fontes eram baixadas de um serviço externo durante a construção, e a
construção caía quando o serviço não respondia. Passaram a ser arquivos do repositório.

O segundo produto voltou a baixar de serviço externo, sem razão registrada. É uma regressão a
corrigir, e o exemplo de por que as lições precisam estar num lugar só.

### 8. Texto de tela só em dicionário

Nenhuma frase visível escrita dentro de componente. Vale desde o primeiro dia, nos idiomas que o
produto declara.

*O porquê:* frase em português chegava a quem usava em outro idioma. No segundo produto é uma
cerca única; no primeiro, várias cercas por área, criadas uma a uma depois do problema.

### 9. Número em documento de design é medido

Um inventário de telas do primeiro produto tinha nove de dez contagens erradas. Contagem em
documento ou vem de um comando, ou não se escreve.

### 10. Medida de interface se tira com ferramenta

Tamanho, espaçamento e contraste se medem no navegador, e não a olho.

## A identidade, antes do lançamento

Todo produto chega à divulgação com a identidade pronta, porque ela aparece em três lugares que
quem chega vê antes de qualquer tela: o repositório, o site e o próprio painel.

| Peça | Onde aparece |
|---|---|
| Marca completa (símbolo e nome), em horizontal | Topo do README, cabeçalho do site |
| Símbolo sozinho | Ícone do painel, ícone do navegador, avatar da organização |
| Imagem de capa | A prévia do repositório e do site quando o endereço é compartilhado |
| Versões para fundo claro e para fundo escuro | Todos os anteriores |

As regras:

- **Vetorial, e no repositório.** Uma pasta de marca, com os arquivos de origem e os
  exportados. Quem contribui com o site ou com um guia não precisa pedir o logo a ninguém.
- **Deriva da direção.** As cores são os tokens; a tipografia é a do produto. Uma marca
  desenhada fora do design system envelhece separada dele.
- **Da família, com uma coisa só dela.** Produtos irmãos se reconhecem pela mesma construção,
  e se distinguem por um elemento: uma cor de acento, um símbolo.
- **Uma fonte só.** O site e o painel leem os arquivos da pasta de marca. Cópia redesenhada à
  mão diverge.
- **O nome se escreve de um jeito,** e o README diz qual.

**Não provado:** o primeiro produto tem marca e a guarda em mais de um lugar; o segundo ainda
não tem nenhuma dessas peças. A lista acima é o mínimo proposto.

## Se houver marca própria

Estas regras só valem para produto que deixa o revendedor trocar a marca. Todas vêm de erro do
primeiro produto.

- **Marca é lida em tempo de execução.** Marca gravada na construção aparece errada exatamente
  na instalação de quem pagou por ela, porque a imagem é a mesma para todos.
- **A cor do cliente é semente; o resto é derivado**, com piso de contraste medido por papel e
  por superfície. Quem se ajusta para manter o contraste são as cores do produto, e nunca a cor
  do cliente.
- **Os pares de contraste vêm do arquivo de estilos, e não de uma lista escrita à mão.** O teste
  antigo conferia só o tom principal, e um elemento de foco ficaria ilegível com o teste verde.
- **O código que resolve a marca nunca falha.** Ele roda na raiz de todas as telas.
- **Vazamento do nome do produto no código é vigiado**, com lista de exceções que só diminui.

## Como saber que ficou pronto

- A direção cabe numa frase e a lista de proibições tem motivo em cada item.
- Cada proibição mecânica tem cerca, e a cerca foi vista reprovando.
- Uma busca por valor solto de cor nos componentes volta vazia.
- O tema escuro foi aberto em todas as telas.
- O dono validou.

## Não provado

- **A ordem de construção.** Proposta: direção e proibições, depois tokens, depois os
  componentes de base, depois as telas. Nenhum dos dois produtos seguiu uma ordem registrada.
- **Como herdar a família visual sem copiar.** O segundo produto manteve fontes e ícones do
  primeiro e trocou a cor de acento, reservando-a para um significado ("o que está vivo"). Faz
  sentido, mas ainda não foi validado pelo dono.
- **Um documento de design system mínimo.** O segundo produto não tem. O conteúdo proposto é a
  tabela de partes no começo deste capítulo.

## Origem

Documentos de design system, testes de tokens, de marca e de inventário do DeskcommCRM; arquivo
de tokens, cerca de texto e desenho da fundação do DeskVoice.
