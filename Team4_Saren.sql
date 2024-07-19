-- 1. MEMBER 테이블 정의
CREATE TABLE MEMBER (
    member_id VARCHAR2(25) NOT NULL,
    member_pw VARCHAR2(20) NOT NULL,
    member_name VARCHAR2(30),
    email VARCHAR2(50),
    phone VARCHAR2(30),
    brand VARCHAR2(100),
    birth_date DATE,
    last_access DATE,
    member_type NUMBER,
    gender VARCHAR2(1),
    seller_authority VARCHAR2(1),
    create_date DATE,
    PRIMARY KEY (member_id)
);

INSERT INTO MEMBER(member_id, member_pw, member_name, email, phone,
		brand, birth_date, last_access, member_type, gender, seller_authority,
		create_date)
VALUES(#{member_id}, #{member_pw}, #{member_name},#{email}, #{phone}, #{brand}, 
#{birth_date}, #{last_access}, #{member_type}, #{gender},#{create_date});


-- 2. ADDR_LIST 테이블 정의
CREATE TABLE ADDR_LIST (
    addr_num NUMBER NOT NULL,
    member_id VARCHAR2(25) NOT NULL,
    zipcode VARCHAR2(50) NULL,
    main_address VARCHAR2(300) NULL,
    detail_address VARCHAR2(200) NULL,
    is_master_addr CHAR(1) NULL,
    sub_address VARCHAR2(50) NULL,
    CONSTRAINT fk_addr_member
        FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id)
);

INSERT INTO ADDR_LIST (addr_num, member_id, zipcode, main_address, detail_address, is_master_addr, sub_address) 
VALUES( ADDR_LIST_SEQUENCE.NEXTVAL , #{member_id}, #{zipcode},  #{main_address}, 
 		#{detail_address}, #{is_master_addr}, #{sub_address});

-- 3. CUSTOMER 테이블 정의
CREATE TABLE CUSTOMER (
    member_id VARCHAR2(25) NOT NULL,
    point NUMBER NULL,
    member_level VARCHAR2(50) NULL,
    accum_amount NUMBER NULL,
    CONSTRAINT fk_customer_member
        FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id)
);

INSERT INTO CUSTOMER(member_id, point, member_level, accum_amount)
VALUES(#{member_id}, #{point}, #{member_level}, #{accum_amount});

-- 4. COUPON 테이블 정의
CREATE TABLE COUPON (
    coupon_id VARCHAR(50) NOT NULL,
    member_id VARCHAR2(25) NOT NULL,
    coupon_name VARCHAR2(25) NULL,
    discount_rate NUMBER NULL,
    quantity NUMBER NULL,
    PRIMARY KEY (coupon_id),
    CONSTRAINT fk_coupon_member
        FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id)
);

INSERT INTO COUPON (coupon_id, member_id, coupon_name, discount_rate, quantity)
VALUES (#{coupon_id}, #{member_id}, #{coupon_name}, #{discount_rate}, #{quantity})


-- 5. REVIEWS 테이블 정의
CREATE TABLE REVIEWS (
    review_id NUMBER NOT NULL,
    review_title VARCHAR2(100) NULL,
    rate NUMBER NULL,
    review_date DATE NULL,
    review_img VARCHAR2(500) NULL,
    review_content VARCHAR2(500) NULL,
    orderdetail_id NUMBER NULL,
    member_id VARCHAR2(25) NOT NULL,
    PRIMARY KEY (review_id),
    CONSTRAINT fk_reviews_member
        FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),
    CONSTRAINT fk_orderdetail 
        FOREIGN KEY (orderdetail_id)
        REFERENCES ORDER_DETAIL(orderdetail_id),    
);

