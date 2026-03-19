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

CT05: Login com Senha Invalida
    [Tags]    seguranca    negativo
    Tentativa de Login com Senha Invalida

CT06: Cadastrar Produto com Preco Negativo
    [Tags]    regra_negocio    negativo
    Cadastrar Produto com Preco Negativo

CT07: Validar Contrato de Lista de Usuários
    [Tags]    contrato
    Validar Contrato Basico de Usuarios