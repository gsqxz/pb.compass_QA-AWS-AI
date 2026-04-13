*** Settings ***
Documentation    Arquivo de configuração central e Setup da automação da API ServeRest.
...              Este arquivo deve ser importado em todos os arquivos de teste.

Library          RequestsLibrary

*** Variables ***
# Baseado na lista de servers documentada no swagger.json
${BASE_URL}      https://serverest.dev

*** Keywords ***
Criar Sessao ServeRest
    [Documentation]    Inicializa uma sessão HTTP global para a API ServeRest.
    ...                Utilizamos uma sessão para reaproveitar a conexão TCP e 
    ...                facilitar a passagem de Headers (como o Token de autenticação) no futuro.
    
    # O comando abaixo cria a sessão chamada "ServeRest" apontando para a URL base.
    Create Session    alias=ServeRest    url=${BASE_URL}    verify=${True}

Criar Usuario No ServeRest
    [Arguments]    ${nome}    ${email}    ${password}    ${admin}
    ${body}        Create Dictionary    nome=${nome}    email=${email}    password=${password}    administrador=${admin}
    ${response}    POST On Session      alias=ServeRest    url=/usuarios    json=${body}    expected_status=201
    # Asserção de corpo baseada no schema 'cadastroComSucesso'
    Dictionary Should Contain Value    ${response.json()}    Cadastro realizado com sucesso
    Should Not Be Empty                ${response.json()["_id"]}
    RETURN         ${response.json()["_id"]}

Realizar Login
    [Arguments]    ${email}    ${password}
    ${body}        Create Dictionary    email=${email}    password=${password}
    ${response}    POST On Session      alias=ServeRest    url=/login    json=${body}    expected_status=200
    Dictionary Should Contain Value    ${response.json()}    Login realizado com sucesso
    
    ${token_retornado}    Set Variable    ${response.json()["authorization"]}
    Should Not Be Empty   ${token_retornado}
    Should Start With     ${token_retornado}    Bearer 
    
    RETURN         ${token_retornado}

Cadastrar Produto No ServeRest
    [Arguments]    ${nome}    ${preco}    ${desc}    ${qtd}    ${token}
    ${headers}     Create Dictionary    Authorization=${token}
    ${body}        Create Dictionary    nome=${nome}    preco=${preco}    descricao=${desc}    quantidade=${qtd}
    ${response}    POST On Session      alias=ServeRest    url=/produtos    json=${body}    headers=${headers}    expected_status=201
    Dictionary Should Contain Value    ${response.json()}    Cadastro realizado com sucesso
    RETURN         ${response.json()["_id"]}

Editar Produto No ServeRest
    [Arguments]    ${id}    ${nome}    ${preco}    ${desc}    ${qtd}    ${token}
    ${headers}     Create Dictionary    Authorization=${token}
    ${body}        Create Dictionary    nome=${nome}    preco=${preco}    descricao=${desc}    quantidade=${qtd}
    ${response}    PUT On Session       alias=ServeRest    url=/produtos/${id}    json=${body}    headers=${headers}    expected_status=200
    # Asserção baseada no schema 'alteradoComSucesso'
    Dictionary Should Contain Value    ${response.json()}    Registro alterado com sucesso

Realizar Login Esperando Falha
    [Arguments]    ${email}    ${password}    ${status_esperado}=401
    ${body}        Create Dictionary    email=${email}    password=${password}
    # O parametro expected_status captura o erro intencional para validação
    ${response}    POST On Session      alias=ServeRest    url=/login    json=${body}    expected_status=${status_esperado}
    RETURN         ${response.json()}

Cadastrar Usuario Esperando Falha
    [Arguments]    ${nome}    ${email}    ${password}    ${admin}    ${status_esperado}=400
    ${body}        Create Dictionary    nome=${nome}    email=${email}    password=${password}    administrador=${admin}
    ${response}    POST On Session      alias=ServeRest    url=/usuarios    json=${body}    expected_status=${status_esperado}
    RETURN         ${response.json()}

Cadastrar Produto Esperando Falha
    [Arguments]    ${nome}    ${preco}    ${desc}    ${qtd}    ${token}    ${status_esperado}
    ${headers}     Create Dictionary    Authorization=${token}
    ${body}        Create Dictionary    nome=${nome}    preco=${preco}    descricao=${desc}    quantidade=${qtd}
    ${response}    POST On Session      alias=ServeRest    url=/produtos    json=${body}    headers=${headers}    expected_status=${status_esperado}
    RETURN         ${response.json()}

Validar Contrato da Lista de Produtos
    [Documentation]    Valida se a estrutura de /produtos segue o schema 'getProdutos'
    ${response}        GET On Session    alias=ServeRest    url=/produtos    expected_status=200
    
    # Validação da Raiz (Chaves obrigatórias e tipos)
    Dictionary Should Contain Key    ${response.json()}    quantidade
    Dictionary Should Contain Key    ${response.json()}    produtos
    
    # Validação de Tipos (quantidade: number/int, produtos: list)
    Should Be True    isinstance($response.json()['quantidade'], (int, float))
    Should Be True    isinstance($response.json()['produtos'], list)

    # Valida o primeiro item do array se ele não estiver vazio
    IF    $response.json()['quantidade'] > 0
        ${produto}    Set Variable    ${response.json()['produtos'][0]}
        Dictionary Should Contain Key    ${produto}    nome
        Dictionary Should Contain Key    ${produto}    preco
        Dictionary Should Contain Key    ${produto}    descricao
        Dictionary Should Contain Key    ${produto}    quantidade
        Dictionary Should Contain Key    ${produto}    _id
        
        # Verificação de Tipos dos campos do produto
        Should Be True    isinstance($produto['nome'], str)
        Should Be True    isinstance($produto['preco'], int)
        Should Be True    isinstance($produto['descricao'], str)
        Should Be True    isinstance($produto['quantidade'], int)
        Should Be True    isinstance($produto['_id'], str)
    END

Validar Contrato de Resposta do Login
    [Arguments]    ${email}    ${password}
    [Documentation]    Valida se a estrutura de /login segue o schema 'loginComSucesso'
    ${body}        Create Dictionary    email=${email}    password=${password}
    ${response}    POST On Session      alias=ServeRest    url=/login    json=${body}    expected_status=200
    
    # Validação de Chaves
    Dictionary Should Contain Key    ${response.json()}    message
    Dictionary Should Contain Key    ${response.json()}    authorization
    
    # Validação de Tipos (Ambos devem ser String)
    Should Be True    isinstance($response.json()['message'], str)
    Should Be True    isinstance($response.json()['authorization'], str)