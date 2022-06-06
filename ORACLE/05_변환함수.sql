--형 변환 함수 TO_CHAR TO_DATE TO_NUMBER

--TO_CHAR (날짜를 문자로 변경 OR 숫자를 문자로 변경)

--to_char(date,'pmt') 날짜를 문자로 (YY-MM-DD HH:MI:SS)
select to_char(sysdate) from dual;
select to_char(sysdate,'YYYY"년"MM"월"DD"일"') from dual;-- (-,/,:,(공백)외에 다른 문자는 ""사용없이 사용불가능 )
select to_char(sysdate,'YYYY-MM-DD') from dual; -- (-,/,:,(공백)은""사용없이 사용가능 )
select to_char(sysdate, 'YY-MM-DD HH:MI:SS') from dual; 
select to_char(sysdate, 'YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"') from dual;

select first_name, hire_date from employees;
select first_name, to_char(hire_date,'YYYY-MM-DD') from employees;
-- to_char(hire_date,'YYYY-MM-DD')이렇게 사용될 때가 엄청 많음.
select first_name , to_char(hire_date , 'YY-MM-DD HH24:mi:ss') from employees;
select first_name , to_char(hire_date, 'YYYY"년" MM"월" DD"일"')from employees;

--to_char(number,'pmt') 숫자를 문자로 (9,.,,)
select to_char(20000,'99999') from dual;  --9는 자릿수 (매우중요) (자릿수를 부족하게 주면 ####으로 출력된다.)
select to_char(20000.14,'99999.99') from dual; -- .은 소수점 자리를 의미
select to_char(20000.14 , '99,999.99') from dual; -- ,는 콤마의 표현 형식
select to_char(20000.14 , 'L99,999.99') from dual; --L은 지역화폐 기호 표현 형식
select to_char(20000.14 , '$99,999.99')from dual; -- 달러는 그냥 $ 붙혀주면됨.

select first_name,to_char(salary,'$999,999.99') from employees;

--to number(문자, 숫자형식) 문자를 숫자로 (숫자표현식에서 지원하지 않는 구문은 바꿀 수 없다.)
select '2000' + 2000 from dual; --사실 숫자형 문자열은 숫자로 자동형변환이 가능 
select to_number('2000')+2000 from dual;  --좀 더 정직한(?,정식적인?) 표현

-- select '$3,300'+ 2000 from dual; $기호때문에 형변환이 안됨
select to_number('$3,300' , '$9,999')+2000 from dual; -- 만약 숫자표현형식중 $기호가 빠지면 다시 에러를 발생시킴

select to_number(to_char(3300 , 'L9,999.99') ,'L9,999.99')from dual;
select to_char(3300 , 'L9,999.99') from dual;


--to date(문자, 날짜표현형식) 문자를 날짜로 (날짜표현형식에서 지원하지 않는 구문은 바꿀 수 없다.)
select to_date( '2021/03/31' ) from dual; --사실 날짜형 문자열은 날짜로 자동형변환이 가능
select sysdate - to_date('21/03/30') from dual; --일수 
--자동형변환이 가능하기는 하지만  sysdate - '21/03/30'  이렇게는 안되고 to_date()안에 넣어주어야 한다.

select to_date('2021/03/25' , 'YYYY/MM/DD') from dual; ----좀 더 정직한(?,정식적인?) 표현
select to_date('2021-03-25 14:51:24') from dual; --이형식은 자동형변환이 되지않음
select to_date('2021-03-25 14:51:24' , 'YYYY-MM-DD HH24:MI:SS') from dual;

-- '20201130' ,'20201111'  몇일이 차이나는지 구하기
select to_date('20201130') - to_date('20201111') from dual; --날짜끼리의 연산으로 19가 호출됨.
select to_date('20201130' , 'YYYYMMDD') - to_date('20201111' , 'YYYYMMDD') from dual; -- 좀더 정식적인 표현
select '20201130' - '20201111' from dual; --문자열이 숫자로 자동형변환되서 숫자끼리의 연산으로 19가 호출됨.

-- xxxx년xx월xx일 로 출력
select to_date('20051002','YYYY"년"MM"월"DD"일"') from dual;--(X) 년,월,일이 들어가면 date형식이 아님.

select to_char(to_date('20051002','YYYYMMDD'),'YYYY"년"MM"월"DD"일"')
as "xxxx년xx월xx일 형식" 
from dual; --(O) to_char(date,'pmt')형식


-- NVL 함수
--nvl(컬럼, null일경우 변환할값) - ★★★★★
select nvl(200, 0),nvl(null, 0) from dual;
select first_name , nvl(commission_pct, 0) as commission_pct from employees; --commission_pct가 null이면 0으로 출력함.

--nvl2(컬럼, null이 아닐경우 변환할값 , null일경우 변환할값) - ★★★★★
select nvl2(null, 'null아님' , 'null임') from dual; --첫번째 값이 null이라면 3번째 값이 실행되고 아니라면 2번째 값이 실행됨.

select nvl2(commission_pct,'yes','no')from employees;

select first_name , 
       commission_pct,
       nvl2(commission_pct, salary +(salary * commission_pct) , salary ) 
from employees;


--decode (컬럼, 값 , 결과 , 값, 결과... , default) - ★★★★★ (if - else if - else)구문과 비슷
select decode('C' , 'A', 'A입니다.' , 'B' , 'B입니다.' , 'C', 'C입니다.' , '전부아닙니다.') FROM DUAL;
select decode('D' , 'A', 'A입니다.' , 'B' , 'B입니다.' , 'C', 'C입니다.' , '전부아닙니다.') FROM DUAL;

select sysdate-1 from dual;
select decode(sysdate-1,'21/06/19','오늘입니다.','21/06/20','내일입니다.','21/06/18','어제입니다.')from dual;

SELECT FIRST_NAME , 
       SALARY,
       JOB_ID,
       DECODE(JOB_ID,'IT_PROG', SALARY * 0.5, 'AD_VP', SALARY * 0.4 , SALARY * 0.1) --결과값은 숫자형이기때문에 기존 월급과 더해서 출력해도 될듯.
FROM EMPLOYEES;

--CASE~WHEN~THEN구문 ...ELSE~END
--CASE 값 WHEN 값 THEN 결과 ...ELSE 결과 END

select first_name,
       job_id,
       salary as 월급,       
       (case job_id when 'IT_PROG' then salary * 0.5
                    when 'AD_VP' then salary * 0.4
                    when 'AD_ASST' then salary * 0.6
                    else salary*0.1
        end) as 보너스
from employees;
        


