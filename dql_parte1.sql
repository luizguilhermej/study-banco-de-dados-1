-- =====================================================================
-- BANCO DE DADOS I - DQL PARTE I
-- Consultas para a base mercado_dql.sql (PostgreSQL)
-- =====================================================================

-- Questão 01
SELECT COUNT(*) AS quantidade_linhas_sem_cliente
FROM fato_vendas
WHERE id_cliente IS NULL;

-- Questão 02
SELECT COUNT(DISTINCT id_cliente) AS clientes_diferentes
FROM fato_vendas;

-- Questão 03
SELECT ROUND(SUM(valor_total), 2) AS faturamento_total_2025
FROM fato_vendas
WHERE data_venda >= DATE '2025-01-01'
  AND data_venda < DATE '2026-01-01';

-- Questão 04
SELECT DISTINCT marca
FROM dim_produto
WHERE categoria = 'Higiene'
ORDER BY marca ASC;

-- Questão 05
SELECT ROUND(AVG(valor_total), 2) AS valor_medio_vendas_aplicativo
FROM fato_vendas
WHERE canal = 'Aplicativo';

-- Questão 06
SELECT COUNT(*) AS produtos_bebidas_acima_de_10
FROM dim_produto
WHERE categoria = 'Bebidas'
  AND preco_tabela > 10.00;

-- Questão 07
SELECT nome_produto, marca, preco_tabela
FROM dim_produto
ORDER BY preco_tabela DESC, nome_produto ASC
LIMIT 1;

-- Questão 08
SELECT categoria, COUNT(*) AS quantidade_produtos
FROM dim_produto
GROUP BY categoria
ORDER BY quantidade_produtos DESC, categoria ASC;

-- Questão 09
SELECT categoria, AVG(preco_tabela) AS preco_medio_tabela
FROM dim_produto
GROUP BY categoria
ORDER BY preco_medio_tabela DESC, categoria ASC;

-- Questão 10
SELECT cidade, COUNT(*) AS quantidade_clientes
FROM dim_cliente
GROUP BY cidade
HAVING COUNT(*) >= 60
ORDER BY quantidade_clientes DESC, cidade ASC;

-- Questão 11
SELECT COUNT(*) AS clientes_sem_email
FROM dim_cliente
WHERE email IS NULL;

-- Questão 12
SELECT COUNT(*) AS clientes_femininas_nascidas_nos_anos_1990
FROM dim_cliente
WHERE sexo = 'F'
  AND data_nascimento BETWEEN DATE '1990-01-01' AND DATE '1999-12-31';

-- Questão 13
SELECT COUNT(*) AS clientes_com_primeiro_nome_ana
FROM dim_cliente
WHERE nome = 'Ana'
   OR nome LIKE 'Ana %';

-- Questão 14
SELECT uf, COUNT(*) AS quantidade_lojas
FROM dim_loja
GROUP BY uf
HAVING COUNT(*) > 3
ORDER BY quantidade_lojas DESC, uf ASC;

-- Questão 15
SELECT nome_loja, cidade, data_inauguracao
FROM dim_loja
WHERE data_inauguracao < DATE '2007-01-01'
ORDER BY data_inauguracao ASC;

-- Questão 16
SELECT canal, ROUND(SUM(valor_total), 2) AS faturamento_2025
FROM fato_vendas
WHERE data_venda >= DATE '2025-01-01'
  AND data_venda < DATE '2026-01-01'
GROUP BY canal
ORDER BY faturamento_2025 DESC, canal ASC;

-- Questão 17
SELECT forma_pagamento,
       COUNT(*) AS quantidade_linhas_venda,
       ROUND(SUM(valor_total), 2) AS faturamento
FROM fato_vendas
WHERE canal = 'Loja física'
GROUP BY forma_pagamento
ORDER BY faturamento DESC, forma_pagamento ASC;

-- Questão 18
SELECT id_produto, SUM(quantidade) AS unidades_vendidas
FROM fato_vendas
GROUP BY id_produto
ORDER BY unidades_vendidas DESC, id_produto ASC
LIMIT 10;

-- Questão 19
SELECT id_loja, ROUND(SUM(valor_total), 2) AS faturamento_2024
FROM fato_vendas
WHERE data_venda >= DATE '2024-01-01'
  AND data_venda < DATE '2025-01-01'
GROUP BY id_loja
ORDER BY faturamento_2024 DESC, id_loja ASC
LIMIT 5;

-- Questão 20
SELECT id_loja, COUNT(*) AS quantidade_linhas_venda
FROM fato_vendas
GROUP BY id_loja
HAVING COUNT(*) > 300
ORDER BY quantidade_linhas_venda DESC, id_loja ASC;

-- Questão 21
SELECT id_cliente, COUNT(*) AS quantidade_linhas_venda
FROM fato_vendas
WHERE id_cliente IS NOT NULL
GROUP BY id_cliente
HAVING COUNT(*) >= 70
ORDER BY quantidade_linhas_venda DESC, id_cliente ASC;

-- Questão 22
SELECT COUNT(*) AS linhas_com_desconto,
       ROUND(AVG(desconto), 2) AS valor_medio_desconto
FROM fato_vendas
WHERE desconto > 0;

-- Questão 23
SELECT MIN(valor_total) AS menor_valor_total,
       MAX(valor_total) AS maior_valor_total
FROM fato_vendas
WHERE data_venda >= DATE '2025-12-01'
  AND data_venda < DATE '2026-01-01';

-- Questão 24
SELECT COUNT(*) AS quantidade_linhas_venda,
       ROUND(SUM(valor_total), 2) AS faturamento
FROM fato_vendas
WHERE data_venda = DATE '2025-12-24';

-- Questão 25
SELECT id_venda,
       ROUND(quantidade * preco_unitario, 2) AS valor_bruto,
       desconto,
       valor_total,
       ROUND(100.0 * desconto / (quantidade * preco_unitario), 2) AS percentual_desconto
FROM fato_vendas
WHERE canal = 'Site'
  AND data_venda >= DATE '2025-01-01'
  AND data_venda < DATE '2026-01-01'
  AND desconto > 0
ORDER BY 100.0 * desconto / (quantidade * preco_unitario) DESC,
         id_venda ASC
LIMIT 10;