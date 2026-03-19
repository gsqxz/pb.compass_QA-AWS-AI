*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections
Resource    ../variables/variables.resource

*** Keywords ***
Criar Sessao ServeRest
    Create Session    serverest    ${BASE_URL}

Gerar Dados Dinamicos
    ${random_str}    Generate Random String    8    [LOWER]
    
    Set Suite Variable    ${EMAIL_TESTE}    tour_${random_str}@qa.com
    Set Suite Variable    ${NOME_PRODUTO}   Produto Automacao ${random_str}

Cadastrar Usuario Administrador
    ${body}    Create Dictionary    nome=QA Tester    email=${EMAIL_TESTE}    password=teste    administrador=true
    ${resposta}    POST On Session    serverest    /usuarios    json=${body}
    
    Status Should Be    201    ${resposta}
    Dictionary Should Contain Item    ${resposta.json()}    message    Cadastro realizado com sucesso

Realizar Login e Salvar Token
    ${body}    Create Dictionary    email=${EMAIL_TESTE}    password=teste
    ${resposta}    POST On Session    serverest    /login    json=${body}
    
    Status Should Be    200    ${resposta}
    ${token}    Set Variable    ${resposta.json()}[authorization]
    Set Suite Variable    ${TOKEN_AUTH}    ${token}

Cadastrar Produto no Estoque
    ${headers}    Create Dictionary    Authorization=${TOKEN_AUTH}
    ${body}    Create Dictionary    nome=${NOME_PRODUTO}    preco=100    descricao=Mouse Gamer    quantidade=50
    ${resposta}    POST On Session    serverest    /produtos    json=${body}    headers=${headers}
    
    Status Should Be    201    ${resposta}
    Set Suite Variable    ${ID_PRODUTO}    ${resposta.json()}[_id]

Adicionar ao Carrinho e Concluir Compra
    ${headers}    Create Dictionary    Authorization=${TOKEN_AUTH}
    
    # Adicionar ao Carrinho
    ${produto_json}    Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    ${lista_produtos}    Create List    ${produto_json}
    ${body_carrinho}    Create Dictionary    produtos=${lista_produtos}
    
    ${resp_carrinho}    POST On Session    serverest    /carrinhos    json=${body_carrinho}    headers=${headers}
    Status Should Be    201    ${resp_carrinho}
    
    # Concluir Compra
    ${resp_concluir}    DELETE On Session    serverest    /carrinhos/concluir-compra    headers=${headers}
    Status Should Be    200    ${resp_concluir}
    Dictionary Should Contain Item    ${resp_concluir.json()}    message    Registro excluído com sucesso

Tentativa de Login com Senha Invalida
    ${body}    Create Dictionary    email=${EMAIL_TESTE}    password=senha_errada_123
    
    ${resposta}    POST On Session    serverest    /login    json=${body}    expected_status=401
    
    Dictionary Should Contain Item    ${resposta.json()}    message    Email e/ou senha inválidos

Cadastrar Produto com Preco Negativo
    ${headers}    Create Dictionary    Authorization=${TOKEN_AUTH}
    ${body}    Create Dictionary    nome=Produto Negativo    preco=-50    descricao=Teste Negativo    quantidade=10
    
    ${resposta}    POST On Session    serverest    /produtos    json=${body}    headers=${headers}    expected_status=400
    
    Dictionary Should Contain Item    ${resposta.json()}    preco    preco deve ser um número positivo

Validar Contrato Basico de Usuarios
    ${resposta}    GET On Session    serverest    /usuarios
    Status Should Be    200    ${resposta}
    
    Dictionary Should Contain Key    ${resposta.json()}    quantidade
    Dictionary Should Contain Key    ${resposta.json()}    usuarios
    
    ${primeiro_usuario}    Set Variable    ${resposta.json()}[usuarios][0]
    Dictionary Should Contain Key    ${primeiro_usuario}    nome
    Dictionary Should Contain Key    ${primeiro_usuario}    email
    Dictionary Should Contain Key    ${primeiro_usuario}    password
    Dictionary Should Contain Key    ${primeiro_usuario}    administrador
    Dictionary Should Contain Key    ${primeiro_usuario}    _id