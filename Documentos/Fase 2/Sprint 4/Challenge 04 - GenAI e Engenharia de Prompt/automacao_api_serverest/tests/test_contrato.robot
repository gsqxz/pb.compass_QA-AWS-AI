*** Settings ***
Documentation    Testes de Contrato da API ServeRest para garantir integridade estrutural.
...              Referência técnica única: arquivo swagger.json fornecido.
Resource         ../resources/base.resource
Library          FakerLibrary
Test Setup       Criar Sessao ServeRest

*** Test Cases ***

CT20 - Validar Contrato da Lista de Produtos
    [Documentation]    Garante que o endpoint GET /produtos não teve alteração de contrato.
    [Tags]             CT20
    Validar Contrato da Lista de Produtos

CT21 - Validar Contrato de Resposta do Login
    [Documentation]    Garante que o endpoint POST /login retorna as chaves e tipos corretos.
    [Tags]             CT21
    # Cria um usuário para garantir que o login terá sucesso e retornará o schema 200
    ${EMAIL}    FakerLibrary.Email
    Criar Usuario No ServeRest    QA Contract    ${EMAIL}    senha123    true
    Validar Contrato de Resposta do Login    ${EMAIL}    senha123