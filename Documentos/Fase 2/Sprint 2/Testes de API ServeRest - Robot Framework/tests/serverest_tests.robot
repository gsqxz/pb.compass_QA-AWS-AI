*** Settings ***
Documentation    Suite de testes da API ServeRest baseada no roteiro Tour do Supermercado.
...              Autor: Gustavo Santos Queiroz
Resource         ../resources/keywords.resource
Suite Setup      Criar Sessao ServeRest

*** Test Cases ***
CT01: Cadastrar Usuário Administrador
    [Tags]    funcional    positivo
    Gerar Dados Dinamicos
    Cadastrar Usuario Administrador

CT02: Realizar Login e Obter Token
    [Tags]    funcional    positivo
    Realizar Login e Salvar Token

CT03: Cadastrar Produto no Estoque
    [Tags]    funcional    positivo
    Cadastrar Produto no Estoque

CT04: Fluxo de Carrinho (Adicionar e Concluir)
    [Tags]    funcional    positivo
    Adicionar ao Carrinho e Concluir Compra

CT05: Login com Senha Inválida
    [Tags]    seguranca    negativo
    ${body}    Create Dictionary    email=${EMAIL_TESTE}    password=senha_errada_123
    ${resposta}    POST On Session    serverest    /login    json=${body}    expected_status=401
    Dictionary Should Contain Item    ${resposta.json()}    message    Email e/ou senha inválidos

CT06: Cadastrar Produto com Preço Negativo
    [Tags]    regra_negocio    negativo
    ${headers}    Create Dictionary    Authorization=${TOKEN_AUTH}
    ${body}    Create Dictionary    nome=Produto Negativo    preco=-50    descricao=Teste    quantidade=10
    ${resposta}    POST On Session    serverest    /produtos    json=${body}    headers=${headers}    expected_status=400
    Dictionary Should Contain Item    ${resposta.json()}    preco    preco deve ser um número positivo

CT07: Validar Contrato de Lista de Usuários
    [Tags]    contrato
    Validar Contrato Basico de Usuarios