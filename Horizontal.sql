CREATE TABLE бренд (
    бренд_id     VARCHAR2(250) NOT NULL,
    наименование VARCHAR2(250) NOT NULL,
    логотип      BLOB
);

ALTER TABLE бренд ADD CONSTRAINT бренд_pk PRIMARY KEY ( бренд_id );

CREATE TABLE виды_туризма (
    вид_туризма_id       NUMBER NOT NULL,
    название             VARCHAR2(250) NOT NULL,
    международный_индекс VARCHAR2(250) NOT NULL
);

ALTER TABLE виды_туризма ADD CONSTRAINT виды_туризма_pk PRIMARY KEY ( вид_туризма_id );

CREATE TABLE заказ (
    заказ_id          NUMBER NOT NULL,
    дата_формаривания DATE,
    способ_доставки   VARCHAR2(250) NOT NULL,
    способ_оплаты     VARCHAR2(250)
);

ALTER TABLE заказ ADD CONSTRAINT заказ_pk PRIMARY KEY ( заказ_id );

CREATE TABLE каталог (
    количество               NUMBER,
    снаряжение_снаряжение_id NUMBER NOT NULL,
    магазины_магазин_id      NUMBER NOT NULL
);

ALTER TABLE каталог ADD CONSTRAINT каталог_pk PRIMARY KEY ( снаряжение_снаряжение_id,
                                                            магазины_магазин_id );

CREATE TABLE клиенты (
    клиент_id        NUMBER NOT NULL,
    контактный_номер NUMBER NOT NULL,
    реквизиты        VARCHAR2(250) NOT NULL,
    скидка           NUMBER
);

ALTER TABLE клиенты ADD CONSTRAINT клиенты_pk PRIMARY KEY ( клиент_id );

CREATE TABLE корпаративные (
    клиент_id NUMBER NOT NULL,
    название  VARCHAR2(250) NOT NULL
);

ALTER TABLE корпаративные ADD CONSTRAINT корпаративные_pk PRIMARY KEY ( клиент_id );

ALTER TABLE корпаративные ADD CONSTRAINT корпаративные_pkv1 UNIQUE ( название );

CREATE TABLE магазины (
    магазин_id             NUMBER NOT NULL,
    название               VARCHAR2(250) NOT NULL,
    адрес                  VARCHAR2(250) NOT NULL,
    телефон                NUMBER NOT NULL,
    время_начала_работы    DATE,
    время_окончания_работы DATE
);

ALTER TABLE магазины ADD CONSTRAINT магазины_pk PRIMARY KEY ( магазин_id );

CREATE TABLE материалы (
    материал_id         NUMBER NOT NULL,
    название            VARCHAR2(250) NOT NULL,
    цвет                VARCHAR2(250) NOT NULL,
    водостойкость       NUMBER,
    разрывная_прочность NUMBER
);

ALTER TABLE материалы ADD CONSTRAINT материалы_pk PRIMARY KEY ( материал_id );

CREATE TABLE материалы_в_снаряжении (
    количество               NUMBER,
    цвет                     VARCHAR2(250),
    снаряжение_снаряжение_id NUMBER NOT NULL,
    материалы_материал_id    NUMBER NOT NULL
);

ALTER TABLE материалы_в_снаряжении ADD CONSTRAINT материалы_в_снаряжении_pk PRIMARY KEY ( снаряжение_снаряжение_id,
                                                                                          материалы_материал_id );

CREATE TABLE накладная (
    количество               NUMBER NOT NULL,
    снаряжение_снаряжение_id NUMBER NOT NULL,
    заказ_заказ_id           NUMBER NOT NULL
);

ALTER TABLE накладная ADD CONSTRAINT накладная_pk PRIMARY KEY ( снаряжение_снаряжение_id,
                                                                заказ_заказ_id );

CREATE TABLE поставщики (
    поставщик_id      NUMBER NOT NULL,
    название          VARCHAR2(250) NOT NULL,
    адрес             VARCHAR2(250) NOT NULL,
    контактные_данные VARCHAR2(250) NOT NULL
);

ALTER TABLE поставщики ADD CONSTRAINT поставщики_pk PRIMARY KEY ( поставщик_id );

CREATE TABLE предпочтения (
    снаряжение_предпочтение_id NUMBER NOT NULL,
    клиенты_клиент_id          NUMBER NOT NULL
);

