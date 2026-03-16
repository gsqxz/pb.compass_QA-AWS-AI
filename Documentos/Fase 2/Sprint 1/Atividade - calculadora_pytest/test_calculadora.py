import pytest
from calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

def test_soma(calc):
    assert calc.soma(3, 3) == 6
    assert calc.soma(-1, 1) == 0

def test_subtracao(calc):
    assert calc.subtracao(10, 5) == 5
    assert calc.subtracao(0, 5) == -5

def test_multiplicacao(calc):
    assert calc.multiplicacao(4, 3) == 12
    assert calc.multiplicacao(5, 0) == 0

def test_divisao(calc):
    assert calc.divisao(50, 2) == 25
    assert calc.divisao(9, 3) == 3

def test_divisao_por_zero(calc):
    with pytest.raises(ValueError, match="Não é possível dividir por zero"):
        calc.divisao(10, 0)

def test_potenciacao(calc):
    assert calc.potenciacao(5, 2) == 25
    assert calc.potenciacao(10, 0) == 1

def test_porcentagem(calc):
    assert calc.porcentagem(200, 15) == 30.0
    assert calc.porcentagem(50, 50) == 25.0