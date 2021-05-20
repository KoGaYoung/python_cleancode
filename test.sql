-- 5월 15일 이전 제작데이터가 있는지 없으면 작업 필요 X
SELECT CAST(json_f1list AS JSON)
FROM fts_close_makelist -- 제작이력테이블
WHERE ty_module = '4'
AND ty_form != 'srdf0114'
AND dt_make <= '2020-05-15 23:59:59.118412';


-- 5월 15일 이전 제작 데이터가 있을 경우
CREATE TEMP TABLE tmp_makelist --ON COMMIT DROP
AS
SELECT *
FROM json_to_recordset((SELECT CAST(json_f1list AS JSON)
                        FROM fts_close_makelist -- 제작이력테이블
                        WHERE ty_module = '4'
                        AND ty_form != 'srdf0114'
                        AND dt_make <= '2020-05-15 23:59:59.118412'
                        -- 에러가 발생할경우 여러 메뉴에서 제작을 한 경우, 제작건 별 dt_make = '' 조건 필요
                        ))
                        AS x("ty_form" varchar, "no_biz" varchar, "ccode" varchar, "cno" varchar, "nm_krcom" varchar, "type" varchar, "key_auto"  integer);

-- 확인용
SELECT * FROM tmp_makelist;

UPDATE tmp_makelist
SET type = '54'
WHERE 1=1
AND TYPE IS NULL;

SELECT * FROM tmp_makelist;

SELECT CAST(array_to_json(array_agg(tmp_makelist)) AS TEXT)  from tmp_makelist;

UPDATE fts_close_makelist
SET json_f1list = (SELECT CAST(array_to_json(array_agg(tmp_makelist)) AS TEXT) AS  json_f1list from tmp_makelist)-- 여기 json type값 들어있는 json을 str로 cast해서 넣어줘야함
WHERE 1=1
AND dt_make <= '2020-05-15 23:59:59.118412'
-- 한건이 아닐 경우, 제작건 별 dt_make = '' 조건 필요
;


DROP TABLE tmp_makelist;

-- 제작이력테이블 재확인
SELECT CAST(json_f1list AS JSON)
FROM fts_close_makelist -- 제작이력테이블
WHERE ty_module = '4'
AND ty_form != 'srdf0114'
AND dt_make <= '2020-05-15 23:59:59.118412';

-------- test

-- 두번째 방법
select
       case when json_f1list like '%type%' then json_f1list
         else json_f1list end as json_f1list
from fts_close_makelist
where 1=1
and ty_module = '4'
and ty_form != 'srdf0114'
and dt_make <= '2020-05-15 23:59:59.118412';

update fts_close_makelist
set json_f1list = replace(json_f1list, '}', ' ,"type": "54"}')
where 1=1
and ty_module = '4'
and json_f1list not like '%type%'
and ty_form != 'srdf0114'
and dt_make <= '2020-05-15 23:59:59.118412';

-- 테스트 데이터 만들기
UPDATE fts_close_makelist set json_f1list = '[{"ty_form": "srer0101", "no_biz": "22239515vp46Yo0K9ivi+JCY0tA7A==", "ccode": "biz202004280000704", "key_auto": 2, "cno": "28434", "nm_krcom": "\ub300\ud45c\uc790\uba85"}]'
where dt_make <= '2020-05-15 23:59:59.118412';

-- UPDATE fts_close_makelist set dt_make = '2020-05-15 23:59:59.118412' where dt_make = '2020-09-16 09:47:18.224570'
SELECT *
FROM json_to_recordset( (select  CAST(json_f1list AS JSON) from fts_close_makelist where dt_make = '2020-05-15 23:59:59.118412'))
AS x("ty_form" varchar, "no_biz" varchar, "ccode" varchar, "cno" varchar, "nm_krcom" varchar, "type" varchar, "key_auto"  integer);
select * from tmp_makelist;


select pg_typeof(json_f1list) from fts_close_makelist;
