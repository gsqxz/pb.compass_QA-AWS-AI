## Prompt 01: Revisão Geral do Plano e 5 Cenários de Erro
* **Objetivo do prompt:** Padronizar e refinar a escrita de todos os casos de teste já existentes no documento base, além de gerar 5 novos cenários estritamente negativos (focados em validações de erro, limites e exceções) para expandir a cobertura.
* **Contexto fornecido:** PDF completo do plano de testes atual (proveniente do Challenge 02) e instrução para a IA atuar sob a persona de um Engenheiro de QA Sênior mentorando um iniciante.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor. Sou iniciante na área e estou enviando em anexo o meu plano de testes atual da API ServeRest.

Objetivo: Padronizar e melhorar a escrita de todos os testes do meu plano atual e descobrir novos cenários de erro.

Tarefa 1: Revisão Geral. Leia todos os casos de teste que eu já criei no documento anexo, não importa o endpoint. Reescreva-os para que fiquem mais claros, profissionais e fáceis de entender. Todo caso de teste revisado deve ter obrigatoriamente:

Pré-condições (o que preciso fazer antes).

Massa de dados (exemplos práticos de dados para eu usar).

Passo a passo simples.

Resultado Esperado (qual Status Code do HTTP deve retornar e como deve ser a estrutura da resposta da API).

Tarefa 2: Novos Cenários Negativos. Crie exatamente 5 novos casos de teste de erro (cenários negativos) que eu acabei esquecendo de mapear no documento. Pense em coisas como dados em branco, formatos inválidos ou duplicidades.

Para cada um desses 5 novos testes, adicione uma frase explicando por que testar esse erro é importante na visão de um QA.

Regra importante: Baseie-se apenas no que a API ServeRest realmente aceita. Não invente campos ou regras de negócio que não existem na documentação oficial dela.
```

* **Resposta da IA:** A IA reescreveu os 10 testes originais adicionando pré-condições e oráculos claros, e criou 5 cenários negativos como envio de e-mail duplicado e payload incompleto, adicionando uma seção de 'Visão de QA' para me explicar a importância dos testes de erro.
* **Ajuste/Validação manual:** Validei a refinação do meu plano original, buscando por inconsistências, assim como analisei as massas de dados gerada para os novos testes.
* **Critérios de validação usados:** Checagem cruzada com a documentação oficial do ServeRest para garantir que os HTTP Status Codes de erro estejam de acordo.


## Prompt 02: Regras de Negócio e 5 Cenários Positivos
* **Objetivo do prompt:** Identificar e extrair 3 regras de negócio fundamentais da API direto da documentação e gerar 5 novos cenários de teste positivos (caminho feliz) que comprovassem o funcionamento exato dessas regras.
* **Contexto fornecido:** Histórico da conversa em andamento (mantendo a persona do QA Sênior) e o conhecimento base da IA sobre as regras e fluxos de permissão do ecossistema ServeRest.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor.
Objetivo: Entender as regras de negócio da API ServeRest e aumentar a cobertura com novos cenários positivos.

Tarefa 1: Explicando as Regras. Com base no comportamento padrão do ServeRest, identifique e me explique de forma muito simples (para um iniciante) 3 regras de negócio cruciais do sistema. Por exemplo: "Apenas usuários marcados como administradores têm permissão para cadastrar um novo produto".

Tarefa 2: Novos Cenários Positivos. Usando as regras que você acabou de me explicar, crie exatamente 5 novos casos de teste positivos (caminho feliz) que ainda não existem no meu plano original. Quero que esses testes comprovem que o sistema está respeitando as regras de negócio corretamente.

Estruture esses 5 novos casos obrigatoriamente com:

Pré-condições.

Massa de dados (exemplos práticos).

Passo a passo simples.

Resultado Esperado (Status Code HTTP de sucesso, como 200 ou 201, e o que deve vir no corpo da resposta).

Regra importante: Foque em fluxos que realmente testem o funcionamento correto do sistema e siga estritamente as regras reais do ServeRest.
```

* **Resposta da IA:** A IA me explicou as três regras de negócio principais que ditam o comportamento da API, que foram documentadas no plano. Os novos casos de teste positivos foram criados.
* **Ajuste/Validação manual:** A IA não iterou o ID dos novos casos de teste aos que já tinham sido gerados anteriormente, corrigi manualmente para manter a sequência e inseri uma nova instrução no próximo prompt para que ele não repetisse e me confundisse nos próximos casos de teste. Validei a consistência dos novos casos gerados.
* **Critérios de validação usados:** Análise lógica das regras de negócio apresentadas. Revisão estrutural para garantir a presença obrigatória de massa de dados e oráculo.


