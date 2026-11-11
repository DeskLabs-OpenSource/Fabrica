#!/usr/bin/env bash
# Instala ou atualiza a Fábrica nesta máquina: baixa o repositório e liga as skills nas pastas
# globais dos assistentes de código.
#
#   curl -fsSL https://raw.githubusercontent.com/DeskLabs-OpenSource/Fabrica/main/install.sh | bash
#   bash install.sh --fonte .     usa esta pasta em vez de baixar (para quem edita a Fábrica)
#   bash install.sh --remover     desfaz as ligações (não apaga a cópia)
#
# Variáveis: FABRICA_HOME (onde fica a cópia; padrão ~/.desklabs/fabrica), FABRICA_REPO_URL.
#
# Tudo fica dentro de principal(), chamada na última linha: se o download pelo cano vier
# cortado, o bash não executa metade do script.

set -euo pipefail

# Uma ligação é nossa quando é um link simbólico para uma pasta skills/fabrica-* .
eh_nossa() {
  [ -L "$1" ] || return 1
  case "$(readlink "$1")" in */skills/fabrica-*) return 0 ;; esac
  return 1
}

principal() {
  local repo_url="${FABRICA_REPO_URL:-https://github.com/DeskLabs-OpenSource/Fabrica.git}"
  local casa="${FABRICA_HOME:-$HOME/.desklabs/fabrica}"
  case "$casa" in /*) ;; *) casa="$PWD/$casa" ;; esac

  local acao="instalar" fonte=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --remover) acao="remover" ;;
      --fonte) shift; fonte="${1:-}"; [ -n "$fonte" ] || { echo "--fonte precisa de uma pasta" >&2; exit 2; } ;;
      -h|--help) echo "Uso: install.sh [--fonte PASTA] [--remover]. Instala ou atualiza a Fábrica e liga as skills nas pastas globais dos assistentes."; exit 0 ;;
      *) echo "opção desconhecida: $1 (use --fonte PASTA, --remover ou --help)" >&2; exit 2 ;;
    esac
    shift
  done

  # As pastas globais de skills: Claude Code; Codex, Cursor e OpenCode; Antigravity.
  local dest alvo origem raiz ligadas=0 algum=0

  if [ "$acao" = "remover" ]; then
    for dest in "$HOME/.claude/skills" "$HOME/.agents/skills" "$HOME/.gemini/config/skills"; do
      [ -d "$dest" ] || continue
      for alvo in "$dest"/fabrica-*; do
        [ -e "$alvo" ] || [ -L "$alvo" ] || continue
        if eh_nossa "$alvo"; then rm "$alvo"; echo "removida: $alvo"; fi
      done
    done
    echo "Ligações removidas. A cópia baixada, se houver, continua em $casa."
    exit 0
  fi

  if [ -n "$fonte" ]; then
    [ -d "$fonte/skills" ] || { echo "$fonte não parece a Fábrica: falta a pasta skills/" >&2; exit 1; }
    raiz="$(cd "$fonte" && pwd)"
  else
    command -v git >/dev/null 2>&1 || { echo "Preciso do git instalado para baixar a Fábrica." >&2; exit 1; }
    if [ -d "$casa/.git" ]; then
      # Só avança; nunca descarta mudança local de quem editou a cópia.
      if ! git -C "$casa" pull --ff-only --quiet; then
        echo "AVISO: não consegui atualizar $casa (há mudança local ou falta rede)." >&2
        echo "       Sigo com a versão que está lá, que pode estar atrasada." >&2
      fi
    elif [ -e "$casa" ]; then
      echo "$casa existe e não é uma cópia da Fábrica. Mova a pasta ou defina FABRICA_HOME." >&2; exit 1
    else
      mkdir -p "$(dirname "$casa")"
      git clone --quiet "$repo_url" "$casa"
    fi
    raiz="$casa"
  fi

  # Liga só onde o assistente existe. Se nenhum existir, usa a pasta do padrão aberto.
  for dest in "$HOME/.claude" "$HOME/.agents" "$HOME/.gemini"; do
    [ -d "$dest" ] && algum=1
  done
  [ "$algum" -eq 1 ] || mkdir -p "$HOME/.agents"

  for dest in "$HOME/.claude/skills" "$HOME/.agents/skills" "$HOME/.gemini/config/skills"; do
    case "$dest" in
      "$HOME/.claude/"*) [ -d "$HOME/.claude" ] || continue ;;
      "$HOME/.agents/"*) [ -d "$HOME/.agents" ] || continue ;;
      "$HOME/.gemini/"*) [ -d "$HOME/.gemini" ] || continue ;;
    esac
    mkdir -p "$dest"
    for origem in "$raiz"/skills/fabrica-*; do
      [ -d "$origem" ] || continue
      alvo="$dest/$(basename "$origem")"
      if [ -e "$alvo" ] || [ -L "$alvo" ]; then
        if eh_nossa "$alvo"; then rm "$alvo"
        else echo "pulei $alvo: já existe e não foi este script que criou" >&2; continue
        fi
      fi
      ln -s "$origem" "$alvo"
      ligadas=$((ligadas + 1))
      echo "ligada: $alvo"
    done
  done

  [ "$ligadas" -gt 0 ] || { echo "Nenhuma skill foi ligada. Confira as mensagens acima." >&2; exit 1; }

  echo
  echo "Fábrica em: $raiz"
  echo "Abra uma sessão NOVA do seu assistente de código e diga, por exemplo:"
  echo "  \"Usa a Fábrica para fundar um produto: <a sua ideia>\""
}

principal "$@"
