*** Settings ***
Documentation    Suíte de testes negativos (Cenários de Erro) da API ServeRest.
...              Baseado estritamente nos schemas de erro da documentação swagger.json.
Resource         ../resources/base.resource
Library          FakerLibrary    locale=pt_BR
Test Setup       Criar Sessao ServeRest

*** Test Cases ***

CT05 - Tentativa de Login com Senha Inválida
    [Documentation]    Valida o retorno 401 ao tentar logar com credenciais incorretas.
    [Tags]             CT05
    ${EMAIL}           FakerLibrary.Email
    ${SENHA_ERRADA}    Set Variable    senha_incorreta_123
    ${resposta}        Realizar Login Esperando Falha    ${EMAIL}    ${SENHA_ERRADA}    401
    
    # Asserção baseada no schema 'errorEmailSenhaInvalidos' da documentação
    Dictionary Should Contain Value    ${resposta}    Email e/ou senha inválidos

CT10 - Tentativa de Cadastro de Usuário com E-mail Duplicado
    [Documentation]    Valida o erro 400 ao tentar cadastrar um e-mail que já existe no banco.
    [Tags]             CT10
    ${NOME}            FakerLibrary.Name
    ${EMAIL}           FakerLibrary.Email
    
    # Passo 1: Prepara o terreno cadastrando um usuário válido primeiro
    Criar Usuario No ServeRest    ${NOME}    ${EMAIL}    senha123    true
    
    # Passo 2: Tenta forçar o erro repetindo a massa de dados
    ${resposta}        Cadastrar Usuario Esperando Falha    ${NOME}    ${EMAIL}    senha123    true    400
    
    # Asserção baseada no schema 'errorEmailJaUtilizado' da documentação
    Dictionary Should Contain Value    ${resposta}    Este email já está sendo usado

CT11 - Cadastro de Produto por Usuário Sem Permissão (Não-Admin)
    [Documentation]    Valida o bloqueio de segurança (403) para perfis de clientes comuns.
    [Tags]             CT11
    ${EMAIL}           FakerLibrary.Email
    
    # Passo 1: Cria um usuário comum (administrador = false) e captura seu token
    Criar Usuario No ServeRest    Cliente Comum    ${EMAIL}    senha123    false
    ${TOKEN}           Realizar Login    ${EMAIL}    senha123
    
    # Passo 2: Tenta invadir a rota protegida
    ${NOME_PRODUTO}    FakerLibrary.Word
    ${resposta}        Cadastrar Produto Esperando Falha    ${NOME_PRODUTO}    100    Mouse QA    10    ${TOKEN}    403
    
    # Asserção baseada no schema 'rotaParaAdministradores' da documentação
    Dictionary Should Contain Value    ${resposta}    Rota exclusiva para administradores

CT12 - Cadastro de Produto com Nome Duplicado
    [Documentation]    Valida o erro 400 ao tentar criar um segundo produto com a mesma nomenclatura.
    [Tags]             CT12
    ${EMAIL}           FakerLibrary.Email
    
    # Passo 1: Configura um Admin logado para ter permissão
    Criar Usuario No ServeRest    Admin QA    ${EMAIL}    senha123    true
    ${TOKEN}           Realizar Login    ${EMAIL}    senha123
    
    # Passo 2: Cadastra o primeiro produto com sucesso
    ${NOME_PRODUTO}    FakerLibrary.Word
    Cadastrar Produto No ServeRest    ${NOME_PRODUTO}    150    Descricao Base    10    ${TOKEN}
    
    # Passo 3: Força a duplicidade no nome
    ${resposta}        Cadastrar Produto Esperando Falha    ${NOME_PRODUTO}    200    Outra Descricao    5    ${TOKEN}    400
    
    # Asserção baseada no schema 'existeProdutoComEsseNome' da documentação
    Dictionary Should Contain Value    ${resposta}    Já existe produto com esse nome