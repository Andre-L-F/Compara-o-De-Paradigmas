using SistemaEstoque;

Estoque estoque = new();
ExecutarSistema(estoque);

static void ExecutarSistema(Estoque estoque)
{
    int opcao;

    do
    {
        Console.Clear();
        ExibirMenu();
        opcao = LerInteiro("Escolha uma opção: ");

        Console.Clear();

        switch (opcao)
        {
            case 1:
                CadastrarProduto(estoque);
                break;
            case 2:
                ConsultarProduto(estoque);
                break;
            case 3:
                AlterarProduto(estoque);
                break;
            case 4:
                RegistrarEntrada(estoque);
                break;
            case 5:
                RegistrarSaida(estoque);
                break;
            case 6:
                ConsultarQuantidade(estoque);
                break;
            case 7:
                ListarProdutos(estoque);
                break;
            case 0:
                Console.WriteLine("Sistema encerrado.");
                break;
            default:
                Console.WriteLine("Opção inválida.");
                break;
        }

        if (opcao != 0)
            Pausar();

    } while (opcao != 0);
}

static void ExibirMenu()
{
    Console.WriteLine("============================================");
    Console.WriteLine("       SISTEMA DE GERENCIAMENTO DE ESTOQUE");
    Console.WriteLine("============================================");
    Console.WriteLine("1 - Cadastrar produto");
    Console.WriteLine("2 - Consultar produto");
    Console.WriteLine("3 - Alterar produto");
    Console.WriteLine("4 - Registrar entrada");
    Console.WriteLine("5 - Registrar saída");
    Console.WriteLine("6 - Consultar quantidade disponível");
    Console.WriteLine("7 - Listar produtos");
    Console.WriteLine("0 - Sair");
    Console.WriteLine("============================================");
}

static void CadastrarProduto(Estoque estoque)
{
    Console.WriteLine("=== CADASTRO DE PRODUTO ===");

    int codigo = LerInteiroPositivo("Código: ");
    string nome = LerTexto("Nome: ");
    int quantidade = LerInteiroNaoNegativo("Quantidade inicial: ");

    bool cadastrado = estoque.CadastrarProduto(codigo, nome, quantidade);

    Console.WriteLine(cadastrado
        ? "Produto cadastrado com sucesso."
        : "Não foi possível cadastrar o produto. Verifique se o código já existe e se os dados são válidos.");
}

static void ConsultarProduto(Estoque estoque)
{
    Console.WriteLine("=== CONSULTA DE PRODUTO ===");

    int codigo = LerInteiroPositivo("Código: ");
    Produto? produto = estoque.ConsultarProduto(codigo);

    if (produto == null)
    {
        Console.WriteLine("Produto não encontrado.");
        return;
    }

    Console.WriteLine($"Código: {produto.Codigo}");
    Console.WriteLine($"Nome: {produto.Nome}");
    Console.WriteLine($"Quantidade disponível: {produto.Quantidade}");
}

static void AlterarProduto(Estoque estoque)
{
    Console.WriteLine("=== ALTERAÇÃO DE PRODUTO ===");

    int codigo = LerInteiroPositivo("Código: ");
    string novoNome = LerTexto("Novo nome: ");

    bool alterado = estoque.AlterarProduto(codigo, novoNome);

    Console.WriteLine(alterado
        ? "Produto alterado com sucesso."
        : "Não foi possível alterar o produto. Verifique o código e o nome informado.");
}

static void RegistrarEntrada(Estoque estoque)
{
    Console.WriteLine("=== REGISTRO DE ENTRADA ===");

    int codigo = LerInteiroPositivo("Código do produto: ");
    int quantidade = LerInteiroPositivo("Quantidade de entrada: ");

    bool registrada = estoque.RegistrarEntrada(codigo, quantidade);

    Console.WriteLine(registrada
        ? "Entrada registrada com sucesso."
        : "Não foi possível registrar a entrada. Verifique o código e a quantidade informada.");
}

static void RegistrarSaida(Estoque estoque)
{
    Console.WriteLine("=== REGISTRO DE SAÍDA ===");

    int codigo = LerInteiroPositivo("Código do produto: ");
    int quantidade = LerInteiroPositivo("Quantidade de saída: ");

    bool registrada = estoque.RegistrarSaida(codigo, quantidade);

    Console.WriteLine(registrada
        ? "Saída registrada com sucesso."
        : "Não foi possível registrar a saída. Verifique se o produto existe e se há estoque suficiente.");
}

static void ConsultarQuantidade(Estoque estoque)
{
    Console.WriteLine("=== QUANTIDADE DISPONÍVEL ===");

    int codigo = LerInteiroPositivo("Código do produto: ");
    int? quantidade = estoque.ConsultarQuantidade(codigo);

    if (quantidade == null)
    {
        Console.WriteLine("Produto não encontrado.");
        return;
    }

    Console.WriteLine($"Quantidade disponível: {quantidade}");
}

static void ListarProdutos(Estoque estoque)
{
    Console.WriteLine("=== PRODUTOS CADASTRADOS ===");

    IReadOnlyList<Produto> produtos = estoque.ListarProdutos();

    if (produtos.Count == 0)
    {
        Console.WriteLine("Nenhum produto cadastrado.");
        return;
    }

    foreach (Produto produto in produtos)
    {
        Console.WriteLine($"Código: {produto.Codigo} | Nome: {produto.Nome} | Quantidade: {produto.Quantidade}");
    }
}

static int LerInteiro(string mensagem)
{
    while (true)
    {
        Console.Write(mensagem);
        string? entrada = Console.ReadLine();

        if (int.TryParse(entrada, out int valor))
            return valor;

        Console.WriteLine("Digite um número inteiro válido.");
    }
}

static int LerInteiroPositivo(string mensagem)
{
    while (true)
    {
        int valor = LerInteiro(mensagem);

        if (valor > 0)
            return valor;

        Console.WriteLine("O valor deve ser maior que zero.");
    }
}

static int LerInteiroNaoNegativo(string mensagem)
{
    while (true)
    {
        int valor = LerInteiro(mensagem);

        if (valor >= 0)
            return valor;

        Console.WriteLine("O valor não pode ser negativo.");
    }
}

static string LerTexto(string mensagem)
{
    while (true)
    {
        Console.Write(mensagem);
        string? entrada = Console.ReadLine();

        if (!string.IsNullOrWhiteSpace(entrada))
            return entrada.Trim();

        Console.WriteLine("Este campo não pode ficar vazio.");
    }
}

static void Pausar()
{
    Console.WriteLine();
    Console.WriteLine("Pressione ENTER para continuar...");
    Console.ReadLine();
}
