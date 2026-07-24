-- Query 1: Faturamento e total de itens vendidos por categoria
SELECT 
    p.categoria,
    SUM(i.quantidade) AS total_itens_vendidos,
    SUM(i.quantidade * i.preco_unitario) AS faturamento_total
FROM produtos p
JOIN itens_pedido i ON p.id_produto = i.id_produto
JOIN pedidos ped ON i.id_pedido = ped.id_pedido
WHERE ped.status = 'Concluído' -- Considera apenas vendas concluídas!
GROUP BY p.categoria
ORDER BY faturamento_total DESC;

-- Query 2: Clientes VIP (Maior valor total gasto)
SELECT 
    c.nome AS cliente,
    c.estado,
    COUNT(DISTINCT ped.id_pedido) AS total_pedidos,
    SUM(i.quantidade * i.preco_unitario) AS valor_total_gasto
FROM clientes c
JOIN pedidos ped ON c.id_cliente = ped.id_cliente
JOIN itens_pedido i ON ped.id_pedido = i.id_pedido
WHERE ped.status = 'Concluído'
GROUP BY c.id_cliente, c.nome, c.estado
ORDER BY valor_total_gasto DESC;

-- Query 3: Ticket médio por pedido
SELECT 
    ROUND(AVG(sub.valor_pedido), 2) AS ticket_medio_geral
FROM (
    SELECT 
        ped.id_pedido,
        SUM(i.quantidade * i.preco_unitario) AS valor_pedido
    FROM pedidos ped
    JOIN itens_pedido i ON ped.id_pedido = i.id_pedido
    WHERE ped.status = 'Concluído'
    GROUP BY ped.id_pedido
) AS sub;