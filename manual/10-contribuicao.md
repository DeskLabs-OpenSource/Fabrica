# 10. Contribuição

> Como um projeto recebe centenas de contribuições sem que o dono vire o gargalo e sem que quem
> contribui desista. O que se repete: a régua é entregue a quem contribui antes de ele ser
> medido por ela, e o que cabe numa regra escrita não espera por ninguém.

## Decisões do dono

1. **A casa.** O repositório nasce numa organização, e nunca numa conta pessoal. Mudar depois
   quebra os endereços das imagens que as instalações já usam, e a conta pessoal tem um teto de
   execuções de CI e não oferece fila de merge.
2. **Quem mantém.** Quem tem permissão de escrita, e quem pode convidar.
3. **O que só o dono decide.** A lista curta do documento de governança.

## Os arquivos de contribuição

| Arquivo | Função |
|---|---|
| `CONTRIBUTING.md` | O fluxo, do clone à contribuição aceita, com a definição de pronto em duas listas |
| `GOVERNANCE.md` | Quem decide o quê, regras de produto, pedido de decisão, caminho de merge |
| `CREDITS.md` | De onde veio cada coisa trazida de fora, e a parceria |
| `SECURITY.md` | Relato privado, prazos, e os limites conhecidos do produto |
| `CODE_OF_CONDUCT.md` | Conduta |
| Modelos de issue e de contribuição | O que perguntar a quem abre |
| Skills embutidas | O guia que o assistente de código de quem contribui carrega sozinho |

## Governança

### Regras de produto, para decidir sem o dono

*O erro:* no primeiro produto, centenas de decisões pequenas esperaram pelo dono, e
contribuições boas esfriaram. Boa parte era a mesma pergunta com outra roupa: "isso entra no
núcleo?".

O documento de governança traz as regras que respondem essas perguntas, cada uma com o porquê,
para valer no caso que ninguém previu. As que todo produto da família tem:

1. O que entra no núcleo e o que é peça plugável, com um teste objetivo.
2. Código de nicho nunca no núcleo.
3. Nada que facilite o abuso do domínio.
4. Nada que exija acesso ao servidor para ligar um recurso.
5. Sem recurso pago e sem telemetria.
6. O caminho genérico nunca é sabotado.
7. Quem já instalou não é surpreendido.

### Pedido de decisão, com padrão

Quando nenhuma regra resolve, abre-se um pedido no formato de
[`modelos/pedido-de-decisao.md`](../modelos/pedido-de-decisao.md). O que o torna diferente de
uma pergunta:

- toda opção tem custo, inclusive "não fazer";
- há uma recomendação, com uma razão ligada a quem usa;
- **há um padrão que vale se ninguém responder em N dias**, e ele é o caminho reversível;
- há uma seção "não medido", que não fica vazia.

Se nenhuma opção é reversível, o prazo não corre, e o pedido diz isso.

### Um caminho de merge

- Tudo entra por contribuição revisada, pela **fila de merge**. Ninguém mescla direto, nem o
  dono.
- A fila testa cada contribuição sobre o estado em que ela vai entrar. É isso que impede duas
  contribuições verdes de quebrarem o ramo principal juntas (lição C2).
- Quem escreveu não aprova. Vale para pessoa e para agente.
- Se o ramo principal ficar vermelho, consertá-lo tem prioridade sobre qualquer contribuição.

No primeiro produto a fila de merge não estava disponível, por ser conta pessoal, e o projeto
precisou construir um procedimento manual de integração em lote para substituí-la.

## Quem contribui

### Uma skill que espelha a revisão

O repositório traz uma skill de contribuição que o assistente de código carrega. Ela mede antes
o que a revisão vai medir depois.

*O porquê:* quem contribui erra por não conhecer a régua, e não por descuido.

Como ela se comporta:

- **Descobre quem está no teclado.** Para quem mantém, fica em silêncio.
- **O pré-voo só mede e nunca bloqueia.** Cada linha traz o comando que a produziu, e ele diz o
  que não mediu.
- **Os hooks barram só o irreversível:** segredo no commit, envio direto ao ramo principal,
  migration que colide.
- **Mede contra a referência certa.** Para quem contribui de uma cópia, a referência é o
  repositório original, e não a cópia (lição G6).

A fonte das skills fica numa pasta neutra, que vários assistentes leem; as pastas específicas
de cada ferramenta são espelho gerado, e uma cerca reprova o espelho fora de sincronia.

### Acolhida em minutos, sem avaliar mérito

Toda contribuição de fora recebe uma resposta automática em minutos, com o prazo humano
declarado.

