CREATE OR REPLACE TRIGGER TRG_RESTRICT_WEEKEND_HOLIDAY_DML
    BEFORE INSERT OR UPDATE OR DELETE ON PRODUCT
DECLARE
    v_is_holiday NUMBER := 0;
    v_day_of_week VARCHAR2(10);
BEGIN
    -- Check if today is Saturday or Sunday
    SELECT TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = AMERICAN')
    INTO v_day_of_week
    FROM DUAL;

    IF v_day_of_week IN ('SAT', 'SUN') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operation Forbidden: DML operations on PRODUCTS are not allowed on weekends.');
    END IF;

    -- Optional: Check against a custom corporate holidays table if it exists
    -- Assuming a table named CORPORATE_HOLIDAYS (holiday_date DATE) exists:
    /*
    SELECT COUNT(*)
    INTO v_is_holiday
    FROM CORPORATE_HOLIDAYS
    WHERE TRUNC(holiday_date) = TRUNC(SYSDATE);

    IF v_is_holiday > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Operation Forbidden: DML operations are not allowed on public holidays.');
    END IF;
    */
END TRG_RESTRICT_WEEKEND_HOLIDAY_DML;
/
