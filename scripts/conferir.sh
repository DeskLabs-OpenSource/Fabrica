#!/usr/bin/env bash
# Confere o que a Fábrica afirma sobre si mesma: links internos, caminhos da referência e a
# ausência do que não pode ser publicado. Sai com erro se algo falhar.
#
#   bash scripts/conferir.sh                 confere links e termos proibidos
#   bash scripts/conferir.sh ~/.desklabs/referencia   confere também os caminhos da referência
set -euo pipefail
cd "$(dirname "$0")/.." || exit 1
REF="${1:-}"
python3 - "$REF" <<'PY'
import re, os, glob, sys
ref = sys.argv[1]
falhas = 0
arquivos = [f for f in glob.glob('**/*.md', recursive=True) if not f.startswith('_privado')]

# 1. Links internos apontam para arquivo que existe.
for f in arquivos:
    t = open(f, encoding='utf-8').read()
    for m in re.finditer(r'\]\(([^)#]+)\)', t):
        p = m.group(1)
        if p.startswith('http'):
            continue
        if not os.path.exists(os.path.normpath(os.path.join(os.path.dirname(f), p))):
            falhas += 1
            print(f'link quebrado: {f} -> {p}')

# 2. Nada de número interno, menção a pessoa ou valor em dinheiro nos arquivos públicos.
proibido = re.compile(r'#[0-9]{2,}\b|(?<![\w`/.-])@[a-z0-9_-]{3,}|R\$ ?[0-9]')
email = re.compile(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+\.[A-Za-z0-9.-]*[a-z]{2,}')
local = re.compile(r'/Users/|/home/[a-z]|/private/tmp')
# Este arquivo fica de fora: ele contém os próprios padrões que procura.
textos = arquivos + [f for f in glob.glob('**/*.sh', recursive=True)
                     if not f.startswith('_privado') and f != 'scripts/conferir.sh']
for f in textos:
    for n, linha in enumerate(open(f, encoding='utf-8'), 1):
        achou = email.search(linha) or local.search(linha)
        if not achou and f.endswith('.md') and not f.startswith('modelos/'):
            achou = proibido.search(linha)
        if achou and 'noreply@' not in linha:
            falhas += 1
            print(f'termo que não se publica: {f}:{n}: {linha.strip()[:80]}')

# 3. Caminhos citados da referência existem (só com a pasta dela informada).
if ref:
    vistos = 0
    for f in ('licoes.md', 'referencia.md'):
        for linha in open(f, encoding='utf-8'):
            if not linha.startswith('| '):
                continue
            for p in re.findall(r'`([^`<>]+)`', linha):
                p = p.split(',')[0].strip()
                if '/' not in p or p.startswith(('manual/', 'modelos/', 'skills/', '~', 'http')):
                    continue
                vistos += 1
                if not os.path.exists(os.path.join(os.path.expanduser(ref), p)):
                    falhas += 1
                    print(f'não existe na referência: {f}: {p}')
    print(f'caminhos da referência conferidos: {vistos}')
    if vistos == 0:
        falhas += 1
        print('nenhum caminho conferido: a sonda está cega')

print(f'arquivos lidos: {len(arquivos)} | falhas: {falhas}')
sys.exit(1 if falhas else 0)
PY
