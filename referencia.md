# Implementação de referência

> Onde ver cada mecânica funcionando. A Fábrica não guarda código: ela aponta para o
> repositório do [DeskVoice](https://github.com/DeskLabs-OpenSource/DeskVoice), que é o produto
> fundado por este método.

## Como usar

Ao fundar um produto, clone o repositório de referência numa pasta só de leitura e leia a peça
antes de escrever a sua. O que você trouxer entra no arquivo de créditos do produto novo.

```bash
git clone --depth 1 https://github.com/DeskLabs-OpenSource/DeskVoice.git ~/.desklabs/referencia
```

Três avisos:

- **É um produto, e não um template.** Cada peça carrega o domínio dele. A coluna "O que muda"
  diz o que é do domínio.
- **A referência também tem dívidas.** O que ela ainda não cumpre da própria Fábrica está
  medido no relatório de auditoria dela; o fim deste arquivo diz onde. Não copie essas partes.
- **Se a stack do produto novo for outra,** as peças valem como desenho, e não como código.

## Documentos

| Peça | Caminho na referência | O que muda |
|---|---|---|
| Documento de autoridade | `AGENTS.md`, `CLAUDE.md` | Stack, mapa de pastas, convenções de domínio |
| Visão | `VISION.md` | Tudo, menos a estrutura |
| Desenho da fundação | `docs/specs/` | Tudo, menos a estrutura |
| Governança | `GOVERNANCE.md` | A regra de produto sobre o abuso do domínio |
| Contribuição | `CONTRIBUTING.md` | Comandos |
| Segurança, com limites conhecidos | `SECURITY.md` | Os limites |
| Créditos | `CREDITS.md` | Tudo |
| Roteiro | `ROADMAP.md` | Tudo |
| Registros de decisão | `docs/decisions/` | Tudo, menos a forma |
| Doutrinas | `docs/doctrine/` | As de domínio |
| Guia de custos e guia do implementador | `docs/guides/` | Os números e o público |

## Cercas

Pasta `fences/`. Cada arquivo abre com dono, motivo e data de revisão.

| Cerca | Vale para qualquer produto? |
|---|---|
| `fences-have-owner-and-review-date` | Sim |
| `every-table-has-organization-id` | Sim, se houver banco |
| `migrations-are-timestamped-and-unique` | Sim, se houver banco |
| `env-vars-have-defaults`, com a lista `env-allowlist` | Sim |
| `no-raw-sql-outside-core` | Sim, ajustando o que conta como acesso direto |
| `system-access-is-allowlisted`, com a lista | Sim |
| `one-file-per-piece` | Sim, trocando as pastas de peças |
| `ui-text-lives-in-dictionaries` | Sim |
| `no-conflict-markers` | Sim |
| `docs-point-to-existing-files` | Sim |
| `workflows-declare-permissions` | Sim |
| `workflows-cancel-superseded-runs` | Sim |
| `welcome-does-not-checkout` | Sim |
| `release-fragments-are-valid` | Sim |
| `skills-mirror-is-in-sync` | Sim |

## Núcleo

| Peça | Caminho na referência | O que muda |
|---|---|---|
| Porta única por organização e porta de sistema | `packages/core/src/with-org.ts` | Nada na ideia |
| Teste de isolamento gerado do catálogo | `packages/core/test/isolation.db.test.ts` | As fábricas de linha por tabela |
| Teste de isolamento pelas rotas | `apps/panel/src/app/api/v1/isolation.db.test.ts` | As rotas |
| Executor de migrations com resumo de cada arquivo | `packages/core` | Nada |
| Registro de eventos com vocabulário fechado | `packages/core` | O vocabulário |
| Fila por notificação | `packages/core` | Os tipos de tarefa |
| Cifra de segredos | `packages/core` | Nada |
| Contexto de sessão e papéis | `apps/panel/src/server/context.ts` | Os papéis |

## CI e versões

| Peça | Caminho na referência | O que muda |
|---|---|---|
| Verificação com check agregador | `.github/workflows/ci.yml` | Os jobs de domínio |
| Mensagem que diz de quem é a culpa | `.github/actions/explain-failure/` | Nada |
| Acolhida | `.github/workflows/welcome.yml` | O texto e o prazo medido |
| Publicação de imagens | `.github/workflows/publish-image.yml` | Os nomes das imagens |
| Corte de versão | `.github/workflows/release.yml`, `scripts/release/`, `scripts/release.ts` | O nome do repositório |
| Fragmentos | `.changes/README.md` | Nada |
| Proteção do ramo | `scripts/github/apply-ruleset.sh` | O nome do check, e a passagem de administrador, que sai |

## Skills

| Peça | Caminho na referência | O que muda |
|---|---|---|
| Fonte e espelho | `.agents/skills/`, `scripts/sync-skills.ts` | Nada |
| Roteamento situação → skill | `.agents/rules/` | Os nomes |
| Contribuir: quem sou, pré-voo, hooks | `.agents/skills/deskvoice-contribuir/` | O que o pré-voo mede |
| Doutrina em forma de lista | `.agents/skills/deskvoice-doutrina/` | As regras |
| Instalar e operar | `.agents/skills/deskvoice-instalar/`, `.agents/skills/deskvoice-operar/` | Os passos |
| Uma skill por tipo de peça plugável | `.agents/skills/deskvoice-ferramenta/`, `.agents/skills/deskvoice-motor-de-voz/` | As peças do domínio |

## Instalação

Pasta `install/`.

| Peça | Arquivo | O que muda |
|---|---|---|
| Entrada de uma linha | `get.sh` | O endereço |
| Instalador | `install.sh` | As perguntas e os serviços |
| Funções comuns, permissões explícitas, detecção de proxy, condição do parceiro | `_common.sh` | Os serviços |
| Saúde por peça e por ligação | `healthcheck.sh` | As peças |
| Backup e restauração conferidos | `backup.sh`, `restore.sh` | O que entra no backup |
| Atualização com volta automática | `update.sh` | As peças essenciais |
| Diagnóstico mascarado | `diagnose.sh` | O que coleta |
| Recuperação de senha | `reset-password.sh` | Nada |
| Testes do kit | `install/test/` | Os casos |
| Composição e proxy | `deploy/docker-compose.yml` | Os serviços |

## O que a referência ainda não cumpre, e o que nunca exercitou

Essas duas listas moram no próprio produto, num lugar só, e são atualizadas a cada auditoria:

| O que | Onde, no repositório de referência |
|---|---|
| O que está configurado e nunca rodou de verdade | `docs/fundacao/nao-exercitado.md` |
| O resultado de cada item de [`conformidade.md`](conformidade.md) | o relatório mais recente em `docs/fundacao/`, com nome `conformidade-<data>.md` |

Antes de trazer uma peça, procure o item dela no relatório. Peça de item não conforme vale
como aviso do que não fazer.

O que a primeira auditoria mediu de mais importante, para ninguém copiar por engano:

- o instalador grava o canal estável como versão e constrói na VPS quando não há imagem;
- o script que aplica a regra do ramo dá passagem ao administrador da organização;
- sem domínio, o padrão do instalador publica o painel pelo endereço da máquina, sem conexão
  segura;
- as fontes do painel são baixadas de serviço externo na construção;
- o job de imagens constrói e não sobe os processos;
- não há teste que dirija o navegador, nem job que rode o instalador de verdade;
- a retenção de dados pessoais não está escrita nem é executada.
