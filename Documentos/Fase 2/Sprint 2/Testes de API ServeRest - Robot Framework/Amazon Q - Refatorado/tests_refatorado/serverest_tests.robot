*** Settings ***
Documentation    Suite de testes da API ServeRest baseada no roteiro Tour do Supermercado.
...              Autor: Gustavo Santos Queiroz
...
...              REFATORAÇÃO — principais mudanças em relação ao original:
...              - Suite Setup centraliza criação de usuário, login e produto (Preparar Suite)
...              - Test cases são independentes entre si: nenhum CT depende de outro para rodar
...              - Teardown condicional: não quebra se um CT falhou antes de criar o recurso
...              - Dados de teste extraídos para variables.resource (sem hardcode em keywords)
...              - Dead code removido (TOKEN_AUTH, ${headers} duplicado em CT06 original)
...              - Validações de contrato e login mais robustas
Resource         ../resources_refatorado/keywords.resource
Suite Setup      Preparar Suite
Suite Teardown   Limpar Dados da Sessao

*** Test Cases ***
CT01: Fluxo de Carrinho (Positivo)
    [Documentation]    Adiciona produto ao carrinho e conclui a compra.
    ...                Pré-condição coberta pelo Suite Setup: usuário autenticado + produto cadastrado.
    [Tags]    funcional    positivo
    Adicionar ao Carrinho e Concluir Compra

CT02: Login com Senha Invalida (Negativo)
    [Documentation]    Garante que credenciais inválidas retornam 401 com mensagem correta.
    [Tags]    seguranca    negativo
    Tentativa de Login com Senha Invalida

CT03: Cadastrar Produto com Preco Negativo (Negativo)
    [Documentation]    Garante que a API rejeita preços negativos com status 400.
    [Tags]    regra_negocio    negativo
    Cadastrar Produto com Preco Negativo

CT04: Validar Contrato de Lista de Usuários
    [Documentation]    Valida que o endpoint GET /usuarios retorna os campos obrigatórios do contrato.
    [Tags]    contrato
    Validar Contrato Basico de Usuarios

################### BUGS ###################

CT05: Validar Cadastro de Produto com Preco Decimal
    [Documentation]    BUG: A API rejeita preços decimais (ex: 19000.99) com erro 400,
    ...                mas o comportamento esperado é aceitar valores do tipo float.
    [Tags]    bug    produto
    Validar Aceitacao de Preco Decimal

CT06: Validar Rejeicao de Cadastro com Email Invalido
    [Documentation]    BUG: A API aceita emails com caracteres inválidos (ex: #email🚀@qa.com)
    ...                retornando 201, mas o comportamento esperado é rejeitar com 400.
    [Tags]    bug    usuario
    Validar Rejeicao de Email Invalido
