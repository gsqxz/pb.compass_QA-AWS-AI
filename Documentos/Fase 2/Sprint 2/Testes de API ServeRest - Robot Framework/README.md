# Testes de API ServeRest com Robot Framework

Este repositório contém testes automatizados de API do projeto ServeRest, utilizando o Robot Framework como ferramenta principal de automação.

---

## Objetivo do projeto

O objetivo deste projeto é validar os endpoints da API ServeRest, garantindo que as funcionalidades estejam de acordo com os requisitos esperados, por meio de testes automatizados, confiáveis e reutilizáveis.

---

## Como instalar dependências

### Pré-requisitos

- Python (versão 3.8 ou superior)
- Pip (gerenciador de pacotes do Python)

### Instalação

1. Clone este repositório:

        git clone https://github.com/seu-usuario/seu-repositorio.git

2. Acesse o diretório do projeto:

        cd seu-repositorio

3. Instale as dependências:

        pip install -r requirements.txt

---

## Como executar os testes

Para executar todos os testes automatizados:

    robot -d results tests/

### Executar testes específicos

    robot tests/nome_do_arquivo.robot

---

## Como visualizar evidências

Após a execução dos testes, o Robot Framework gera automaticamente relatórios e logs.

Os arquivos de evidência ficam localizados no diretório:

    results/

Principais arquivos:
- report.html → Relatório resumido dos testes
- log.html → Log detalhado da execução
- output.xml → Arquivo XML com os resultados

Basta abrir os arquivos report.html ou log.html em um navegador para visualizar as evidências.
