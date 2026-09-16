program SistemaEstoque;

const
    MAX_PRODUTOS = 100;

type
    Produto = record
        Codigo: Integer;
        Nome: String;
        Quantidade: Integer;
    end;

var
    produtos: array[1..MAX_PRODUTOS] of Produto;
    totalProdutos: Integer;


function BuscarProduto(codigo: Integer): Integer;
var
    i: Integer;
begin
    BuscarProduto := 0;

    for i := 1 to totalProdutos do
    begin
        if produtos[i].Codigo = codigo then
        begin
            BuscarProduto := i;
            Exit;
        end;
    end;
end;


procedure CadastrarProduto;
var
    codigo: Integer;
    nome: String;
    quantidade: Integer;
begin
    if totalProdutos >= MAX_PRODUTOS then
    begin
        Writeln('Limite de produtos atingido.');
        Exit;
    end;

    Write('Digite o codigo do produto: ');
    Readln(codigo);

    if BuscarProduto(codigo) <> 0 then
    begin
        Writeln('Erro: ja existe um produto com esse codigo.');
        Exit;
    end;

    Write('Digite o nome do produto: ');
    Readln(nome);

    Write('Digite a quantidade inicial: ');
    Readln(quantidade);

    if quantidade < 0 then
    begin
        Writeln('Erro: a quantidade nao pode ser negativa.');
        Exit;
    end;

    totalProdutos := totalProdutos + 1;

    produtos[totalProdutos].Codigo := codigo;
    produtos[totalProdutos].Nome := nome;
    produtos[totalProdutos].Quantidade := quantidade;

    Writeln('Produto cadastrado com sucesso.');
end;


procedure ConsultarProdutos;
var
    i: Integer;
begin
    if totalProdutos = 0 then
    begin
        Writeln('Nenhum produto cadastrado.');
        Exit;
    end;

    Writeln;
    Writeln('===== PRODUTOS CADASTRADOS =====');

    for i := 1 to totalProdutos do
    begin
        Writeln('Codigo: ', produtos[i].Codigo);
        Writeln('Nome: ', produtos[i].Nome);
        Writeln('Quantidade: ', produtos[i].Quantidade);
        Writeln('-------------------------------');
    end;
end;


procedure ConsultarProduto;
var
    codigo: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Writeln;
    Writeln('===== PRODUTO =====');
    Writeln('Codigo: ', produtos[indice].Codigo);
    Writeln('Nome: ', produtos[indice].Nome);
    Writeln('Quantidade disponivel: ', produtos[indice].Quantidade);
end;


procedure AlterarProduto;
var
    codigo: Integer;
    novoNome: String;
    novaQuantidade: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto que deseja alterar: ');
    Readln(codigo);

    indice := BuscarProduto(codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Write('Digite o novo nome: ');
    Readln(novoNome);

    Write('Digite a nova quantidade: ');
    Readln(novaQuantidade);

    if novaQuantidade < 0 then
    begin
        Writeln('Erro: a quantidade nao pode ser negativa.');
        Exit;
    end;

    produtos[indice].Nome := novoNome;
    produtos[indice].Quantidade := novaQuantidade;

    Writeln('Produto alterado com sucesso.');
end;


procedure RegistrarEntrada;
var
    codigo: Integer;
    quantidade: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Write('Digite a quantidade de entrada: ');
    Readln(quantidade);

    if quantidade <= 0 then
    begin
        Writeln('Erro: a quantidade deve ser maior que zero.');
        Exit;
    end;

    produtos[indice].Quantidade :=
        produtos[indice].Quantidade + quantidade;

    Writeln('Entrada registrada com sucesso.');
    Writeln('Quantidade atual em estoque: ',
            produtos[indice].Quantidade);
end;


procedure RegistrarSaida;
var
    codigo: Integer;
    quantidade: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Write('Digite a quantidade de saida: ');
    Readln(quantidade);

    if quantidade <= 0 then
    begin
        Writeln('Erro: a quantidade deve ser maior que zero.');
        Exit;
    end;

    if quantidade > produtos[indice].Quantidade then
    begin
        Writeln('Erro: quantidade insuficiente em estoque.');
        Exit;
    end;

    produtos[indice].Quantidade :=
        produtos[indice].Quantidade - quantidade;

    Writeln('Saida registrada com sucesso.');
    Writeln('Quantidade atual em estoque: ',
            produtos[indice].Quantidade);
end;


procedure ConsultarQuantidade;
var
    codigo: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Writeln('Produto: ', produtos[indice].Nome);
    Writeln('Quantidade disponivel: ',
            produtos[indice].Quantidade);
end;


procedure ExibirMenu;
begin
    Writeln;
    Writeln('====================================');
    Writeln('       SISTEMA DE GERENCIAMENTO');
    Writeln('              DE ESTOQUE');
    Writeln('====================================');
    Writeln('1 - Cadastrar produto');
    Writeln('2 - Consultar produtos');
    Writeln('3 - Consultar produto');
    Writeln('4 - Alterar produto');
    Writeln('5 - Registrar entrada');
    Writeln('6 - Registrar saida');
    Writeln('7 - Consultar quantidade');
    Writeln('0 - Sair');
    Writeln('====================================');
    Write('Escolha uma opcao: ');
end;


var
    opcao: Integer;

begin
    totalProdutos := 0;
    opcao := -1;

    while opcao <> 0 do
    begin
        ExibirMenu;
        Readln(opcao);

        Writeln;

        case opcao of
            1: CadastrarProduto;
            2: ConsultarProdutos;
            3: ConsultarProduto;
            4: AlterarProduto;
            5: RegistrarEntrada;
            6: RegistrarSaida;
            7: ConsultarQuantidade;
            0: Writeln('Sistema encerrado.');
        else
            Writeln('Opcao invalida. Tente novamente.');
        end;

        if opcao <> 0 then
        begin
            Writeln;
            Writeln('Pressione ENTER para continuar...');
            Readln;
        end;
    end;
end.
