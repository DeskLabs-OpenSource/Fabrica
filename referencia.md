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
- **A referência também tem dívidas.** O que ela ainda não cumpre da própria Fábrica está em
  "Onde a referência diverge", no fim. Não copie essas partes.
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

## Configurado e ainda não exercitado

O que existe na referência e nunca rodou de verdade. Leia como desenho, e não como prova.

| Peça | Situação |
|---|---|
| Passo de atualização no CI | É pulado até existir a primeira versão publicada. Nunca rodou |
| Fila de merge | Configurada. Nenhuma contribuição a atravessou |
| Publicação de imagens e corte de versão | Nunca rodaram. Não há versão publicada |
| Imagens para a segunda arquitetura | Declaradas no workflow que nunca rodou |
| Atualizador | Testado só com um substituto do Docker. Nunca atualizou uma instalação |
| Acolhida | Nunca disparou. Nenhuma contribuição de fora ainda |
| Instalação por perguntas no terminal | Só o modo sem perguntas rodou numa máquina real |
| Instalação em servidor recém-criado | A única instalação real foi numa máquina compartilhada |
| O caminho central com provedores reais | Só em simulação |
| Medição de custo com provedores reais | A tela mostra zero para os motores reais |

## Onde a referência diverge

Esta lista é mantida junto com o repositório de referência. Um item sai daqui quando a
referência converge ou quando ela registra uma decisão diferente.

| Item de conformidade | Situação na referência |
|---|---|
| 4.1, 4.7 | Não há documento de design system nem validação do dono; só o arquivo de tokens |
| 4.5 | As fontes são baixadas de serviço externo na construção |
| 5.16 | O CI constrói as imagens e não as sobe |
| 6.1, 6.9 | Ausência de segundo fator, de token de API e de convite pela tela sem decisão registrada |
| 8.3 | Não há teste de porta no menu |
| 8.6 | Não há gestão de equipe pela tela |
| 9.3 | Três invariantes de sistema vivo ficaram de fora sem motivo escrito |
| 9.8 | Dados pessoais estão num guia, e não numa doutrina |
| 12.2 | O instalador constrói na VPS quando a versão não tem imagem |
| 12.3 | A instalação grava o canal estável como versão |
| 10.5 | As primeiras contribuições entraram com passagem de administrador, sem revisão de outra pessoa |
| 12.1 | Não existe a cerca que reprova serviço de produção sem imagem |
| 13.5 | O repositório foi publicado antes da instalação real |
| 10.5 (regra do ramo) | O script que aplica a regra dá passagem ao administrador da organização. Não o copie como está |

**Ainda não medidos na referência.** Estes itens entraram na lista depois da última conferência
e ninguém os mediu lá: 2.12 a 2.16, 3.5, 6.12 a 6.15, 7.9 a 7.11, 8.8 a 8.12, 10.12, 11.15 a
11.20, 12.11 e 13.7 a 13.9. Três foram olhados por amostragem e não são cumpridos: o guia do
implementador não trata de contrato (2.12), o guia de custos traz o método e não um número
medido (2.15), e o instalador não confere a entrada do usuário criado (11.16).
