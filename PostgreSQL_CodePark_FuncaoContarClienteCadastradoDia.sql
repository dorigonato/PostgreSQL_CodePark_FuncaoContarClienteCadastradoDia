CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    produto VARCHAR(100),
    quantidade INT,
    valor_unitario NUMERIC(10, 2),
    data_compra DATE
);

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome_completo VARCHAR(100),
    endereco VARCHAR(200),
    email VARCHAR(100),
    telefone VARCHAR(20),
    genero VARCHAR(10)
);


INSERT INTO vendas (produto, quantidade, valor_unitario, data_compra) VALUES
('Camisa', 3, 25.00, '2023-11-01'),
('Calça', 2, 35.00, '2023-11-02'),
('Sapato', 1, 50.00, '2023-11-02'),
('Bolsa', 4, 40.00, '2023-11-03'),
('Boné', 5, 15.00, '2023-11-03'),
('Jaqueta', 1, 75.00, '2023-11-06'),
('Gravata', 3, 20.00, '2023-11-07'),
('Relógio', 1, 90.00, '2023-11-08'),
('Óculos', 2, 70.00, '2023-11-08'),
('Blusa', 4, 28.00, '2023-11-09'),
('Meia', 5, 8.00, '2023-11-10'),
('Brinco', 2, 12.00, '2023-11-10');


INSERT INTO clientes (nome_completo, endereco, email, telefone, genero) VALUES
('Ana Silva', 'Rua A, 123', 'ana@email.com', '(11) 1234-5678', 'Feminino'),
('João Santos', 'Av. Principal, 456', 'joao@email.com', '(22) 9876-5432', 'Masculino'),
('Maria Oliveira', 'Rua B, 789', 'maria@email.com', '(33) 2468-1357', 'Feminino'),
('Pedro Almeida', 'Travessa C, 321', 'pedro@email.com', '(44) 5555-9999', 'Masculino'),
('Lúcia Souza', 'Av. Secundária, 654', 'lucia@email.com', '(55) 7777-2222', 'Feminino');

ALTER TABLE clientes
ADD COLUMN data_cadastro DATE;

select * from clientes;
UPDATE clientes SET data_cadastro = '2023-01-01' WHERE id = 1;
UPDATE clientes SET data_cadastro = '2023-01-02' WHERE id = 2;
UPDATE clientes SET data_cadastro = '2023-01-02' WHERE id = 3;
UPDATE clientes SET data_cadastro = '2023-01-02' WHERE id = 4;
UPDATE clientes SET data_cadastro = '2023-01-03' WHERE id = 5;



--CRIANDO A FUNÇÃO PARA CALCULAR O NÚMERO DE VENDAS NO DIA--

CREATE OR REPLACE FUNCTION contar_clientes_cadastrados(data_consulta DATE)
RETURNS INT 
LANGUAGE plpgsql
AS $$
DECLARE
	total_clientes INT;

BEGIN
    total_clientes = (SELECT COUNT(*) 
                      FROM vendas 
                      WHERE data_compra = data_consulta);

    RETURN total_clientes;
    
END $$;

select contar_clientes_cadastrados(data_consulta :='2023-11-08');


--CRIANDO A FUNÇÃO PARA CALCULAR O NÚMERO DE CLIENTES CADATRADOS NO DIA--

CREATE OR REPLACE FUNCTION clientes_cadastrados_dia(cadastro_diario DATE)
RETURNS INT 
LANGUAGE plpgsql
AS $$
DECLARE
	cadastrado_diario INT;


BEGIN

	cadastrado_diario = (SELECT COUNT(*) from clientes WHERE cadastro_diario = data_cadastro);

RETURN cadastrado_diario;
end; $$

--entre com a data e execute a linha, listará o total de clientes cadastrado no dia
select clientes_cadastrados_dia('2023-01-02');

