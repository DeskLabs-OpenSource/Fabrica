# Governança do <Produto>

Este documento diz quem decide o quê, e o que pode ser decidido sem esperar ninguém.

A regra geral: **o que cabe numa regra escrita aqui é decidido por quem está na triagem. O que
não cabe vira um pedido de decisão com um padrão que vale se ninguém responder.**

## Quem decide o quê

| Papel | Quem é | Decide |
|---|---|---|
| Dono do projeto | <nome> | Visão e posicionamento, licença, parcerias, versão maior, mudança nas regras de produto abaixo, entrada e saída de mantenedores |
| Mantenedores | Pessoas com permissão de escrita, convidadas pelo dono | Merge pela fila, lançamento de versões, resposta a avisos de segurança, pedidos de decisão técnicos |
| Triagem | Mantenedores e os agentes que operam sob este documento | Classificar, aplicar as regras de produto, pedir mudanças, recusar o que as regras recusam |
| Contribuidores | Qualquer pessoa | O conteúdo da própria contribuição, e propor mudança em qualquer regra daqui |

Agente de IA que participa da triagem opera sob as mesmas regras de uma pessoa. Agente não
decide versão maior, licença nem mudança de regra de produto.

## Regras de produto

Com estas regras, a triagem decide sem o dono. Cada uma tem o porquê, para valer no caso que
ninguém previu.

### 1. O que entra no núcleo e o que é peça plugável

**Entra no núcleo** <o que toda instalação precisa para o trabalho central acontecer>.

**É peça plugável**, em arquivo próprio, <o que conecta o produto a um sistema de fora>.

O teste: <uma pergunta objetiva que separa os dois>.

### 2. Código de nicho nunca no núcleo

Regra de um ramo de negócio não entra no núcleo, nem atrás de configuração.

O porquê: cada condição de nicho no núcleo é um caminho que todas as outras instalações carregam
e ninguém testa.

### 3. Nada que facilite <o abuso do domínio>

Não entra: <a lista>.

Esta regra não tem exceção por caso de uso legítimo.

### 4. Nada que exija acesso ao servidor para ligar um recurso

Todo recurso se liga e se configura pela tela. Variável de ambiente nova só com valor padrão ou
gerada pelo instalador.

### 5. Sem recurso pago, <sem telemetria>

Nenhuma capacidade depende de licença, chave ou serviço do projeto.

### 6. O caminho genérico nunca é sabotado

A parceria de infraestrutura é uma recomendação. Nada no instalador ou no código funciona melhor
num provedor do que em outro por escolha do projeto.

### 7. Quem já instalou não é surpreendido

Mudança que exige ação de quem opera uma instalação diz isso, no campo próprio do fragmento de
versão.

## Pedido de decisão

Quando nenhuma regra acima resolve, quem está na triagem abre uma issue de decisão, no formato
abaixo. O formato é obrigatório: um pedido sem padrão trava o trabalho de alguém por tempo
indeterminado.

<Cole aqui o conteúdo de modelos/pedido-de-decisao.md da Fábrica.>

Decisão tomada que muda arquitetura vira um registro em `docs/decisions/`.

## Um único caminho de merge

- Todo código chega ao ramo principal por contribuição revisada, pela **fila de merge**. Não
  existe merge direto, para ninguém, dono incluído.
- **Check de contribuição só mede o que ela mudou.** O estado acumulado do repositório é check
  do ramo principal. Se ele ficar vermelho, consertá-lo tem prioridade sobre qualquer
  contribuição.
- Quem escreveu não aprova. Vale para pessoa e para agente.
- Versão maior só sai por decisão explícita do dono.

## Avisos de segurança

- Vulnerabilidade se relata em privado, como descrito em `SECURITY.md`.
- A correção é feita em ramo privado e publicada junto com a versão corrigida.
- É a única mudança que pode entrar sem o prazo normal de revisão pública. Passa pelos mesmos
  testes.
- Quem relatou é creditado, se quiser.

## Como mudar este documento

Por contribuição, como qualquer outro arquivo. Mudança nas regras de produto ou nos papéis
precisa da aprovação do dono.