## Prompt 03: Entendendo e Criando Testes de Contrato
* **Objetivo do prompt:** Obter uma explicação didática sobre o conceito de testes de contrato e gerar 3 cenários específicos para validar a estrutura (schema), obrigatoriedade de campos e os tipos de dados dos retornos JSON.
* **Contexto fornecido:** Histórico consolidado dos testes funcionais anteriores e dos casos de testes já gerados para continuação.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor.

Objetivo: Entender como funcionam os Testes de Contrato na API ServeRest e aumentar minha cobertura com novos casos.

Tarefa 1: O que é Teste de Contrato? Me explique de forma muito simples e com uma analogia do dia a dia (já que sou iniciante) o que é um teste de contrato em APIs e por que ele é diferente de um teste funcional (positivo/negativo).

Tarefa 2: Novos Casos de Contrato. Crie exatamente 3 novos casos de teste focados exclusivamente em contrato (validando obrigatoriedade de campos, tipos de dados como integer/string e estrutura do JSON). Escolha os endpoints que achar mais críticos no ServeRest.

Estruture esses 3 novos casos obrigatoriamente com:

ID do Teste (continue a numeração sequencial exata a partir do último caso gerado anteriormente).

Pré-condições.

Massa de dados.

Passo a passo simples.

Resultado Esperado (Status Code HTTP e a validação detalhada do schema/estrutura da resposta).

Regra importante: Baseie-se no JSON Schema real e documentado da API ServeRest.
```

* **Resposta da IA:** A IA explicou a diferença entre testes de contrato e funcionais utilizando uma analogia com um pedido de pizzaria: enquanto o Teste Funcional valida se o conteúdo está correto (o sabor da pizza), o Teste de Contrato valida se a estrutura da entrega segue o padrão combinado (se a caixa existe, se o preço é um número e se os campos obrigatórios estão presentes). A IA destacou que o teste de contrato é vital para evitar que mudanças estruturais no Back-end quebrem a comunicação com o Front-end, prevenindo falhas críticas no sistema. Além disso, gerou 3 casos de teste focados em validar tipos de dados e campos obrigatórios da API ServeRest, mantendo a numeração sequencial dos IDs.
* **Ajuste/Validação manual:** Confirmei se os campos citados nos novos casos (ex: preço, quantidade) realmente existem no contrato da documentação.
* **Critérios de validação usados:** Comparação dos tipos de dados (ex: string, integer, boolean) e das chaves obrigatórias geradas pela IA diretamente com os JSON Schemas documentados no Swagger do ServeRest. Verificação da continuidade da numeração sequencial dos IDs de casos de testes.

## Prompt 04: Estrutura do Projeto Robot Framework e Código Base
* **Objetivo do prompt:** Estabelecer a arquitetura inicial do projeto de automação no Robot Framework, garantindo a separação correta de responsabilidades (pastas de recursos, variáveis e testes) e gerar o código de setup de conexão com a API.
* **Contexto fornecido:** Histórico completo dos testes anteriores, mantendo a persona de QA Sênior, e o conhecimento da IA sobre as melhores práticas de organização de projetos de automação. Fornecido o arquivo swagger.json da API para garantir a fidelidade técnica e mitigar alucinações da IA quanto aos endpoints e contratos.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor.

Estou enviando em anexo o arquivo swagger.json da API ServeRest para que você o utilize como a única fonte de verdade técnica. Use-o para garantir que todos os nomes de campos, tipos de dados e Status Codes na automação estejam 100% corretos conforme a documentação oficial.

Objetivo: Iniciar a automação dos testes da API ServeRest usando Robot Framework, garantindo uma estrutura de projeto organizada, escalável e de fácil manutenção.

Tarefa 1: Arquitetura do Projeto. Como sou iniciante na automação, me explique de forma clara qual é a melhor estrutura de pastas e arquivos para um projeto de testes de API com Robot Framework. Aborde obrigatoriamente como devo separar e organizar: resources (keywords), tests, variables e dados.

Tarefa 2: Código Base (Setup). Gere o código inicial do nosso arquivo de configuração (ex: base.robot ou setup.resource). Este código deve conter:

A importação correta da biblioteca RequestsLibrary.

A declaração da variável com a URL base da API ServeRest (https://serverest.dev/).

A criação de uma Keyword reutilizável para inicializar a Sessão da API (ex: Criar Sessao ServeRest).

Regra importante: Siga estritamente as boas práticas de mercado para Robot Framework, evitando hardcodes e focando na reutilização de código.
```

