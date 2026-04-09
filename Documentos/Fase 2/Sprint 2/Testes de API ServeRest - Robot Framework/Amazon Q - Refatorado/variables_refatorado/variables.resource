*** Variables ***
# ── Conexão ──────────────────────────────────────────────────────────────────
${BASE_URL}             https://serverest.dev

# ── Dados do usuário de teste ─────────────────────────────────────────────────
${NOME_USUARIO}         QA Tester
${PASSWORD_TESTE}       teste
${ADMIN_FLAG}           true

# ── Dados do produto de teste ─────────────────────────────────────────────────
${DESCRICAO_PRODUTO}    Mouse Gamer
${QUANTIDADE_PRODUTO}   ${50}
${PRECO_PRODUTO}        ${100}

# ── Estado de suite — inicializados vazios para teardown condicional seguro ───
${EMAIL_TESTE}          ${EMPTY}
${NOME_PRODUTO}         ${EMPTY}
${HEADERS_AUTH}         &{EMPTY}
${ID_PRODUTO}           ${EMPTY}
${ID_USUARIO}           ${EMPTY}
${ID_EMAIL_INVALIDO}    ${EMPTY}
