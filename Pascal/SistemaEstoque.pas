program SistemaEstoque;

uses
    Tipos,
    Estoque;

var
    produtos: VetorProdutos;
    totalProdutos: Integer;
    opcao: Integer;

procedure ExibirMenu;
begin
    Writeln;
    Writeln('================================');
    Writeln('    SISTEMA DE GERENCIAMENTO');
    Writeln('             ESTOQUE');
    Writeln('================================');
    Writeln('1 - Cadastrar produto');
    Writeln('2 - Consultar produtos');
    Writeln('3 - Consultar produto');
    Writeln('4 - Alterar produto');
    Writeln('5 - Registrar entrada');
    Writeln('6 - Registrar saida');
    Writeln('7 - Consultar quantidade');
    Writeln('0 - Sair');
    Writeln('================================');
    Write('Escolha uma opcao: ');
end;


begin
    totalProdutos := 0;
    opcao := -1;

    while opcao <> 0 do
    begin
        ExibirMenu;
        Readln(opcao);

        case opcao of
            1:
                CadastrarProduto(produtos, totalProdutos);

            2:
                ConsultarProdutos(produtos, totalProdutos);

            3:
                ConsultarProduto(produtos, totalProdutos);

            4:
                AlterarProduto(produtos, totalProdutos);

            5:
                RegistrarEntrada(produtos, totalProdutos);

            6:
                RegistrarSaida(produtos, totalProdutos);

            7:
                ConsultarQuantidade(produtos, totalProdutos);

            0:
                Writeln('Sistema encerrado.');

        else
            Writeln('Opcao invalida.');
        end;

        if opcao <> 0 then
        begin
            Writeln;
            Writeln('Pressione ENTER para continuar...');
            Readln;
        end;
    end;
end.