ALTER TABLE предпочтения ADD CONSTRAINT предпочтения_снаряжения_pk PRIMARY KEY ( снаряжение_предпочтение_id,
                                                                                 клиенты_клиент_id );

CREATE TABLE приход (
    количество               NUMBER NOT NULL,
    снаряжение_снаряжение_id NUMBER NOT NULL,
    поставщики_поставщик_id  NUMBER NOT NULL
);

ALTER TABLE приход ADD CONSTRAINT приход_pk PRIMARY KEY ( снаряжение_снаряжение_id,
                                                          поставщики_поставщик_id );

CREATE TABLE продавцы (
    продавец_id                 NUMBER NOT NULL,
    фамилия                     VARCHAR2(25) NOT NULL,
    имя                         VARCHAR2(25) NOT NULL,
    отчество                    VARCHAR2(25) NOT NULL,
    дата_рождения               DATE NOT NULL,
    вид_спорта                  NUMBER NOT NULL,
    виды_туризма_вид_туризма_id NUMBER NOT NULL,
    магазины_магазин_id         NUMBER
);

ALTER TABLE продавцы ADD CONSTRAINT продавцы_pk PRIMARY KEY ( продавец_id );

CREATE TABLE сертификаты (
    сертификат_id      NUMBER NOT NULL,
    описание_стандарта VARCHAR2(250) NOT NULL,
    номер_в_госреестре NUMBER NOT NULL
);

ALTER TABLE сертификаты ADD CONSTRAINT сертификаты_pk PRIMARY KEY ( сертификат_id );

CREATE TABLE сертификация (
    дата_прохождения          DATE,
    сертификаты_сертификат_id NUMBER NOT NULL,
    снаряжение_снаряжение_id  NUMBER NOT NULL
);

ALTER TABLE сертификация ADD CONSTRAINT сертификация_pk PRIMARY KEY ( сертификаты_сертификат_id,
                                                                      снаряжение_снаряжение_id );

CREATE TABLE снаряжение (
    снаряжение_id  NUMBER NOT NULL,
    название       VARCHAR2(250) NOT NULL,
    материал       NUMBER NOT NULL,
    тип_туризма    NUMBER NOT NULL,
    бренд_бренд_id VARCHAR2(250) NOT NULL,
    цена           NUMBER NOT NULL
);

ALTER TABLE снаряжение ADD CONSTRAINT снаряжение_pk PRIMARY KEY ( снаряжение_id );

CREATE TABLE снаряжение_в_туризме (
    снаряжение_снаряжение_id    NUMBER NOT NULL,
    виды_туризма_вид_туризма_id NUMBER NOT NULL
);

ALTER TABLE снаряжение_в_туризме ADD CONSTRAINT снаряжение_в_туризме_pk PRIMARY KEY ( снаряжение_снаряжение_id,
                                                                                      виды_туризма_вид_туризма_id );

CREATE TABLE список_заказов (
    дата_формирования DATE NOT NULL,
    заказ_заказ_id    NUMBER NOT NULL,
    клиенты_клиент_id NUMBER NOT NULL
);

ALTER TABLE список_заказов ADD CONSTRAINT список_заказов_pk PRIMARY KEY ( заказ_заказ_id,
                                                                          клиенты_клиент_id );

CREATE TABLE частные (
    клиент_id NUMBER NOT NULL,
    фамилия   VARCHAR2(250) NOT NULL,
    имя       VARCHAR2(250) NOT NULL,
    отчество  VARCHAR2(250)
);

ALTER TABLE частные ADD CONSTRAINT частные_pk PRIMARY KEY ( клиент_id );

ALTER TABLE каталог
    ADD CONSTRAINT каталог_магазины_fk FOREIGN KEY ( магазины_магазин_id )
        REFERENCES магазины ( магазин_id );

