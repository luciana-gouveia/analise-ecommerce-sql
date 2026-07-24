# 🛒 Análise de E-commerce & Comportamento de Clientes (SQL)

Projeto prático de modelagem relacional, estruturação de banco de dados e análise de métricas de negócios em e-commerce utilizando **SQL (SQLite)**.

---

## 🎯 Objetivos do Projeto
- **Modelagem de Dados:** Estruturação de tabelas relacionais com chaves primárias e estrangeiras (`PK`/`FK`).
- **Análise Financeira:** Identificação de faturamento total, ticket médio e categorias mais lucrativas.
- **Segmentação de Clientes:** Mapeamento de clientes VIPs e análise de volume de pedidos.

---

## 📊 Estrutura do Banco de Dados

O banco de dados é composto por 4 tabelas conectadas:
1. `clientes`: Cadastro de consumidores (id, nome, email, estado, data_cadastro).
2. `produtos`: Catálogo de itens (id, nome_produto, categoria, preco).
3. `pedidos`: Registro de transações (id, id_cliente, data_pedido, status).
4. `itens_pedido`: Detalhamento dos produtos comprados (id, id_pedido, id_produto, quantidade, preco_unitario).

---

## 📈 Principais Insights Extraídos

### 1. Faturamento por Categoria
Apesar de ter menor volume unitário, a categoria de **Eletrônicos** lidera o faturamento total com **R$ 11.800,00** contra **R$ 2.120,00** em Acessórios.

```sql
SELECT 
    p.categoria,
    SUM(i.quantidade) AS total_itens_vendidos,
    SUM(i.quantidade * i.preco_unitario) AS faturamento_total
FROM produtos p
JOIN itens_pedido i ON p.id_produto = i.id_produto
JOIN pedidos ped ON i.id_pedido = ped.id_pedido
WHERE ped.status = 'Concluído'
GROUP BY p.categoria
ORDER BY faturamento_total DESC;
