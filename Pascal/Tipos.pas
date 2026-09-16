unit Tipos;

interface

const
    MAX_PRODUTOS = 100;

type
    Produto = record
        Codigo: Integer;
        Nome: String;
        Quantidade: Integer;
    end;

    VetorProdutos = array[1..MAX_PRODUTOS] of Produto;

implementation

end.
