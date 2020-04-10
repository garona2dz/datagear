CREATE TABLE DATAGEAR_USER
(
	USER_ID VARCHAR(50) NOT NULL,
	USER_NAME VARCHAR(50) NOT NULL,
	USER_PASSWORD VARCHAR(200) NOT NULL,
	USER_REAL_NAME VARCHAR(100),
	USER_EMAIL VARCHAR(200),
	USER_IS_ADMIN VARCHAR(20),
	USER_CREATE_TIME TIMESTAMP,
	PRIMARY KEY (USER_ID),
	UNIQUE (USER_NAME)
);

CREATE TABLE DATAGEAR_ROLE
(
	ROLE_ID VARCHAR(50) NOT NULL,
	ROLE_NAME VARCHAR(100) NOT NULL,
	ROLE_DESCRIPTION VARCHAR(200),
	ROLE_ENABLED VARCHAR(10) NOT NULL,
	ROLE_CREATE_TIME TIMESTAMP,
	PRIMARY KEY (ROLE_ID)
);

CREATE TABLE T_ACCOUNT
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '帐号名',
	HEAD_IMG BLOB COMMENT '头像图片',
	INTRODUCTION TEXT COMMENT '自我介绍',
	PRIMARY KEY (ID)
) COMMENT='帐号';

CREATE TABLE T_ADDRESS
(
	ACCOUNT_ID INT(10) COMMENT '所属帐号',
	CITY VARCHAR(50) COMMENT '城市',
	STREET VARCHAR(100) COMMENT '街道',
	RESIDENTIAL VARCHAR(100) COMMENT '住宅区',
	HOUSE_NUMBER VARCHAR(100) COMMENT '门牌号'
) COMMENT='住址';
ALTER TABLE T_ADDRESS ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ACCOUNT (ID);
ALTER TABLE T_ADDRESS ADD CONSTRAINT UK_ACCOUNT_ID UNIQUE (ACCOUNT_ID);

CREATE TABLE T_ADDRESS_TYPE
(
	ID INT(10),
	TYPE_NAME VARCHAR(50) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE T_ADDRESS_MORE
(
	ACCOUNT_ID INT(10) NOT NULL COMMENT '所属地址',
	ADDRESS VARCHAR(200) COMMENT '地址',
	ADDRESS_TYPE INT(10),
	ADDRESS_PHOTO BLOB COMMENT '地址照片',
	ADDRESS_DESC TEXT COMMENT '地址描述'
) COMMENT='更多住址';
ALTER TABLE T_ADDRESS_MORE ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ADDRESS (ACCOUNT_ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE T_ADDRESS_MORE ADD FOREIGN KEY (ADDRESS_TYPE) REFERENCES T_ADDRESS_TYPE (ID);

CREATE TABLE T_PRODUCT
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '商品名称',
	PRICE FLOAT(10,2) NOT NULL COMMENT '价格',
	PRIMARY KEY (ID)
) COMMENT='商品';

CREATE TABLE T_ORDER
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '订单名称',
	ACCOUNT_ID INT(10) COMMENT '所属帐号',
	DESCRIPTION VARCHAR(20) DEFAULT 'note' COMMENT '描述',
	STAR_LEVEL INT(4) DEFAULT 1 COMMENT '星级',
	CREATE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP() COMMENT '创建日期',
	EDIT_TIME DATETIME COMMENT '编辑日期',
	PRIMARY KEY (ID)
) COMMENT='订单';
ALTER TABLE T_ORDER ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ACCOUNT (ID);

CREATE TABLE T_ORDER_PRODUCTS
(
	ORDER_ID INT(10) NOT NULL COMMENT '订单',
	PRODUCT_ID INT(10) NOT NULL COMMENT '商品'
) COMMENT='订单-商品';
ALTER TABLE T_ORDER_PRODUCTS ADD FOREIGN KEY (ORDER_ID) REFERENCES T_ORDER (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE T_ORDER_PRODUCTS ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T_PRODUCT (ID) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE T_PRODUCT_PRICE_HISTORY
(
	PRODUCT_ID INT(10) NOT NULL COMMENT '商品',
	PRICE FLOAT(10,2) NOT NULL COMMENT '价格'
);
ALTER TABLE T_PRODUCT_PRICE_HISTORY ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T_PRODUCT (ID) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE T_AUTO_GENERATED_KEYS
(
	ID INT(10) NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(20),
	CREATE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (ID)
);

CREATE TABLE `T_PECULIAR_ACCOUNT_[a]b$c`
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '帐号名',
	HEAD_IMG BLOB COMMENT '头像图片',
	INTRODUCTION TEXT COMMENT '自我介绍',
	PRIMARY KEY (ID)
) COMMENT='帐号';

