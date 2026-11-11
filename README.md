# Fábrica

O método para fundar um sistema autônomo open source, do zero até a primeira instalação real,
sem repetir os erros já pagos nos produtos anteriores.

Isto não é um framework e não é um template de código. É o manual de como construir: as
decisões que todo produto precisa tomar, a ordem em que se tomam, as regras que valem para
qualquer stack e o erro que originou cada regra.

## Começar

Num terminal com um assistente de código (Claude Code, Codex, Cursor, OpenCode, Antigravity):

```bash
curl -fsSL https://raw.githubusercontent.com/DeskLabs-OpenSource/Fabrica/main/install.sh | bash
```

Precisa de `bash` e `git` (Linux, macOS ou WSL). Isso baixa a Fábrica em `~/.desklabs/fabrica`
e liga duas skills ao seu assistente. Abra uma
sessão nova e diga o que quer:

| Você diz | O que acontece |
|---|---|
| "Usa a Fábrica para fundar um produto: *a sua ideia*" | A skill `fabrica-fundar` conduz as dez fases, começando por três perguntas a você |
| "Audita este projeto pela Fábrica" | A skill `fabrica-auditar` mede o repositório contra a lista de conformidade e, se você pedir, o faz convergir |

Rodar o comando de novo atualiza. Para desfazer: `bash ~/.desklabs/fabrica/install.sh --remover`.

Ou, sem instalar: clone este repositório, abra o assistente dentro dele e peça para seguir o
[`AGENTS.md`](AGENTS.md).

## De onde vem

De dois produtos reais:

- **DeskcommCRM**, o primeiro. Cresceu rápido, com centenas de contribuidores, e pagou caro por
  decisões de fundação que só mostraram o custo em escala.
- **DeskVoice**, o segundo. Foi fundado a partir das lições do primeiro, e é a prova prática
  deste método. Onde os dois divergem por uma razão medida, o manual segue a razão.

Regra de entrada: toda regra nasce de um erro medido num dos dois. Onde a solução ainda não
rodou em nenhum produto, o texto diz **não provado**.

A Fábrica foi escrita para os produtos da DeskLabs, e por isso fala em parceiro de
infraestrutura e em produtos irmãos. Quem é de fora pode usar: onde uma pergunta não fizer
sentido para o seu projeto, a resposta é "não se aplica", com o motivo.

## Para quem

- **Para o dono de um produto novo:** as perguntas que só você responde estão no começo de cada
  capítulo, em "Decisões do dono". O resto é do construtor.
- **Para a IA que vai construir:** se a skill `fabrica-fundar` está instalada, siga-a. Senão,
  comece por [`AGENTS.md`](AGENTS.md).
- **Para quem contribui com a Fábrica:** toda lição nova entra em [`licoes.md`](licoes.md) com o
  erro que a originou. Regra sem erro de origem não entra.

## O que tem aqui

| Caminho | O que é |
|---|---|
| [`manual/00-o-metodo.md`](manual/00-o-metodo.md) | As dez fases de uma fundação, das entradas do dono à publicação |
| `manual/01` a `manual/12` | Um capítulo por área: o que decidir, as regras, como cobrar, como saber que ficou pronto |
| [`licoes.md`](licoes.md) | O catálogo de erros medidos e a regra que cada um gerou |
| [`conformidade.md`](conformidade.md) | A lista que diz se um produto segue a Fábrica, item por item, com o jeito de conferir |
| [`referencia.md`](referencia.md) | Onde ver cada mecânica funcionando, e o que a referência ainda não cumpre |
| `modelos/` | Documentos em branco para preencher: visão, desenho da fundação, governança, documento de autoridade, registro de decisão, pedido de decisão, doutrina |
| `skills/` | As duas skills que conduzem o trabalho: fundar e auditar |
| `install.sh` | Liga as skills ao seu assistente de código |

## Os capítulos

| Nº | Área | Tipo |
|---|---|---|
| 00 | O método | Fases e portões |
| 01 | Visão | Decisão do dono |
| 02 | Modelo de negócio | Decisão do dono |
| 03 | Escolha de stack | Critério |
| 04 | Design system | Método |
| 05 | Padrões de engenharia | Regras de forma |
| 06 | Autenticação | Regras e mecanismo |
| 07 | Multiempresa | Regras e mecanismo |
| 08 | Painel de administração | Regras e mecanismo |
| 09 | Doutrinas | Método |
| 10 | Contribuição | Regras e mecanismo |
| 11 | Instalação | Regras e mecanismo |
| 12 | Distribuição | Regras e mecanismo |

## O que não tem aqui, de propósito

- **Código para copiar.** A implementação de referência das mecânicas (cercas, notas de versão
  por fragmentos, instalador, skills embutidas) é o repositório do
  [DeskVoice](https://github.com/DeskLabs-OpenSource/DeskVoice), mapeado em
  [`referencia.md`](referencia.md). Copiar o código para cá criaria uma segunda cópia que
  envelhece. Quando um terceiro produto mostrar o que é comum de verdade, isso vira um
  template.
- **Stack obrigatória.** Cada produto escolhe a sua pelo critério do capítulo 03. O que é fixo é
  o destino: uma VPS, instalada com um comando.
- **Informação comercial.** Termos de parceria e números de negócio ficam fora do repositório.

## Licença

MIT.
