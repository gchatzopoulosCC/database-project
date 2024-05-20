/* Product Related Tables */

CREATE TABLE [Product] (
  [id] int PRIMARY KEY,
  [name] varchar(32) NOT NULL,
  [img_path] varchar(256) NOT NULL,
  [description] varchar(512) NOT NULL,
  [category] varchar(32) NOT NULL,
  [price] float NOT NULL,
  [availability] tinyint DEFAULT (1),
  [seller_id] int
);


CREATE TABLE [OrderedProduct] (
  [id] int PRIMARY KEY,
  [product_id] int,
  [order_id] int
);


CREATE TABLE [Attributes] (
  [id] int PRIMARY KEY,
  [product_id] int UNIQUE,
  [manufacturer] varchar(32) NOT NULL,
  [release_year] int,
  [screen_size] int,
  [resolution] varchar(8),
  [panel_type] varchar(8),
  [cpu] varchar(16),
  [ram] int,
  [storage] int,
  [battery] int,
  [gpu] varchar(16),
  [storage_type] varchar(4),
  [operating_system] varchar(32)
);


CREATE TABLE [ProductRating] (
  [id] int PRIMARY KEY,
  [user_id] int,
  [product_id] int,
  [stars] int NOT NULL,
  [review] varchar(512),
  [experiences_json_path] varchar(256) UNIQUE NOT NULL
);


/* Seller Related */

CREATE TABLE [Seller] (
  [id] int PRIMARY KEY,
  [name] varchar(32) UNIQUE NOT NULL,
  [img_path] varchar(256) NOT NULL,
  [type] varchar(64) NOT NULL,
  [address] varchar(128) NOT NULL,
  [website] varchar(256) UNIQUE,
  [phone_number] int UNIQUE NOT NULL,
  [total_sales] int DEFAULT (0),
  [years_of_operation] int DEFAULT (0),
  [is_official_reseller] tinyint DEFAULT (0)
);


CREATE TABLE [SellerField] (
  [id] int PRIMARY KEY,
  [seller_id] int,
  [name] varchar(16) NOT NULL
);


CREATE TABLE [SellerReview] (
  [id] int PRIMARY KEY,
  [user_id] int,
  [seller_id] int,
  [stars] int NOT NULL,
  [review] varchar(512)
);


/* Courier Related Tables */

CREATE TABLE [Courier] (
  [id] int PRIMARY KEY,
  [name] varchar(32)
);


/* Order */

CREATE TABLE [Order] (
  [id] int PRIMARY KEY,
  [buyer_id] int,
  [seller_id] int,
  [courier_id] int,
  [date] varchar(64) NOT NULL,
  [address] varchar(64),
  [tracking_number] varchar(16) NOT NULL,
  [quantity] int NOT NULL DEFAULT (1),
  [card_hash] varchar(64),
  [shipping_cost] float NOT NULL DEFAULT (0),
  [total_cost] float,
  [receipt_path] varchar(256) UNIQUE NOT NULL
);


/* User Related Tables */

CREATE TABLE [User] (
  [id] int PRIMARY KEY,
  [username] varchar(32) NOT NULL,
  [year_of_birth] int,
  [email] varchar(128) NOT NULL,
  [password_hash] varchar(64) NOT NULL,
  [phone_number] varchar(10) UNIQUE
);


CREATE TABLE [UserAddress] (
  [id] int PRIMARY KEY,
  [user_id] int,
  [address] varchar(128) UNIQUE NOT NULL
);


/* Favourite Products */

CREATE TABLE [Favourite] (
  [id] int PRIMARY KEY,
  [user_id] int,
  [product_id] int
);


/* Foreign Keys*/

/* Product */
ALTER TABLE [Product] ADD FOREIGN KEY ([seller_id]) REFERENCES [Seller] ([id]);

/* OrderedProduct */
ALTER TABLE [OrderedProduct] ADD FOREIGN KEY ([product_id]) REFERENCES [Product] ([id]);
ALTER TABLE [OrderedProduct] ADD FOREIGN KEY ([order_id]) REFERENCES [Order] ([id]);

/* Attributes */
ALTER TABLE [Attributes] ADD FOREIGN KEY ([product_id]) REFERENCES [Product] ([id]);

/* ProductRating */
ALTER TABLE [ProductRating] ADD FOREIGN KEY ([user_id]) REFERENCES [User] ([id]);
ALTER TABLE [ProductRating] ADD FOREIGN KEY ([product_id]) REFERENCES [Product] ([id]);

/* SellerReview */
ALTER TABLE [SellerReview] ADD FOREIGN KEY ([user_id]) REFERENCES [User] ([id]);
ALTER TABLE [SellerReview] ADD FOREIGN KEY ([seller_id]) REFERENCES [Seller] ([id]);

/* Order */
ALTER TABLE [Order] ADD FOREIGN KEY ([buyer_id]) REFERENCES [User] ([id]);
ALTER TABLE [Order] ADD FOREIGN KEY ([seller_id]) REFERENCES [Seller] ([id]);
ALTER TABLE [Order] ADD FOREIGN KEY ([courier_id]) REFERENCES [Courier] ([id]);

/* UserAddress */
ALTER TABLE [UserAddress] ADD FOREIGN KEY ([user_id]) REFERENCES [User] ([id]);

/* Favourite */
ALTER TABLE [Favourite] ADD FOREIGN KEY ([product_id]) REFERENCES [Product] ([id]);