CREATE TABLE `T_PECULIAR_ADDRESS_[ab]c$d_1`
(
	ACCOUNT_ID INT(10) COMMENT '所属帐号',
	CITY VARCHAR(50) COMMENT '城市',
	STREET VARCHAR(100) COMMENT '街道',
	RESIDENTIAL VARCHAR(100) COMMENT '住宅区',
	HOUSE_NUMBER VARCHAR(100) COMMENT '门牌号'
) COMMENT='住址';
ALTER TABLE `T_PECULIAR_ADDRESS_[ab]c$d_1` ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES `T_PECULIAR_ACCOUNT_[a]b$c` (ID);
ALTER TABLE `T_PECULIAR_ADDRESS_[ab]c$d_1` ADD CONSTRAINT UK_ACCOUNT_ID UNIQUE (ACCOUNT_ID);

CREATE TABLE `T_PECULIAR_ADDRESS_MORE_a$b[cde]f_1`
(
	ACCOUNT_ID INT(10) NOT NULL COMMENT '所属地址',
	ADDRESS VARCHAR(200) COMMENT '地址',
	ADDRESS_PHOTO BLOB COMMENT '地址照片',
	ADDRESS_DESC TEXT COMMENT '地址描述',
	`PECULIAR_new$_t[a]b.lec<ol>1#` VARCHAR(50)
) COMMENT='更多住址';
ALTER TABLE `T_PECULIAR_ADDRESS_MORE_a$b[cde]f_1` ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES `T_PECULIAR_ADDRESS_[ab]c$d_1` (ACCOUNT_ID) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE T_DATE
(
	ID INT(10) NOT NULL,
	`DATE` DATE,
	`DATETIME` DATETIME,
	`TIME` TIME,
	`TIMESTAMP` TIMESTAMP,
	`YEAR` YEAR,
	PRIMARY KEY (ID)
);

CREATE TABLE T_DATA_IMPORT
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(200),
	COL_DATE DATE,
	COL_DATETIME DATETIME,
	COL_TIME TIME,
	COL_TIMESTAMP TIMESTAMP,
	COL_BLOB BLOB,
	COL_CLOB TEXT,
	PRIMARY KEY (ID)
);

CREATE TABLE T_DATA_EXPORT
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(200),
	COL_DATE DATE,
	COL_DATETIME DATETIME,
	COL_TIME TIME,
	COL_TIMESTAMP TIMESTAMP,
	COL_BLOB BLOB,
	COL_CLOB TEXT,
	PRIMARY KEY (ID)
);

CREATE TABLE T_ANALYSIS
(
	NAME VARCHAR(50) NOT NULL,
	VALUE FLOAT(10,2) NOT NULL
);

CREATE TABLE T_ANALYSIS_1
(
	COL_NAME VARCHAR(50) NOT NULL,
	COL_DATE DATE NOT NULL,
	COL_VALUE FLOAT(10,2) NOT NULL
);

CREATE TABLE T_ANALYSIS_2
(
	COL_NAME VARCHAR(50) NOT NULL,
	COL_X FLOAT(10,2) NOT NULL,
	COL_Y FLOAT(10,2) NOT NULL
);

CREATE TABLE T_ANALYSIS_MAP
(
    COL_NAME VARCHAR(50) NOT NULL,
    COL_VALUE FLOAT(10,2) NOT NULL,
    COL_LONGITUDE FLOAT(12,6),
    COL_LATITUDE FLOAT(12,6),
	PRIMARY KEY (COL_NAME)
);

/*
truncate table t_auto_generated_keys;
truncate table t_data_export;
truncate table t_data_import;
truncate table t_date;
truncate table t_order_products;
truncate table t_order;
truncate table t_product_price_history;
truncate table t_product;
truncate table `t_peculiar_address_more_a$b[cde]f_1`;
truncate table `t_peculiar_address_[ab]c$d_1`;
truncate table `t_peculiar_account_[a]b$c`;
truncate table t_address_more;
truncate table t_address;
truncate table t_address_type;
truncate table t_account;
*/