*** Settings ***
Documentation    Suíte de testes positivos (Happy Path) da API ServeRest.
...              Baseado na documentação oficial swagger.json. Refatorado para independência total.
Resource         ../resources/base.resource
Library          FakerLibrary    locale=pt_BR
Test Setup       Criar Sessao ServeRest

*** Test Cases ***

CT15 - Cadastrar Usuário Cliente com Sucesso
    [Documentation]    Valida a criação de um usuário comum (administrador=false).
    [Tags]             CT15
    ${NOME}            FakerLibrary.Name
    ${EMAIL}           FakerLibrary.Email
    Criar Usuario No ServeRest    ${NOME}    ${EMAIL}    senha123    false

CT02 - Realizar Login com Sucesso
    [Documentation]    Valida a autenticação e captura do token Bearer.
    [Tags]             CT02
    ${EMAIL}           FakerLibrary.Email
    Criar Usuario No ServeRest    Admin QA    ${EMAIL}    senha123    true
    ${TOKEN}           Realizar Login    ${EMAIL}    senha123

CT03 - Cadastrar Produto com Sucesso
    [Documentation]    Valida o cadastro de um novo produto no estoque.
    [Tags]             CT03
    # 1. Preparação (Setup interno do teste)
    ${EMAIL}           FakerLibrary.Email
    Criar Usuario No ServeRest    Admin QA    ${EMAIL}    senha123    true
    ${TOKEN}           Realizar Login    ${EMAIL}    senha123

    # 2. Ação e Validação
    ${PRODUTO}         FakerLibrary.Word
    ${PRECO}           FakerLibrary.Random Int    min=10    max=1000
    ${DESCRICAO}       FakerLibrary.Sentence
    ${QTD}             FakerLibrary.Random Int    min=1     max=100
    Cadastrar Produto No ServeRest    ${PRODUTO}    ${PRECO}    ${DESCRICAO}    ${QTD}    ${TOKEN}

CT16 - Editar um Produto Existente
    [Documentation]    Valida a atualização de dados de um produto via PUT.
    [Tags]             CT16
    # 1. Preparação do Terreno
    ${EMAIL}           FakerLibrary.Email
    Criar Usuario No ServeRest    Admin QA    ${EMAIL}    senha123    true
    ${TOKEN}           Realizar Login    ${EMAIL}    senha123
    
    ${NOME_ORIGINAL}   FakerLibrary.Word
    ${ID_PRODUTO}      Cadastrar Produto No ServeRest    ${NOME_ORIGINAL}    150    Descricao Antiga    5    ${TOKEN}

    # 2. Ação e Validação (Risco 3 corrigido: Usando Faker para o nome editado)
    ${NOME_EDITADO}    FakerLibrary.Word
    ${NOVA_DESCRICAO}  Set Variable    Descricao Atualizada pelo QA
    Editar Produto No ServeRest    ${ID_PRODUTO}    ${NOME_EDITADO}    500    ${NOVA_DESCRICAO}    10    ${TOKEN}