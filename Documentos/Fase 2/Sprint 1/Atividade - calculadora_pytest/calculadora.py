class Calculadora:
    def soma(self, a, b):
        return a + b

    def subtracao(self, a, b):
        return a - b

    def multiplicacao(self, a, b):
        return a * b

    def divisao(self, a, b):
        if b == 0:
            raise ValueError("Não é possível dividir por zero")
        return a / b

    def potenciacao(self, base, expoente):
        return base ** expoente

    def porcentagem(self, valor, percentual):
        return valor * (percentual / 100)