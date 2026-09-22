namespace SistemaEstoque;

public class Estoque
{
    private readonly List<Produto> produtos = new();

    public bool CadastrarProduto(int codigo, string nome, int quantidadeInicial)
    {
        if (ConsultarProduto(codigo) != null)
            return false;

        try
        {
            produtos.Add(new Produto(codigo, nome, quantidadeInicial));
            return true;
        }
        catch (ArgumentException)
        {
            return false;
        }
    }

    public Produto? ConsultarProduto(int codigo)
    {
        return produtos.FirstOrDefault(p => p.Codigo == codigo);
    }

    public bool AlterarProduto(int codigo, string novoNome)
    {
        Produto? produto = ConsultarProduto(codigo);

        if (produto == null)
            return false;

        try
        {
            produto.AlterarNome(novoNome);
            return true;
        }
        catch (ArgumentException)
        {
            return false;
        }
    }

    public bool RegistrarEntrada(int codigo, int quantidade)
    {
        Produto? produto = ConsultarProduto(codigo);

        if (produto == null)
            return false;

        return produto.AdicionarEstoque(quantidade);
    }

    public bool RegistrarSaida(int codigo, int quantidade)
    {
        Produto? produto = ConsultarProduto(codigo);

        if (produto == null)
            return false;

        return produto.RemoverEstoque(quantidade);
    }

    public int? ConsultarQuantidade(int codigo)
    {
        Produto? produto = ConsultarProduto(codigo);
        return produto?.Quantidade;
    }

    public IReadOnlyList<Produto> ListarProdutos()
    {
        return produtos.AsReadOnly();
    }
}
