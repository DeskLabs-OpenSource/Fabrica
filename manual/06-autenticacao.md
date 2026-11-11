# 06. Autenticação

> Quem pode entrar, com que papel, e como se recupera o acesso. As regras valem para qualquer
> mecanismo; a escolha do mecanismo segue o capítulo 03.

## Decisões a registrar

Cada uma vira uma linha no desenho da fundação. **Ausência também é decisão:** o segundo produto
nasceu sem segundo fator, sem token de API e sem convite pela tela, e nenhuma dessas ausências
foi registrada. Quem lê não sabe se é escolha ou esquecimento.

| Decisão | Opções |
|---|---|
| Mecanismo | Próprio, no banco da VPS; ou um serviço de terceiros |
| Papéis | Quais, em que ordem, e quem altera configuração |
| Papel de instalação | Existe alguém acima das organizações? (Capítulo 08) |
| Segundo fator | Existe? Quem pode exigir? Qual o padrão? Como se recupera? |
| Token de API | Existe? Formato, escopo, como é guardado |
| Primeiro usuário | Como nasce na instalação |
| Cadastro | Aberto, com aprovação, ou só por convite |
| Recuperação de senha | Com e-mail configurado, e sem |
| Limite de tentativas | Por endereço, por identificador, ou os dois |

O ponto de partida, quando o banco mora na VPS: usuários e sessões no mesmo banco, senha com um
algoritmo próprio para senhas, sessão em tabela. A instalação não depende de serviço externo
para alguém entrar.

## As regras

### 1. A sessão é validada no servidor, a cada requisição

Nunca se confia no que o navegador guarda. O servidor busca a sessão e confere a validade.

### 2. Uma função só decide o papel

Toda rota passa pela mesma função de autorização. Comparar o nível do papel à mão dentro de uma
rota é proibido.

*O erro:* no primeiro produto, rotas que comparavam o nível direto pulavam a conferência do
segundo fator, e uma sessão sem ele atravessava.

*Como se cobra:* uma verificação que reprova a comparação direta, e uma matriz de teste com
papel por rota.

### 3. "Pode administrar?" tem uma resposta só

No primeiro produto, a mesma pergunta estava escrita em mais de uma dúzia de arquivos, de três
formas diferentes. Uma função, um lugar.

### 4. Segurança opcional nasce desligada, e se liga pela tela

*O erro:* o primeiro produto forçava o segundo fator para o administrador. Como o instalador
cria o dono como administrador, toda instalação nova recebia um bloqueio de tela cheia logo
depois do onboarding, um passo que ninguém tinha anunciado. Segurança que expulsa o usuário na
primeira tela não protege ninguém.

A regra não é "sem segundo fator". É: quem administra liga, na tela de segurança.

### 5. Exigir o cadastro e exigir a prova são perguntas diferentes

A política decide quem é obrigado a cadastrar um segundo fator. Quem já tem um prova sempre,
com ou sem política. Ligar as duas coisas faria o fator de quem ativou por vontade própria ser
ignorado.

Desligar o próprio fator exige uma sessão já provada. Sem isso, uma sessão roubada desliga a
proteção com um clique.

### 6. Controle que aparece na tela tem efeito

O primeiro produto teve uma opção de segurança que era gravada e nunca lida. Todo controle de
segurança tem um teste que prova que ligar e desligar mudam o comportamento.

### 7. Configuração de segurança lida do banco não reabre sozinha

Se a leitura falha, vale o último valor bom, e nunca o mais permissivo.

### 8. Token de API

- aparece em claro uma vez, na criação;
- no banco, só o resumo criptográfico;
- nunca em endereço de requisição, que vai parar em registro de servidor;
- um formato só, e o mesmo na documentação e no código.

*O erro do último item:* a documentação dizia um prefixo e o código gerava outro.

### 9. O primeiro usuário nasce pelo instalador

Por linha de comando, de forma que rodar duas vezes não cria dois. A senha entra pela entrada
padrão, e nunca como argumento, que fica visível na lista de processos e no histórico.

### 10. Recuperação de emergência só de dentro do servidor

Um comando do kit de instalação troca a senha. Ele encerra todas as sessões do usuário: quem
perdeu a senha pode tê-la perdido para alguém.

A recuperação por e-mail só existe se houver e-mail configurado. Sem ele, a tela diz o motivo e
aponta o comando, em vez de falhar de forma genérica. O endereço do link de recuperação vem da
configuração da instalação, e nunca de um valor de desenvolvimento.

### 11. A resposta de login não revela quem tem conta

Mesma mensagem e mesmo tempo para e-mail inexistente e para senha errada.

### 12. Bloqueio por tentativas não vira arma

*O erro, no segundo produto:* cinco senhas erradas bloqueavam a conta por um tempo. Qualquer
pessoa que soubesse o e-mail do dono o trancava fora, quantas vezes quisesse. Limite só por
identificador é negação de serviço; combine com o endereço de origem.

### 13. Segredo de operador é cifrado em repouso

Chave de provedor e senha de serviço externo nunca ficam em texto puro no banco, em registro ou
em evento.

## Como saber que ficou pronto

- A tabela de decisões está preenchida, incluindo o que não existe.
- Uma rota nova sem a função de autorização é reprovada por alguma verificação.
- A instalação nova chega à primeira tela útil sem nenhum passo de segurança não anunciado.
- O comando de recuperação foi rodado num servidor de verdade e as sessões antigas caíram.
- O que o produto não tem está escrito na seção de limites conhecidos do documento de segurança.

## Origem

Regras 2 a 8: doutrina, política de segundo fator e testes do DeskcommCRM. Regras 9 a 11:
comandos de instalação do DeskVoice. Regra 12: revisão fria do DeskVoice.
