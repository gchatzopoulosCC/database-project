CREATE VIEW [most TV sold] AS
SELECT TOP 1
    p.name,
    SUM(op.quantity) AS total_sold
FROM 
    [Order] o
JOIN 
    OrderedProduct op ON o.id = op.order_id
JOIN 
    Product p ON op.product_id = p.id
WHERE 
    p.category = 'TV' AND
    DATEPART(month, o.date) = DATEPART(month, DATEADD(month, -1, GETDATE())) AND
    DATEPART(year, o.date) = DATEPART(year, DATEADD(month, -1, GETDATE()))
GROUP BY 
    p.name
ORDER BY 
    total_sold DESC;


CREATE VIEW [top 10 stores] AS
SELECT TOP 10
    s.name,
    AVG(sr.stars) AS average_score,
    COUNT(sr.id) AS review_count
FROM 
    Seller s
JOIN 
    SellerReview sr ON s.id = sr.seller_id
GROUP BY 
    s.name
HAVING 
    COUNT(sr.id) >= 3
ORDER BY 
    average_score DESC;


CREATE VIEW [10 best customers] AS
SELECT TOP 10
    u.username,
    SUM(o.total_cost) AS total_spent
FROM 
    [User] u
JOIN 
    [Order] o ON u.id = o.buyer_id
WHERE 
    DATEPART(year, o.date) = 2023
GROUP BY 
    u.username
ORDER BY 
    total_spent DESC;


CREATE VIEW [10 worst products] AS
SELECT TOP 10
    p.name,
    AVG(pr.stars) AS average_score
FROM 
    Product p
JOIN 
    ProductRating pr ON p.id = pr.product_id
GROUP BY 
    p.name
ORDER BY 
    average_score ASC;


CREATE VIEW [price range 32-inch Samsung Smart TV] AS
SELECT
    MIN(p.price) AS min_price,
    MAX(p.price) AS max_price
FROM 
    Product p
JOIN 
    Attributes a ON p.id = a.product_id
WHERE 
    p.category = 'TV' AND
    a.manufacturer = 'Samsung' AND
    a.screen_size = 32 AND
    p.name LIKE '%Smart%';
