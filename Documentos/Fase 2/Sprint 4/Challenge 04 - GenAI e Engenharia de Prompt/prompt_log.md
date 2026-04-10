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