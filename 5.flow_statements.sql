-- case문
select 컬럼1,컬럼2,컬럼3,
-- if(컬럼4 == 비교값1){}else if(컬럼4 == 비교값2){}else{}
case 컬럼4
when 비교값1 then 결과값1
when 비교값2 then 결과값2
else 결과값3
end
from 테이블명;

select id, name ,email,
case 
when name is null then '익명사용자'
else name 
end as '사용자명'
from author;

-- ifnull(a,b) : 만약에 a가 null이면 b반환, null 아니면 a 반환
select id, email, ifnull(name,'익명사용자') as '사용자명' from author;

-- 경기도꺼만 출력되게끔 하는것, select와 from은 하나씩만 쓰면 됌
-- SELECT WAREHOUSE_ID, WAREHOUSE_NAME,ADDRESS, ifnull(FREEZER_YN,'N') as 'FREEZER_YN' from FOOD_WAREHOUSE where ADDRESS like '%경기%' order by WAREHOUSE_ID;

-- if(a,b,c) : a조건이 참이면 b 반환, a조건이 거짓이면 c 반환
select id, email, if(name is null,'익명사용자',name) as '사용자명' from author;

-- 조건에 부합하는 중고거래 상태 조회하기
select BOARD_ID,WRITER_ID,TITLE,PRICE,
case STATUS
when 'DONE' then '거래완료'
when 'RESERVED' then '예약중'
else '판매중'
end as 'STATUS' 
from USED_GOODS_BOARD 
where CREATED_DATE like '%2022-10-05%' order by BOARD_ID desc;

-- 12세 이하인 여자 환자 목록 출력하기
select PT_NAME, PT_NO, GEND_CD, AGE, 
if(TLNO is null,'NONE',TLNO) as 'TLNO' 
from PATIENT where AGE <=12 and GEND_CD = 'W' 
order by AGE desc, PT_NAME asc;

