unit Estoque;

interface

uses
    Tipos;

procedure CadastrarProduto(var produtos: VetorProdutos; var totalProdutos: Integer);
procedure ConsultarProdutos(produtos: VetorProdutos; totalProdutos: Integer);
procedure ConsultarProduto(produtos: VetorProdutos; totalProdutos: Integer);
procedure AlterarProduto(var produtos: VetorProdutos; totalProdutos: Integer);
procedure RegistrarEntrada(var produtos: VetorProdutos; totalProdutos: Integer);
procedure RegistrarSaida(var produtos: VetorProdutos; totalProdutos: Integer);
procedure ConsultarQuantidade(produtos: VetorProdutos; totalProdutos: Integer);

implementation


function BuscarProduto(produtos: VetorProdutos;
                       totalProdutos: Integer;
                       codigo: Integer): Integer;
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


procedure CadastrarProduto(var produtos: VetorProdutos;
                           var totalProdutos: Integer);
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

    if BuscarProduto(produtos, totalProdutos, codigo) <> 0 then
    begin
        Writeln('Erro: codigo ja cadastrado.');
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


procedure ConsultarProdutos(produtos: VetorProdutos;
                            totalProdutos: Integer);
var
    i: Integer;
begin
    if totalProdutos = 0 then
    begin
        Writeln('Nenhum produto cadastrado.');
        Exit;
    end;

    Writeln('===== PRODUTOS CADASTRADOS =====');

    for i := 1 to totalProdutos do
    begin
        Writeln('Codigo: ', produtos[i].Codigo);
        Writeln('Nome: ', produtos[i].Nome);
        Writeln('Quantidade: ', produtos[i].Quantidade);
        Writeln('-------------------------------');
    end;
end;


procedure ConsultarProduto(produtos: VetorProdutos;
                           totalProdutos: Integer);
var
    codigo: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(produtos, totalProdutos, codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Writeln('Codigo: ', produtos[indice].Codigo);
    Writeln('Nome: ', produtos[indice].Nome);
    Writeln('Quantidade: ', produtos[indice].Quantidade);
end;


procedure AlterarProduto(var produtos: VetorProdutos;
                         totalProdutos: Integer);
var
    codigo: Integer;
    indice: Integer;
    novoNome: String;
    novaQuantidade: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(produtos, totalProdutos, codigo);

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
        Writeln('Erro: quantidade invalida.');
        Exit;
    end;

    produtos[indice].Nome := novoNome;
    produtos[indice].Quantidade := novaQuantidade;

    Writeln('Produto alterado com sucesso.');
end;


procedure RegistrarEntrada(var produtos: VetorProdutos;
                           totalProdutos: Integer);
var
    codigo: Integer;
    quantidade: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(produtos, totalProdutos, codigo);

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
end;


procedure RegistrarSaida(var produtos: VetorProdutos;
                         totalProdutos: Integer);
var
    codigo: Integer;
    quantidade: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(produtos, totalProdutos, codigo);

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
        Writeln('Erro: estoque insuficiente.');
        Exit;
    end;

    produtos[indice].Quantidade :=
        produtos[indice].Quantidade - quantidade;

    Writeln('Saida registrada com sucesso.');
end;


procedure ConsultarQuantidade(produtos: VetorProdutos;
                              totalProdutos: Integer);
var
    codigo: Integer;
    indice: Integer;
begin
    Write('Digite o codigo do produto: ');
    Readln(codigo);

    indice := BuscarProduto(produtos, totalProdutos, codigo);

    if indice = 0 then
    begin
        Writeln('Produto nao encontrado.');
        Exit;
    end;

    Writeln('Produto: ', produtos[indice].Nome);
    Writeln('Quantidade disponivel: ',
            produtos[indice].Quantidade);
end;


end.
