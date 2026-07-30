CREATE OR REPLACE PROCEDURE UPDATE_PRODUCT_PRICE (
    p_product_id IN NUMBER,
    p_new_price  IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if product exists
    SELECT COUNT(*) 
    INTO v_count 
    FROM PRODUCT 
    WHERE PRODUCT_ID = p_product_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Product ID ' || p_product_id || ' does not exist.');
    END IF;

    IF p_new_price < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Price cannot be negative.');
    END IF;

    UPDATE PRODUCT
    SET PRICE = p_new_price
    WHERE PRODUCT_ID = p_product_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Product ' || p_product_id || ' price updated successfully to ' || p_new_price);
END UPDATE_PRODUCT_PRICE;
/