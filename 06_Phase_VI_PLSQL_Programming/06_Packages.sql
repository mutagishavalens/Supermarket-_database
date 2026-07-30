-- Package Specification
CREATE OR REPLACE PACKAGE INVENTORY_PKG AS
    PROCEDURE ADD_NEW_PRODUCT (
        p_id       IN NUMBER,
        p_name     IN VARCHAR2,
        p_price    IN NUMBER,
        p_qty      IN NUMBER,
        p_cat_id   IN NUMBER
    );
    
    FUNCTION GET_PRODUCT_COUNT RETURN NUMBER;
END INVENTORY_PKG;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY INVENTORY_PKG AS

    PROCEDURE ADD_NEW_PRODUCT (
        p_id       IN NUMBER,
        p_name     IN VARCHAR2,
        p_price    IN NUMBER,
        p_qty      IN NUMBER,
        p_cat_id   IN NUMBER
    ) IS
    BEGIN
        INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME, PRICE, QUANTITY, CATEGORY_ID)
        VALUES (p_id, p_name, p_price, p_qty, p_cat_id);
        COMMIT;
    END ADD_NEW_PRODUCT;

    FUNCTION GET_PRODUCT_COUNT RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM PRODUCT;
        RETURN v_count;
    END GET_PRODUCT_COUNT;

END INVENTORY_PKG;
/