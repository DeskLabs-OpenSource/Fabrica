---
name: fabrica-auditar
description: 'Mede um produto que já existe contra a lista de conformidade da Fábrica DeskLabs e, se pedido, o faz convergir. Use quando a pessoa disser "audita este projeto pela Fábrica", "o que falta para seguir a Fábrica?", "adapta este repositório ao método", "confere a conformidade", "converge com a Fábrica", ou ao fim de uma fundação. Produz um relatório item a item com evidência, e um plano de convergência em que cada divergência é corrigida ou vira um registro de decisão. Não use para começar um produto do zero (isso é fabrica-fundar).'
---

# Auditar um produto pela Fábrica

Você vai medir um repositório contra `conformidade.md` e dizer, item por item, se ele cumpre. A
Fábrica não exige obediência: exige que cada divergência seja uma decisão escrita.

## Antes

A Fábrica está em `${FABRICA_HOME:-$HOME/.desklabs/fabrica}`. Atualize-a antes de auditar:

```bash
curl -fsSL https://raw.githubusercontent.com/DeskLabs-OpenSource/Fabrica/main/install.sh | bash
```

Leia `conformidade.md` inteiro e `licoes.md` inteiro. Leia o capítulo do manual de cada seção
antes de julgar os itens dela.

## Medir

Para cada item, um de quatro resultados:

| Resultado | Quando | O que você anexa |
|---|---|---|
| Conforme | Cumpre | O caminho do arquivo, ou o comando e a saída |
| Não conforme | Não cumpre | O que foi conferido e o que faltou |
| Não se aplica | A condição do item não existe neste produto | O motivo |
| Decidido diferente | Diverge, e existe um registro de decisão | O caminho do registro |

Regras da medição:

- **Meça; não deduza.** Item de arquivo: confira que existe e abra. Item de comando: rode e
  leia a saída. Item de execução: rode o sistema, ou diga que não rodou.
- **"Não medido" é um quinto resultado honesto.** Se você não conseguiu conferir (falta uma
  VPS, uma credencial), diga isso. Nunca marque conforme pelo que o documento afirma.
- **Presença de um nome no código não é prova de comportamento.**
- **Uma cerca só conta se guarda o que o texto diz.** Abra a cerca.
- **Itens de nível C** só valem se a condição escrita neles existe. Senão, "não se aplica".
- Uma busca que volta vazia pode ser uma busca errada. Antes de concluir que algo não existe,
  rode a mesma busca contra um caso que você sabe que existe.

Escreva o resultado em `docs/fundacao/conformidade-<AAAA-MM-DD>.md` no repositório auditado: uma
tabela por seção, e no topo a contagem de cada resultado e o identificador do commit medido.

## Convergir

Só se a pessoa pediu para adaptar. Para cada item não conforme, uma de três saídas:

1. **Corrigir.** É o padrão.
2. **Registrar a decisão diferente.** Quando o produto tem uma razão para divergir. O registro
   segue `modelos/registro-de-decisao.md`, com o custo de divergir. Se a razão for melhor que a
   do manual, anote para devolver à Fábrica.
3. **Pedir decisão ao dono.** Quando é dele: parceiro, fronteira, licença, versão maior, o que
   nasce desligado, mudança numa regra de produto. Use `modelos/pedido-de-decisao.md`, com o
   padrão que vale se ele não responder, e siga com o resto.

A ordem de trabalho:

1. **O que pode causar dano a quem já instalou ou a terceiros.** Isolamento, autenticação,
   controle legal, instalação e atualização.
2. **O que afirma mais do que faz.** Documento que promete cobertura inexistente, cerca mais
   fraca que o texto. Corrigir o texto é uma correção válida, e costuma ser a primeira.
3. **Cercas e jobs de CI que faltam.**
4. **Documentos que faltam.**
5. **Itens de nível C,** se a condição já existe.

Regras do trabalho:

- Uma contribuição por item, ou por grupo pequeno de itens da mesma seção. Nunca uma
  contribuição só com tudo.
- Siga as regras do próprio repositório: o documento de autoridade dele, a fila de merge, quem
  aprova. Se as regras dele exigem que outra pessoa aprove, você não aprova o próprio trabalho.
- Toda mudança que quem opera percebe traz o fragmento de versão.
- Cerca nova é vista reprovando antes de entrar.
- Não mude o que já está conforme.

Ao terminar, meça de novo e escreva um relatório novo. Não edite o anterior.

## Devolver

A auditoria quase sempre ensina algo à Fábrica:

- item de conformidade ambíguo ou impossível de conferir;
- regra que o produto contrariou com uma razão boa;
- defeito que a lista não pegaria.

Escreva isso no fim do relatório, em "Para a Fábrica", e abra uma contribuição no repositório
dela.