ALTER TABLE каталог
    ADD CONSTRAINT каталог_снаряжение_fk FOREIGN KEY ( снаряжение_снаряжение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE корпаративные
    ADD CONSTRAINT корпаративные_клиенты_fk FOREIGN KEY ( клиент_id )
        REFERENCES клиенты ( клиент_id );


ALTER TABLE материалы_в_снаряжении
    ADD CONSTRAINT материалы_в_снаряжении_материалы_fk FOREIGN KEY ( материалы_материал_id )
        REFERENCES материалы ( материал_id );

ALTER TABLE материалы_в_снаряжении
    ADD CONSTRAINT материалы_в_снаряжении_снаряжение_fk FOREIGN KEY ( снаряжение_снаряжение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE накладная
    ADD CONSTRAINT накладная_заказ_fk FOREIGN KEY ( заказ_заказ_id )
        REFERENCES заказ ( заказ_id );

ALTER TABLE накладная
    ADD CONSTRAINT накладная_снаряжение_fk FOREIGN KEY ( снаряжение_снаряжение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE предпочтения
    ADD CONSTRAINT предпочтения_снаряжения_клиенты_fk FOREIGN KEY ( клиенты_клиент_id )
        REFERENCES клиенты ( клиент_id );

ALTER TABLE предпочтения
    ADD CONSTRAINT предпочтения_снаряжения_снаряжение_fk FOREIGN KEY ( снаряжение_предпочтение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE приход
    ADD CONSTRAINT приход_поставщики_fk FOREIGN KEY ( поставщики_поставщик_id )
        REFERENCES поставщики ( поставщик_id );

ALTER TABLE приход
    ADD CONSTRAINT приход_снаряжение_fk FOREIGN KEY ( снаряжение_снаряжение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE продавцы
    ADD CONSTRAINT продавцы_виды_туризма_fk FOREIGN KEY ( виды_туризма_вид_туризма_id )
        REFERENCES виды_туризма ( вид_туризма_id );

ALTER TABLE продавцы
    ADD CONSTRAINT продавцы_магазины_fk FOREIGN KEY ( магазины_магазин_id )
        REFERENCES магазины ( магазин_id );

ALTER TABLE сертификация
    ADD CONSTRAINT сертификация_сертификаты_fk FOREIGN KEY ( сертификаты_сертификат_id )
        REFERENCES сертификаты ( сертификат_id );

ALTER TABLE сертификация
    ADD CONSTRAINT сертификация_снаряжение_fk FOREIGN KEY ( снаряжение_снаряжение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE снаряжение
    ADD CONSTRAINT снаряжение_бренд_fk FOREIGN KEY ( бренд_бренд_id )
        REFERENCES бренд ( бренд_id );


ALTER TABLE снаряжение_в_туризме
    ADD CONSTRAINT снаряжение_в_туризме_виды_туризма_fk FOREIGN KEY ( виды_туризма_вид_туризма_id )
        REFERENCES виды_туризма ( вид_туризма_id );

ALTER TABLE снаряжение_в_туризме
    ADD CONSTRAINT снаряжение_в_туризме_снаряжение_fk FOREIGN KEY ( снаряжение_снаряжение_id )
        REFERENCES снаряжение ( снаряжение_id );

ALTER TABLE список_заказов
    ADD CONSTRAINT список_заказов_заказ_fk FOREIGN KEY ( заказ_заказ_id )
        REFERENCES заказ ( заказ_id );

ALTER TABLE список_заказов
    ADD CONSTRAINT список_заказов_клиенты_fk FOREIGN KEY ( клиенты_клиент_id )
        REFERENCES клиенты ( клиент_id );

ALTER TABLE частные
    ADD CONSTRAINT частные_клиенты_fk FOREIGN KEY ( клиент_id )
        REFERENCES клиенты ( клиент_id );

CREATE OR REPLACE TRIGGER arc_fkarc_1_корпаративные BEFORE
    INSERT OR UPDATE OF клиент_id ON корпаративные
    FOR EACH ROW
DECLARE
    d NUMBER;
BEGIN
    SELECT
        a.клиент_id
    INTO d
    FROM
        клиенты a
    WHERE
        a.клиент_id = :new.клиент_id;

    IF ( d IS NULL OR d <> 1 ) THEN
        raise_application_error(-20223,
                               'FK Корпаративные_Клиенты_FK in Table Корпаративные violates Arc constraint on Table Клиенты - discriminator column Клиент_ID doesn''t have value 1');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_частные BEFORE
    INSERT OR UPDATE OF клиент_id ON частные
    FOR EACH ROW
DECLARE
    d NUMBER;
BEGIN
    SELECT
        a.клиент_id
    INTO d
    FROM
        клиенты a
    WHERE
        a.клиент_id = :new.клиент_id;

    IF ( d IS NULL OR d <> 1 ) THEN
        raise_application_error(-20223,
                               'FK Частные_Клиенты_FK in Table Частные violates Arc constraint on Table Клиенты - discriminator column Клиент_ID doesn''t have value 1');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