INSERT INTO REVIEWS(review_id, review_title, rate, review_date, review_img, review_content, orderdetail_id, member_id)
VALUES(SEQ_REVIEWS.NEXTVAL, #{review_title}, #{rate}, #{review_date}, #{review_img}, #{review_content}, #{orderdetail_id}, #{member_id});


-- 6. EVENT 테이블 정의
CREATE TABLE EVENT (
    event_id NUMBER NOT NULL,
    event_title VARCHAR2(100) NULL,
    event_content VARCHAR2(3000) NULL,
    event_img_url VARCHAR2(100) NULL,
    event_date DATE NULL,
    PRIMARY KEY (event_id)
);

INSERT INTO EVENT (event_id, event_title, event_content, event_img_url, event_date)
VALUES (event_seq.NEXTVAL, #{event_title}, #{event_content}, #{event_img_url}, #{event_date});


-- 7. NOTICE 테이블 정의
CREATE TABLE NOTICE (
    not_id NUMBER NOT NULL,
    not_title VARCHAR2(100) NULL,
    not_content VARCHAR2(3000) NULL,
    not_date DATE NULL,
    PRIMARY KEY (not_id)
);

INSERT INTO NOTICE (not_id, not_title, not_content, not_date)
VALUES (notice_seq.NEXTVAL, #{not_title}, #{not_content}, #{not_date});

        
-- 8. BUYER_INQ 테이블 정의
CREATE TABLE BUYER_INQ (
    buyer_inq_id NUMBER NOT NULL,
    buyer_inq_title VARCHAR(100),
    buyer_inq_content VARCHAR(1000),
    buyer_inq_date DATE,
    buyer_reply VARCHAR2(3000),
    member_id VARCHAR2(25) NOT NULL,
    prod_id VARCHAR2(150) NOT NULL,
    buyer_reply_date DATE,
    PRIMARY KEY (buyer_inq_id),
    CONSTRAINT fk_buyer_inq_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),
    CONSTRAINT fk_buyer_inq_prod FOREIGN KEY (prod_id)
        REFERENCES PROD(prod_id)
);
INSERT INTO BUYER_INQ(buyer_inq_id, buyer_inq_title, buyer_inq_content, buyer_inq_date, buyer_reply, member_id, prod_id, buyer_reply_date) 
VALUES(buyer_inq_sequence.nextval, #{buyer_inq_title}, #{buyer_inq_content},  SYSDATE,  NULL, #{member_id}, #{prod_id}, NULL);

-- 9. ADMIN_INQ 테이블 정의
CREATE TABLE ADMIN_INQ (
    admin_inq_id NUMBER NOT NULL,
    admin_inq_title VARCHAR2(100) NULL,
    admin_inq_content VARCHAR2(1000) NULL,
    admin_inq_date DATE NULL,
    admin_reply VARCHAR2(3000) NULL,
    member_id VARCHAR2(25) NOT NULL,
    PRIMARY KEY (admin_inq_id),
    CONSTRAINT fk_admin_inq_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id)
);

INSERT INTO ADMIN_INQ(admin_inq_id, admin_inq_title, admin_inq_content, admin_inq_date, member_id) 
VALUES(#{admin_inq_id}, #{admin_inq_title}, #{admin_inq_content}, #{admin_inq_date}, #{member_id});

-- 10. ADMIN_INFO 테이블 정의
CREATE TABLE ADMIN_INFO (
    admin_no NUMBER NOT NULL,
    admin_id VARCHAR2(20) NULL,
    admin_pw VARCHAR2(20) NULL,
    admin_email VARCHAR2(30) NULL,
    admin_name VARCHAR2(20) NULL,
    admin_phone VARCHAR2(20) NULL,
    PRIMARY KEY (admin_no)
);
INSERT INTO ADMIN_INFO(admin_no, admin_id, admin_pw, admin_email, admin_name, admin_phone)
VALUES(#{admin_no}, #{admin_id}, #{admin_pw}, #{admin_email}, #{admin_name}, #{admin_phone});

-- 11. PROD 테이블 정의
CREATE TABLE PROD (
    prod_id VARCHAR2(150) NOT NULL,
    prod_name VARCHAR2(150),
    prod_desc VARCHAR2(300),
    prod_price NUMBER,
    prod_added_date DATE,
    category_id NUMBER NOT NULL,
    member_id VARCHAR2(25) NOT NULL,
    PRIMARY KEY (prod_id),
    CONSTRAINT fk_prod_category FOREIGN KEY (category_id)
        REFERENCES CATEGORY(category_id),
    CONSTRAINT fk_prod_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id)
);

INSERT INTO PROD(prod_id,
		prod_name, prod_desc, prod_price,
		prod_added_date, category_id,
		member_id)
VALUES(#{prod_id}, #{prod_name}, #{prod_desc},
		#{prod_price},
		#{prod_added_date}, #{category_id}, #{member_id})
        
        
-- 12. PROD_IMAGE 테이블 정의
CREATE TABLE PROD_IMAGE (
    img_id VARCHAR2(150) NOT NULL,
    prod_id VARCHAR2(150),
    img_type NUMBER,
    PRIMARY KEY (img_id),
    CONSTRAINT fk_prod_image FOREIGN KEY (prod_id)
        REFERENCES PROD(prod_id)
);

INSERT INTO PROD_IMAGE(img_id, prod_id, img_type) 
VALUES(#{img_id}, #{prod_id}, #{img_type});

-- 13. PROD_OPTION 테이블 정의
CREATE TABLE PROD_OPTION (
    opt_id NUMBER NOT NULL,
    opt_name VARCHAR(30) NULL,
    opt_value VARCHAR(30) NULL,
    prod_id VARCHAR2(150) NOT NULL,
    PRIMARY KEY (opt_id),
    CONSTRAINT fk_prod_option FOREIGN KEY (prod_id)
        REFERENCES PROD(prod_id)
);

INSERT INTO PROD_OPTION(opt_id, opt_name, opt_value, prod_id) 
VALUES(PROD_OPTION_SEQ.NEXTVAL, #{opt_name}, #{opt_value}, #{prod_id});

-- 14. SELL_PROD_STOCK 테이블 정의
CREATE TABLE SELL_PROD_STOCK (
    s_stock_id VARCHAR2(150) NOT NULL,
    stock NUMBER NULL,
    total NUMBER NULL,
    prod_id VARCHAR2(150) NOT NULL,
    opt_id1 NUMBER NOT NULL,
    opt_id2 NUMBER NOT NULL,
    opt_id3 NUMBER NOT NULL,
    opt_id4 NUMBER NOT NULL,
    opt_id5 NUMBER NOT NULL,
    PRIMARY KEY (s_stock_id),
    CONSTRAINT fk_sell_prod_stock_prod FOREIGN KEY (prod_id)
        REFERENCES PROD(prod_id),
    CONSTRAINT fk_sell_prod_stock_opt1 FOREIGN KEY (opt_id1)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_sell_prod_stock_opt2 FOREIGN KEY (opt_id2)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_sell_prod_stock_opt3 FOREIGN KEY (opt_id3)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_sell_prod_stock_opt4 FOREIGN KEY (opt_id4)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_sell_prod_stock_opt5 FOREIGN KEY (opt_id5)
        REFERENCES PROD_OPTION(opt_id)
);

INSERT INTO SELL_PROD_STOCK(s_stock_id, stock, total, prod_id, opt_id1, opt_id2, opt_id3, opt_id4, opt_id5)
VALUES(#{s_stock_id}, #{stock}, #{total}, #{prod_id}, #{opt_id1}, #{opt_id2}, #{opt_id3}, #{opt_id4}, #{opt_id5});

-- 15. CATEGORY 테이블 정의
CREATE TABLE CATEGORY (
    category_id NUMBER NOT NULL,
    category_name VARCHAR2(50) NULL,
    category_depth NUMBER NULL,
    parent_category_id NUMBER NULL,
    is_lowest NUMBER NULL,
    PRIMARY KEY (category_id)
);

INSERT INTO CATEGORY(category_id, category_name, category_depth, parent_category_id, is_lowest) 
VALUES(#{category_id}, #{category_name}, #{category_depth}, #{parent_category_id}, #{is_lowest});

-- 16. WISH_LIST 테이블 정의
CREATE TABLE WISH_LIST (
    member_id VARCHAR2(25) NOT NULL,
    prod_id VARCHAR2(150) NOT NULL,
    PRIMARY KEY (member_id, prod_id),
    CONSTRAINT fk_wish_list_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),
    CONSTRAINT fk_wish_list_prod FOREIGN KEY (prod_id)
        REFERENCES PROD(prod_id)
);

INSERT INTO WISH_LIST(member_id, prod_id, email) 
VALUES(#{member_id}, #{prod_id}, #{email});

-- 17. Cart 테이블 정의
CREATE TABLE CART (
    cart_id NUMBER NOT NULL,
    member_id VARCHAR2(25) NOT NULL,
    s_stock_id VARCHAR2(150) NOT NULL,
    cart_amount NUMBER NULL,
    product_type VARCHAR2(10),
    PRIMARY KEY (cart_id, member_id),
    CONSTRAINT fk_cart_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),
    CONSTRAINT fk_cart_s_stock FOREIGN KEY (s_stock_id)
        REFERENCES SELL_PROD_STOCK(s_stock_id)
);

INSERT INTO CART(cart_id, member_id, s_stock_id, r_stock_id, cart_amount, product_type) 
VALUES(cart_sequence.nextval, #{member_id}, #{s_stock_id}, null, #{cart_amount}, 'sell');

INSERT INTO CART(cart_id, member_id, s_stock_id, r_stock_id, cart_amount, product_type) 
VALUES(cart_sequence.nextval, #{member_id}, null, #{r_stock_id},#{cart_amount}, 'rent');

-- 18. ORDER_DETAIL 테이블 생성
CREATE TABLE ORDER_DETAIL (
    orderdetail_id NUMBER NOT NULL,
    order_product_price NUMBER NULL,
    order_num NUMBER NULL,
    order_id NUMBER NOT NULL,
    s_stock_id VARCHAR2(150) NOT NULL,
    order_state VARCHAR2(25) NULL,
    PRIMARY KEY (orderdetail_id),
    CONSTRAINT fk_order_detail_s_stock FOREIGN KEY (s_stock_id)
        REFERENCES SELL_PROD_STOCK(s_stock_id)
);

INSERT INTO ORDER_DETAIL(orderdetail_id, order_product_price, order_num, order_id, s_stock_id, order_state)
VALUES(order_detail_sequence.nextval, #{order_product_price}, #{order_num}, ORDER_PROD_SEQUENCE.currval, #{s_stock_id},'결제대기');
        
-- 19. ORDER_PROD 테이블 생성
CREATE TABLE ORDER_PROD (
    order_id NUMBER NOT NULL,
    order_date DATE NULL,
    member_id VARCHAR2(25) NOT NULL,
    addr_num NUMBER NOT NULL,
    total_price NUMBER NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_order_prod_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),
    CONSTRAINT fk_order_prod_addr FOREIGN KEY (addr_num)
        REFERENCES ADDR_LIST(addr_num)
);

INSERT INTO ORDER_PROD (order_id, order_date, member_id, addr_num, total_price)
SELECT ORDER_PROD_SEQUENCE.NEXTVAL, sysdate, #{member_id}, addr_num, #{total_price}
FROM addr_list
WHERE member_id = #{member_id} AND IS_MASTER_ADDR = 'Y'

-- 20. RENT 테이블 생성
CREATE TABLE RENT (
    rental_code NUMBER NOT NULL,
    rent_start_date DATE NULL,
    rent_end_date DATE NULL,
    member_id VARCHAR2(25) NOT NULL,
    total_rent_price NUMBER NULL,
    PRIMARY KEY (rental_code),
    CONSTRAINT fk_rent_member FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id)
);

INSERT INTO RENT(rental_code, rent_start_date, rent_end_date, member_id, total_rent_price)
VALUES(rent_sequence.nextval, #{rent_start_date}, #{rent_end_date}, #{member_id}, #{total_rent_price});

-- 21. RENT_DETAIL 테이블 생성
CREATE TABLE RENT_DETAIL (
    rentdetail_id NUMBER NOT NULL,
    rent_product_price NUMBER NULL,
    rent_num NUMBER NULL,
    rental_code NUMBER NOT NULL,
    r_stock_id VARCHAR2(150) NOT NULL,
    rent_state VARCHAR2(25) NULL,
    PRIMARY KEY (rentdetail_id, r_stock_id)
);

INSERT INTO RENT_DETAIL(rentdetail_id, rent_product_price, rent_num, r_stock_id, rental_code, rent_state)
VALUES(#{rentdetail_id}, #{rent_product_price}, #{rent_num}, #{r_stock_id}, #{rental_code}, '대여신청완료');

-- 22. RENT_PROD_STOCK 테이블 생성
CREATE TABLE RENT_PROD_STOCK (
    r_stock_id VARCHAR2(150) NOT NULL,
    stock NUMBER NULL,
    total NUMBER NULL,
    prod_id VARCHAR2(150) NOT NULL,
    opt_id1 NUMBER NOT NULL,
    opt_id2 NUMBER NOT NULL,
    opt_id3 NUMBER NOT NULL,
    opt_id4 NUMBER NOT NULL,
    opt_id5 NUMBER NOT NULL,
    PRIMARY KEY (r_stock_id),
    CONSTRAINT fk_rent_prod_stock_prod FOREIGN KEY (prod_id)
        REFERENCES PROD(prod_id),
    CONSTRAINT fk_rent_prod_stock_opt1 FOREIGN KEY (opt_id1)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_rent_prod_stock_opt2 FOREIGN KEY (opt_id2)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_rent_prod_stock_opt3 FOREIGN KEY (opt_id3)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_rent_prod_stock_opt4 FOREIGN KEY (opt_id4)
        REFERENCES PROD_OPTION(opt_id),
    CONSTRAINT fk_rent_prod_stock_opt5 FOREIGN KEY (opt_id5)
        REFERENCES PROD_OPTION(opt_id)
);

INSERT INTO RENT_PROD_STOCK(r_stock_id, stock, total, 
		prod_id, opt_id1, opt_id2, opt_id3, opt_id4, opt_id5)
VALUES(#{r_stock_id}, #{stock}, #{total}, #{prod_id}, #{opt_id1}, 
		#{opt_id2}, #{opt_id3}, #{opt_id4}, #{opt_id5});
        
        