* **Resposta da IA:** A IA explicou a estrutura ideal de um projeto Robot Framework, sugerindo uma organização clara com pastas separadas para testes, recursos (keywords), variáveis e dados. Ela também gerou um código base para o arquivo de configuração, incluindo a importação da RequestsLibrary, a declaração da variável para a URL base da API ServeRest e a criação de uma keyword reutilizável para inicializar a sessão da API.
* **Ajuste/Validação manual:** Verifiquei se o código gerado segue as melhores práticas de Robot Framework, como a utilização de variáveis para evitar hardcodes e a criação de keywords reutilizáveis.
* **Critérios de validação usados:** Análise da estrutura proposta para garantir que ela seja lógica e escalável. Revisão do código base para confirmar a correta importação da biblioteca, a definição da variável de URL e a criação da keyword conforme as boas práticas.

## Prompt 05: Automação de 4 Cenários Positivos (Robot Framework)
* **Objetivo do prompt:** Gerar a automação em Robot Framework de 4 cenários positivos, garantindo rastreabilidade com o plano manual, uso de massa de dados dinâmica (FakerLibrary) e asserções consistentes.
* **Contexto fornecido:** Estrutura base do Robot Framework já definida no passo anterior, além do swagger.json para garantir os contratos corretos das requisições e respostas de sucesso.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor.

Objetivo: Automatizar 4 casos de teste positivos (caminho feliz) utilizando Robot Framework, seguindo as melhores práticas do mercado e a documentação do swagger.json que enviei.

Tarefa: Escolha 4 casos de teste positivos que mapeamos anteriormente no nosso plano (ex: Criar Usuário com sucesso, Login com sucesso, etc.) e escreva o código de automação deles para o arquivo de testes (ex: test_usuarios_positivos.robot).

Regras Obrigatórias para o Código:

Rastreabilidade: Cada Test Case deve ter uma tag com o ID do caso de teste manual correspondente (ex: [Tags] CT-POS-01).

Sem Hardcode: Use a biblioteca FakerLibrary ou gere dados dinamicamente nas variáveis locais para criar e-mails e senhas únicas a cada execução. Não chumbe dados diretamente no teste.

Keywords Reutilizáveis: Crie as ações principais dentro da seção *** Keywords *** (ex: Criar Usuario No ServeRest, Realizar Login). O Test Case em si deve ser limpo e apenas chamar as Keywords.

Asserções Fortes: Valide o Status Code correto (ex: 200 ou 201) e valide pelo menos uma informação no corpo da resposta (ex: mensagem == "Cadastro realizado com sucesso").
```

* **Resposta da IA:** A IA gerou o código de automação para os 4 casos de teste positivos escolhidos, seguindo as regras estabelecidas. Cada Test Case inclui uma tag com o ID do caso de teste manual correspondente, utiliza a FakerLibrary para gerar dados dinâmicos e organiza as ações principais em keywords reutilizáveis. As asserções validam tanto o Status Code quanto informações específicas no corpo da resposta.
* **Ajuste/Validação manual:** A IA gerou os casos de teste corretamente, mas cometeu uma inconsistência estrutural ao embutir a seção *** Keywords *** dentro do próprio arquivo de testes (.robot). Ajustei isso manualmente, movendo todas as custom keywords geradas para o nosso arquivo dedicado de recursos (serve_rest_api.resource), mantendo o arquivo de testes limpo e importando o recurso, conforme as boas práticas do Robot Framework. Verifiquei se os IDs dos casos de teste manual estão corretamente referenciados nas tags dos Test Cases.
* **Critérios de validação usados:** Análise do código para garantir a ausência de hardcodes, a presença de keywords reutilizáveis e a consistência das asserções. Verificação da rastreabilidade entre os casos de teste manuais e os Test Cases automatizados por meio das tags.

## Prompt 06: Automação de 4 Cenários Negativos (Robot Framework)
* **Objetivo do prompt:** Automatizar 4 cenários negativos no Robot Framework, validando mensagens de erro e Status Codes, forçando a IA a respeitar a separação arquitetural entre arquivos de Teste e Recursos.
* **Contexto fornecido:** O plano de testes com os cenários negativos já definidos e a correção de arquitetura instruída diretamente no prompt para não repetir o erro de embutir keywords.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor.

Objetivo: Automatizar 4 casos de teste negativos (cenários de erro) utilizando Robot Framework, baseando-se no swagger.json anexado anteriormente.

Tarefa: Escolha 4 casos de teste de erro que já planejamos (ex: tentar logar com senha errada, cadastrar e-mail já existente, enviar payload vazio).

Regras Obrigatórias para o Código:

Separação de Arquivos (Não embute Keywords): Você deve me entregar o código dividido em DOIS blocos distintos. O primeiro bloco deve conter apenas as Keywords e ir para o arquivo resources/base.resource. O segundo bloco deve conter apenas os Casos de Teste e ir para o arquivo tests/test_negativos.robot. Nunca coloque a seção *** Keywords *** dentro do arquivo de testes.

Rastreabilidade: Cada Test Case deve ter a tag com o ID do plano manual (ex: [Tags] CT-NEG-01).

Asserções de Erro: As validações (asserts) devem ser focadas em Status Codes de erro (ex: 400, 401) e devem validar se a mensagem de erro exata retornada pela API bate com a documentação do Swagger.

Sem Hardcode: Continue usando variáveis e dados dinâmicos para simular as requisições inválidas.
```