- **Ela não avalia.** Um selo automático é pior que silêncio, porque parece revisão.
- **O prazo prometido foi medido antes de ser escrito.**
- **O workflow não baixa o código da contribuição,** não usa ações de terceiros e tem a
  permissão mínima. Ele roda com poder do repositório.

*O erro:* no primeiro produto, dezenas de contribuições foram fechadas pelo próprio autor em
menos de uma hora, algumas sem receber uma palavra.

### O que é trabalho do projeto, e não de quem contribui

Dito no modelo de contribuição, para ninguém desistir por causa disso:

- o fragmento de versão, se faltar;
- resolver conflito com o ramo principal;
- ajustar o carimbo de uma migration;
- tradução dos textos de tela;
- a prova pela tela, quando exige um ambiente que só o projeto tem.

Exigir a prova sem entregar a ferramenta é pedágio.

### "Pego esta"

Quem vai trabalhar numa issue diz isso nela, e quem mantém confere antes de começar a mesma
coisa. No primeiro produto, um mantenedor entregou a mesma correção segundos antes do
contribuidor.

### Crédito é regra

- A autoria da contribuição é preservada, mesmo quando o projeto precisa ajustá-la. O ajuste é
  um commit a mais no ramo dela, e nunca uma reescrita por fora.
- O nome de quem fez aparece na nota da versão.
- Código trazido de outro projeto entra em `CREDITS.md` na mesma mudança (lição G4).
- Quando o desenho de quem veio de fora é melhor, adota-se o dele.

## Quem mantém

### Triagem em papéis separados

Quem mede não julga, e quem julga é atacado antes de publicar. Três papéis, que podem ser
agentes:

| Papel | Faz | Não faz |
|---|---|---|
| Medidor | Roda os checks sobre o resultado do merge, e percorre o que o CI não vê | Não corrige e não dá veredito |
| Reprodutor | Reproduz o defeito no ramo principal de hoje, escreve o teste que falta e o sabota | Não trabalha fora da própria cópia |
| Cético | Tenta refutar o veredito antes de ele ser publicado | Não corrige e não publica |

O cético recusa veredito sem a seção "não medido", pedido sem medição anexada, e afirmação cuja
evidência é só a presença de um nome no código.

### Regras da triagem

- **A triagem conserta o que é mecânico.** Só segura o que não deve entrar.
- **Os checks rodam sobre o resultado do merge,** e não sobre o ramo da contribuição.
- **O custo da triagem acompanha o raio de dano.** Mudança em autenticação, isolamento,
  pagamento ou instalador recebe revisão adversarial; mudança de texto, não.
- **Catraca.** Todo defeito que escapou vira um check.
- **De quem é a dívida.** Se uma guarda do projeto estava cega, o defeito é do projeto.
- **Achado de segurança não vai em comentário público,** nem como pendência.

### Quando montar a máquina de triagem

O primeiro produto tem um procedimento de triagem longo, com instrumentos próprios. Ele existe
para manter um repositório com milhares de contribuições. Um projeto que nasce não precisa dele:
bastam as regras de produto, o pedido de decisão e os três papéis. A máquina se monta quando a
fila mostrar que precisa.

## Suporte é decisão escrita

Antes do lançamento, o projeto decide e publica: quem responde, em quanto tempo, por qual
canal. "Ninguém, e este é o caminho" é uma resposta válida, desde que escrita.

*O erro:* o espaço da comunidade do primeiro produto abriu dizendo que não havia suporte.
Perguntas ficaram semanas sem resposta, e quem resolvia eram dois ou três membros.

- Pergunta sem resposta no prazo declarado tem dono.
- **Dúvida repetida três vezes é defeito de produto,** e vira issue.
- **O ciclo curto é o que mais rende:** pedido pequeno, atendido em dias, com crédito a quem
  pediu.
- Membros que ajudam membros são um ativo, e um risco se forem o único suporte.

## Segurança

- Vulnerabilidade se relata em privado.
- A correção é feita em ramo privado e publicada junto com a versão corrigida.
- É a única mudança que pode entrar sem o prazo normal de revisão pública. Passa pelos mesmos
  testes.
- O documento de segurança tem uma seção **limites conhecidos**: o que o produto não protege,
  dito antes que alguém descubra.

## Como saber que ficou pronto

- Uma pessoa de fora abriu uma contribuição seguindo só o repositório, e o CI disse de quem era
  a culpa quando ficou vermelho.
- A acolhida respondeu em minutos.
- Uma decisão foi tomada pelo padrão, sem o dono.
- A proteção do ramo principal exige aprovação e fila de merge, e foi conferida na configuração.

## Origem

Documento de governança, skill de contribuição e workflow de acolhida do DeskVoice; guia de
contribuição, procedimento e agentes de triagem do DeskcommCRM.
