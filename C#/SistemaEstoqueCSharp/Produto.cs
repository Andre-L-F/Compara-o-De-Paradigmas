namespace SistemaEstoque;

public class Produto
{
    public int Codigo { get; private set; }
    public string Nome { get; private set; }
    public int Quantidade { get; private set; }

    public Produto(int codigo, string nome, int quantidade)
    {
        if (codigo <= 0)
            throw new ArgumentOutOfRangeException(nameof(codigo), "O código deve ser maior que zero.");

        if (string.IsNullOrWhiteSpace(nome))
            throw new ArgumentException("O nome do produto não pode ficar vazio.", nameof(nome));

        if (quantidade < 0)
            throw new ArgumentOutOfRangeException(nameof(quantidade), "A quantidade inicial não pode ser negativa.");

        Codigo = codigo;
        Nome = nome.Trim();
        Quantidade = quantidade;
    }

    public void AlterarNome(string novoNome)
    {
        if (string.IsNullOrWhiteSpace(novoNome))
            throw new ArgumentException("O nome do produto não pode ficar vazio.", nameof(novoNome));

        Nome = novoNome.Trim();
    }

    public bool AdicionarEstoque(int quantidade)
    {
        if (quantidade <= 0)
            return false;

        Quantidade += quantidade;
        return true;
    }

    public bool RemoverEstoque(int quantidade)
    {
        if (quantidade <= 0 || quantidade > Quantidade)
            return false;

        Quantidade -= quantidade;
        return true;
    }
}
