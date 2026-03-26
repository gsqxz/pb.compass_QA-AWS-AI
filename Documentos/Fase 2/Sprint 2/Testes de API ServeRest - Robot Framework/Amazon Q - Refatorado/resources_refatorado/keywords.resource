*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Resource    ../variables_refatorado/variables.resource

*** Keywords ***

# ── Setup de Suite ────────────────────────────────────────────────────────────
# Centraliza toda a preparação de estado em um único ponto de entrada.
# Isso desacopla os test cases entre si: nenhum CT depende de outro para rodar.

Preparar Suite
    Create Session    serverest    ${BASE_URL}
    Gerar Dados Dinamicos
    Cadastrar Usuario Administrador
    Realizar Login e Salvar Token
    Cadastrar Produto no Estoque

Gerar Dados Dinamicos
    ${random_str}    Generate Random String    8    [LOWER]
    Set Suite Variable    ${EMAIL_TESTE}    tour_${random_str}@qa.com
    Set Suite Variable    ${NOME_PRODUTO}   Produto Automacao ${random_str}

Cadastrar Usuario Administrador
    ${body}       Create Dictionary
    ...           nome=${NOME_USUARIO}    email=${EMAIL_TESTE}
    ...           password=${PASSWORD_TESTE}    administrador=${ADMIN_FLAG}
    ${resposta}   POST On Session    serverest    /usuarios    json=${body}
    Status Should Be    201    ${resposta}
    Dictionary Should Contain Item    ${resposta.json()}    message    Cadastro realizado com sucesso
    Set Suite Variable    ${ID_USUARIO}    ${resposta.json()}[_id]

Realizar Login e Salvar Token
    ${body}       Create Dictionary    email=${EMAIL_TESTE}    password=${PASSWORD_TESTE}
    ${resposta}   POST On Session    serverest    /login    json=${body}
    Status Should Be    200    ${resposta}
    # Garante que o token existe e não está vazio antes de usá-lo
    Dictionary Should Contain Key    ${resposta.json()}    authorization
    ${token}      Set Variable    ${resposta.json()}[authorization]
    Should Not Be Empty    ${token}
    ${headers}    Create Dictionary    Authorization=${token}
    Set Suite Variable    ${HEADERS_AUTH}    ${headers}

Cadastrar Produto no Estoque
    ${body}       Create Dictionary
    ...           nome=${NOME_PRODUTO}    preco=${PRECO_PRODUTO}
    ...           descricao=${DESCRICAO_PRODUTO}    quantidade=${QUANTIDADE_PRODUTO}
    ${resposta}   POST On Session    serverest    /produtos    json=${body}    headers=${HEADERS_AUTH}
    Status Should Be    201    ${resposta}
    Set Suite Variable    ${ID_PRODUTO}    ${resposta.json()}[_id]

# ── Keywords de Teste ─────────────────────────────────────────────────────────

Adicionar ao Carrinho e Concluir Compra
    ${produto_json}     Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    ${lista_produtos}   Create List    ${produto_json}
    ${body_carrinho}    Create Dictionary    produtos=${lista_produtos}
    ${resp_carrinho}    POST On Session    serverest    /carrinhos
    ...                 json=${body_carrinho}    headers=${HEADERS_AUTH}
    Status Should Be    201    ${resp_carrinho}
    ${resp_concluir}    DELETE On Session    serverest    /carrinhos/concluir-compra    headers=${HEADERS_AUTH}
    Status Should Be    200    ${resp_concluir}
    Dictionary Should Contain Item    ${resp_concluir.json()}    message    Registro excluído com sucesso

Tentativa de Login com Senha Invalida
    ${body}       Create Dictionary    email=${EMAIL_TESTE}    password=senha_errada_123
    ${resposta}   POST On Session    serverest    /login    json=${body}    expected_status=401
    Dictionary Should Contain Item    ${resposta.json()}    message    Email e/ou senha inválidos

Cadastrar Produto com Preco Negativo
    # Dead code removido: a linha "${headers} Create Dictionary Authorization=${HEADERS_AUTH}"
    # existia no original mas nunca era usada — HEADERS_AUTH já é o dicionário correto.
    ${body}       Create Dictionary
    ...           nome=Produto Negativo    preco=-50    descricao=Teste Negativo    quantidade=10
    ${resposta}   POST On Session    serverest    /produtos
    ...           json=${body}    headers=${HEADERS_AUTH}    expected_status=400
    Dictionary Should Contain Item    ${resposta.json()}    preco    preco deve ser um número positivo

Validar Contrato Basico de Usuarios
    ${resposta}   GET On Session    serverest    /usuarios
    Status Should Be    200    ${resposta}
    ${body}       Set Variable    ${resposta.json()}
    Dictionary Should Contain Key    ${body}    quantidade
    Dictionary Should Contain Key    ${body}    usuarios
    # Garante que a lista não está vazia antes de acessar o índice 0
    # (o original quebraria com IndexError em banco vazio)
    ${lista}      Set Variable    ${body}[usuarios]
    Should Not Be Empty    ${lista}    msg=A lista de usuários está vazia — contrato não pode ser validado
    ${primeiro}   Set Variable    ${lista}[0]
    FOR    ${chave}    IN    nome    email    password    administrador    _id
        Dictionary Should Contain Key    ${primeiro}    ${chave}
    END

Validar Aceitacao de Preco Decimal
    ${body}       Create Dictionary
    ...           nome=Produto Decimal ${NOME_PRODUTO}    preco=19000.99
    ...           descricao=RTX 5090    quantidade=10
    ${resposta}   POST On Session    serverest    /produtos
    ...           json=${body}    headers=${HEADERS_AUTH}    expected_status=201

Validar Rejeicao de Email Invalido
    # BUG DOCUMENTADO: A API aceita emails com caracteres inválidos (retorna 201 em vez de 400).
    # expected_status=any é intencional: captura o _id para garantir limpeza no teardown,
    # independentemente de a API estar com o bug ativo ou corrigido.
    ${body}       Create Dictionary
    ...           nome=Teste Email Ruim    email=#emailinvalido🚀@qa.com
    ...           password=${PASSWORD_TESTE}    administrador=${ADMIN_FLAG}
    ${resposta}   POST On Session    serverest    /usuarios    json=${body}    expected_status=any
    # Só seta o ID se o recurso foi criado (bug ativo) — evita poluir o estado com valor inválido
    ${id_criado}  Set Variable    ${resposta.json().get('_id', '')}
    Run Keyword If    '${id_criado}' != ''    Set Suite Variable    ${ID_EMAIL_INVALIDO}    ${id_criado}
    Status Should Be    400    ${resposta}

# ── Teardown ──────────────────────────────────────────────────────────────────
# Condicional: só executa o DELETE se o ID foi de fato setado durante a suite.
# Isso evita chamadas com ID vazio quando um CT falha antes de criar o recurso.

Limpar Dados da Sessao
    Run Keyword If    '${ID_PRODUTO}' != '${EMPTY}'
    ...    DELETE On Session    serverest    /produtos/${ID_PRODUTO}    headers=${HEADERS_AUTH}    expected_status=any
    Run Keyword If    '${ID_EMAIL_INVALIDO}' != '${EMPTY}'
    ...    DELETE On Session    serverest    /usuarios/${ID_EMAIL_INVALIDO}    expected_status=any
    Run Keyword If    '${ID_USUARIO}' != '${EMPTY}'
    ...    DELETE On Session    serverest    /usuarios/${ID_USUARIO}    expected_status=any
    Delete All Sessions