* **Resposta da IA:** A IA gerou o código de automação para os 4 casos de teste negativos, seguindo as regras estabelecidas. O código foi dividido corretamente entre o arquivo de recursos (base.resource) e o arquivo de testes (test_negativos.robot). Cada Test Case inclui a tag com o ID do plano manual correspondente, utiliza variáveis para simular dados inválidos e as asserções validam tanto os Status Codes de erro quanto as mensagens de erro específicas conforme a documentação do Swagger.
* **Ajuste/Validação manual:** Verifiquei se as mensagens de erro validadas nas asserções correspondem exatamente às descritas na documentação do Swagger, garantindo a fidelidade técnica dos testes de erro. Confirmei a correta separação entre os arquivos de recursos e testes, mantendo a organização do projeto.
* **Critérios de validação usados:** Análise do código para garantir a correta separação entre arquivos, a presença de tags de rastreabilidade e a consistência das asserções de erro com a documentação oficial. Verificação da ausência de hardcodes e do uso adequado de variáveis para simular dados inválidos.

## Prompt 07: Automação de 2 Cenários de Contrato (Robot Framework)
* **Objetivo do prompt:** Automatizar 2 cenários de teste de contrato, validando a estrutura da resposta JSON e os tipos de dados, utilizando o swagger.json como fonte de verdade.
* **Contexto fornecido:** O plano de testes com os cenários de contrato já definidos e o arquivo swagger.json para garantir a fidelidade técnica dos contratos.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor.

Objetivo: Automatizar 2 testes de contrato da API ServeRest utilizando Robot Framework, garantindo que a estrutura da resposta JSON respeite o swagger.json anexado.

Tarefa: Pegue 2 casos de teste de contrato que estruturamos na fase de planejamento (ex: validar o schema de resposta do endpoint de busca de produtos ou de login) e escreva o código de automação.

Regras Obrigatórias para o Código:

Técnica de Validação de Contrato: O teste não deve validar os valores exatos (ex: não validar se o nome é "Fulano"), mas sim a estrutura. O Robot deve validar se as chaves obrigatórias existem no JSON e usar a keyword Should Be True para verificar se o tipo de dado está correto (ex: validar se o ID é uma string, se o preço é um número/integer).

Separação de Arquivos: Mantenha a regra de ouro. Gere o código dividido em DOIS blocos: as custom keywords vão para resources/base.resource e os casos de teste vão para um novo arquivo chamado tests/test_contrato.robot.

