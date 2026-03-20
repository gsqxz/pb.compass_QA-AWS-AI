*** Settings ***
Documentation    Suite de testes da API ServeRest baseada no roteiro Tour do Supermercado.
...              Autor: Gustavo Santos Queiroz
Resource         ../resources/keywords.resource
Suite Setup      Criar Sessao ServeRest
Suite Teardown   Limpar Dados da Sessao

*** Test Cases ***
CT01: Cadastrar Usuário Administrador (Positivo)
    [Tags]    funcional    positivo
    Gerar Dados Dinamicos
    Cadastrar Usuario Administrador

CT02: Realizar Login e Obter Token (Positivo)
    [Tags]    funcional    positivo
    Realizar Login e Salvar Token

CT03: Cadastrar Produto no Estoque (Positivo)
    [Tags]    funcional    positivo
    Cadastrar Produto no Estoque

CT04: Fluxo de Carrinho (Positivo)
    [Tags]    funcional    positivo
    Adicionar ao Carrinho e Concluir Compra

CT05: Login com Senha Invalida (Negativo)
    [Tags]    seguranca    negativo
    Tentativa de Login com Senha Invalida

CT06: Cadastrar Produto com Preco Negativo (Negativo)
    [Tags]    regra_negocio    negativo
    Cadastrar Produto com Preco Negativo

CT07: Validar Contrato de Lista de Usuários (Validação de Contrato)
    [Tags]    contrato
    Validar Contrato Basico de Usuarios

################### BUGS ###################

CT08: Validar Cadastro de Produto com Preco Decimal
    [Documentation]    O comportamento esperado é aceitar valores decimais para o preço.
    [Tags]    bug    produto
    Validar Aceitacao de Preco Decimal

CT09: Validar Rejeicao de Cadastro com Email Invalido
    [Documentation]    O comportamento esperado é rejeitar emails com caracteres inválidos.
    [Tags]    bug    usuario
    Validar Rejeicao de Email Invalido