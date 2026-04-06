# PROMPT

Atue como um Engenheiro de Qualidade Sênior especialista em automação com Robot Framework. Eu desenvolvi uma suíte de testes E2E para a API pública ServeRest utilizando a biblioteca RequestsLibrary. O código está estruturado no padrão Keyword-Driven, dividido em um arquivo de variáveis (variaveis.resource), um arquivo de recursos (keywords.resource) e um arquivo de testes (serverest_tests.robot).

Seu objetivo é atuar como meu revisor técnico (Code Review) e refatorar essa suíte para elevar o nível de maturidade do projeto. Por favor:

Análise Crítica Geral: Avalie o código atual e aponte oportunidades de melhoria em relação a boas práticas do Robot Framework, otimização de requisições, limpeza de código, aplicação do princípio DRY (Don't Repeat Yourself) e resiliência dos testes.

Refatoração: Reescreva os trechos de código que podem ser otimizados com base na sua análise técnica, mas não em cima dos arquivos originais (crie cópias para os códigos novos). Não delete os casos de teste de bugs. Mantenha a separação estrutural exata entre os arquivos .robot e .resource.

Use a pasta completa Testes de API ServeRest - Robot Framework como contexto.


# RESPOSTA

Originais intactos, cópias criadas. Aqui está o resumo completo do que foi feito e por quê:

## Análise Crítica — 8 problemas encontrados

### 🔴 High
**Acoplamento implícito entre test cases**
CT01 seta `EMAIL_TESTE`, CT02 seta `HEADERS_AUTH`, CT03 seta `ID_PRODUTO` — cada CT depende do anterior ter passado. Se CT01 falha, os 8 restantes falham em cascata por variável não inicializada, não por falha real.

### 🟡 Medium
**Dados hardcoded dentro de keywords**
`nome=QA Tester`, `password=teste`, `descricao=Mouse Gamer`, `quantidade=50`, `preco=100` estão embutidos nas keywords. Viola a separação dados/lógica e dificulta manutenção.

**Teardown frágil**
`Limpar Dados da Sessao` chama DELETE com `ID_PRODUTO`, `ID_USUARIO` e `ID_EMAIL_INVALIDO` sem verificar se foram setados. Se qualquer CT falhou antes de criar o recurso, o DELETE vai com ID vazio — erro silenciado pelo `expected_status=any`.

**CT09 com side effect perigoso**
`Set Suite Variable ${ID_EMAIL_INVALIDO}` é chamado antes da asserção de status. Se a API retornar 400 sem `_id` no body (comportamento correto), o teste quebra com `KeyError` antes mesmo de chegar na asserção.

**CT07 quebra com banco vazio**
`${resposta.json()}[usuarios][0]` assume que a lista nunca está vazia. Em banco vazio, lança `IndexError` — o teste falha pelo motivo errado.

### 🔵 Low
**`TOKEN_AUTH` — dead code**:
Declarada em `variables.resource`, nunca usada. O token vai direto para `HEADERS_AUTH`.

**`${headers}` duplicado em `Cadastrar Produto com Preco Negativo`**:
`Create Dictionary Authorization=${HEADERS_AUTH}` cria um dicionário local que nunca é usado — a keyword já usa `${HEADERS_AUTH}` diretamente na linha seguinte.

**Login sem validação do corpo**:
Apenas o status 200 é verificado. O campo `authorization` é acessado diretamente sem checar se existe e se não está vazio.


## O que mudou em cada arquivo refatorado

**`variables_refatorado/variables.resource`**
- Removido `${TOKEN_AUTH}` (dead code)
- Extraídos `${NOME_USUARIO}`, `${PASSWORD_TESTE}`, `${ADMIN_FLAG}`, `${DESCRICAO_PRODUTO}`, `${QUANTIDADE_PRODUTO}`, `${PRECO_PRODUTO}`
- Todos os IDs inicializados com `${EMPTY}` — teardown condicional agora funciona sem erros

**`resources_refatorado/keywords.resource`**
- Criada `Preparar Suite`: encapsula sessão + dados dinâmicos + usuário + login + produto em um único ponto de entrada
- `Realizar Login e Salvar Token`: adicionados `Dictionary Should Contain Key` e `Should Not Be Empty` antes de usar o token
- `Cadastrar Produto com Preco Negativo`: removida a linha `${headers} Create Dictionary` que era dead code
- `Validar Contrato Basico de Usuarios`: adicionado `Should Not Be Empty ${lista}` antes de acessar `[0]`
- `Validar Rejeicao de Email Invalido`: `Set Suite Variable` agora é condicional via `Run Keyword If` — só seta se `_id` existir na resposta
- `Limpar Dados da Sessao`: cada DELETE envolto em `Run Keyword If '${ID}' != '${EMPTY}'`

**`tests_refatorado/serverest_tests.robot`**
- `Suite Setup` chama `Preparar Suite` — CT01–CT03 originais (que eram pré-condições disfarçadas de testes) saem do arquivo de testes
- 6 CTs independentes, cada um com uma única responsabilidade
- Bugs CT05 e CT06 preservados com `[Documentation]` descrevendo comportamento atual vs. esperado
- Comando para executar a versão refatorada: `robot -d .\results\ .\tests_refatorado\serverest_tests.robot`


## Avaliação do uso de Amazon Q

| Pontos positivos | Pontos negativos |
|---|---|
| Code Review Rápido | Desconhecimento das regras de negócio |
| Identificação de Riscos | Limitações dos planos de modelo |
| Sugestões de Melhoria | Alimentação de contexto detalhado necessário |
| Feedback Imediato | Risco de efeito colateral |
| Limpeza e Refatoração | Alucinação com bibliotecas |
| Tratamento de Erros | Impossibilidade de selecionar partes específicas do código |