Rastreabilidade: Adicione a tag com o ID do caso de teste manual correspondente (ex: [Tags] CT-CTR-01).
Sem Hardcode: Use o swagger.json como fonte de verdade para os campos e tipos de dados. Não invente campos ou regras que não existem na documentação oficial.
```
* **Resposta da IA:** A IA gerou o código de automação para os 2 casos de teste de contrato, seguindo as regras estabelecidas. O código foi dividido corretamente entre o arquivo de recursos (base.resource) e o novo arquivo de testes (test_contrato.robot). Cada Test Case inclui a tag com o ID do plano manual correspondente, e as asserções validam a estrutura da resposta JSON e os tipos de dados conforme o swagger.json.
* **Ajuste/Validação manual:** Verifiquei se as chaves obrigatórias e os tipos de dados validados nas asserções correspondem exatamente aos descritos na documentação oficial do swagger.json, garantindo a fidelidade técnica dos testes de contrato.
* **Critérios de validação usados:** Verificação do uso correto de técnicas de validação de schema estrutural e não funcional. Execução do teste para garantir que ele passaria independente do dado criado.

## Prompt 08: Quality Gate e Code Review
* **Objetivo do prompt:** Atuar como um Quality Gate automatizado para revisar o código Robot Framework gerado, buscando mitigar alucinações de GenAI (regras e endpoints inventados) e inconsistências (asserções fracas e hardcodes).
* **Contexto fornecido:** Fornecimento do código-fonte completo para avaliação crítica focada na robustez e confiabilidade da suíte e a persona de QA Sênior para uma revisão crítica e didática.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior especializado em Code Review.

Objetivo: Realizar um "Quality Gate" focado em mitigar alucinações e inconsistências no código Robot Framework que geramos até aqui para a API ServeRest.

Tarefa: Em anexo, estão todos os códigos dos nossos arquivos .robot e .resource. Revise este código linha por linha procurando por:

Alucinações de Endpoint ou Payload: Alguma Keyword está tentando acessar uma rota que não existe no Swagger ou enviando um campo inventado?

Inconsistências de Oráculo (Asserts Fracos): Existe algum teste que valida apenas o Status Code, mas esquece de validar o corpo da resposta? Ou valida uma mensagem genérica demais?

Flakiness (Testes Intermitentes): Alguma massa de dados corre o risco de falhar se o teste rodar duas vezes seguidas (ex: tentar cadastrar o mesmo e-mail estático sem usar o Faker)?

Formato de Saída:
Entregue um relatório de revisão (Code Review) em formato de checklist apontando os riscos encontrados. Para cada risco, forneça o trecho de código refatorado com a correção recomendada.

Analise também a estrutura do diretório.
```

* **Resposta da IA:** A IA entregou um relatório de revisão detalhado, identificando riscos de acoplamento e efeito dominó, asserção fraca de contrato e hardcode oculto. O relatório incluiu trechos de código refatorados para cada risco encontrado, além de sugestões para melhorar a estrutura do diretório.
* **Ajuste/Validação manual:** Analisei o relatório de revisão para garantir que as correções propostas pela IA estão alinhadas com as melhores práticas de automação e com a documentação oficial do ServeRest. Implementei as correções sugeridas e validei a execução dos testes para garantir que eles estejam funcionando conforme esperado. Ainda assim, ao finalmente executar os testes pelo terminal do VS Code, todos os testes falharam e fui atrás dos erros. A IA tinha cometido um erro fatal: ela não tinha declarado a Library Collections no arquivo base.resource, o que estava causando os erros e tornando os testes impraticáveis. Corriji a falha.
* **Critérios de validação usados:** Análise de risco de falsos-positivos (testes que passam mas não testam direito) e validação da estabilidade da suíte garantindo que dados dinâmicos foram aplicados corretamente. Execução dos testes.

## Prompt 09: Automação com GitHub Actions
* **Objetivo do prompt:** Obter uma explicação didática sobre o funcionamento do GitHub Actions e solicitar um guia passo a passo para automatizar a execução da suíte do Robot Framework e salvar os relatórios.
* **Contexto fornecido:** Histórico completo dos testes anteriores, a estrutura do projeto já definida e a persona de QA Sênior para uma explicação clara e didática.
* **Prompt final:**

```text
Aja como um Engenheiro de QA Sênior e meu mentor. Sou iniciante e quero aprender a automatizar a execução dos meus testes do Robot Framework pelo GitHub Actions, mas nunca fiz isso antes.

Me explique de forma bem didática como essa ferramenta funciona e me guie com o passo a passo completo: me diga quais pastas e arquivos eu devo criar no meu projeto (como o arquivo de dependências) e me forneça o código exato da automação. A única exigência técnica para o código é que ele deve sempre salvar e me permitir baixar os relatórios log.html e report.html no final da execução, mesmo que algum teste venha a falhar.
```

* **Resposta da IA:** A IA explicou o funcionamento do GitHub Actions utilizando uma analogia com um "robô de cozinha" que executa tarefas automaticamente. Ela forneceu um guia passo a passo para configurar o GitHub Actions, incluindo a criação de um arquivo de workflow (.yml) na pasta .github/workflows, a instalação das dependências necessárias para o Robot Framework e o código exato para automatizar a execução dos testes, garantindo que os relatórios log.html e report.html sejam salvos e disponibilizados para download mesmo em caso de falhas.
* **Ajuste/Validação manual:** Implementei o código fornecido pela IA no meu repositório do GitHub e configurei o workflow conforme as instruções. Executei o workflow para garantir que os testes rodassem corretamente e que os relatórios fossem gerados e disponibilizados para download conforme esperado.
* **Critérios de validação usados:** Verificação da execução bem-sucedida do workflow no GitHub Actions, garantindo que os testes do Robot Framework sejam executados e que os relatórios log.html e report.html sejam gerados e disponibilizados para download, mesmo em caso de falhas nos testes.