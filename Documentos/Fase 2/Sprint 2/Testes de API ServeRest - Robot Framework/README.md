# Testes de API ServeRest com Robot Framework

Este repositório contém testes automatizados de API do projeto ServeRest, utilizando o Robot Framework como ferramenta principal de automação.


## Objetivo do projeto

O objetivo deste projeto é validar os endpoints da API ServeRest, garantindo que as funcionalidades estejam de acordo com os requisitos esperados, por meio de testes automatizados, confiáveis e reutilizáveis.


## Como instalar dependências

### Pré-requisitos

- Python (versão 3.8 ou superior)
- Pip (gerenciador de pacotes do Python)

### Instalação

1. Clone este repositório:

        git clone https://github.com/gsqxz/pb.compass_QA-AWS-AI.git

2. Abra o diretório desse projeto específico em uma IDE, como o VS Code:

        Documentos/Fase 2/Sprint 2/Testes de API ServeRest - Robot Framework

3. Instale as dependências:

        pip install robotframework
    
        pip install robotframework-requests

## Como executar os testes

### Executar todos os testes automatizados:

CASO ESTEJA NO DIRETÓRIO RAIZ DO PROJETO:
    robot -d .\results\ .\tests\serverest_tests.robot
É também possível executar os testes rapidamente, diretamente no código, com a instalação do plugin de Robot Framework para VS Code.

### Executar testes específicos

    robot -d results -i funcional tests/    # Roda apenas os cenários de fluxo do usuário
    robot -d results -i contrato tests/     # Roda apenas a validação de contrato
    robot -d results -i bug tests/          # Roda apenas os testes que reproduzem os bugs encontrados
    robot -d results -e bug tests/          # Roda todos os testes, ignorando os testes de bug

Nota: A suíte possui um Suite Teardown inteligente que limpa automaticamente todos os dados (usuários e produtos) gerados durante os testes, mantendo o banco de dados da API limpo após cada execução.

## Como visualizar evidências

Após a execução dos testes, o Robot Framework gera automaticamente relatórios e logs.

Os arquivos de evidência ficam localizados no diretório gerado automaticamente:

    results/

Principais arquivos:
- report.html → Relatório resumido dos testes
- log.html → Log detalhado da execução
- output.xml → Arquivo XML com os resultados

Para visualizar: Basta abrir o arquivo log.html diretamente em qualquer navegador web.

Aviso: Conforme configurado no .gitignore, apenas o log.html principal é versionado neste repositório.