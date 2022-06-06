--숫자 함수

--round (반올림)
select 45.923 from dual;
select round(45.923,2), round(45.923) , round(45.923, 0) ,round(45.923,-1) from dual;
--.기준으로 2는 소숫점2자리까지 공백은 소숫점0번째 까지 -1은 소숫점기준 왼쪽으로 첫번째 즉 1의자리 -2면 10의자리 반올림

--trunc(절삭)
select trunc(45.923,2), trunc(45.923) , trunc(45.923,0) , trunc(45.923,-1) from dual;

--abs (절대값)
select abs(-34) from dual;

--ceil(올림), floor(내림)
select ceil(3.14), floor(3.14) from dual; --정수 올림내림, round와 trunc로 대체가 가능하여 잘 쓰이지않음

--mod(나머지)
select 10/3 as 나누기, mod(10,3) as 나머지 from dual; --sql에서는 %를 사용해 나머지를 구할 수 없다. 대신 mod를 사용

--날짜함수
--SYSDATE 매우중요
select sysdate from dual; --년,월,일 

--SYSTIMESTAMP
select systimestamp from dual; --년,월,일,시,분,초,밀리초,표준시간

--날짜도 연산이 가능합니다.
select sysdate-hire_date from employees;  --날짜 빼기 날짜는 일수
select (sysdate - hire_date) / 7 from employees; --몇주
select (sysdate - hire_date) /365 from employees; --몇년
select trunc((sysdate - hire_date) /365) from employees;

--날짜에도 trunc, round 적용이 가능합니다.
select round(sysdate) from dual;

select round(sysdate , 'year') from dual; --"년" 반올림
select round(sysdate, 'month') from dual; --"월" 반올림
select round(sysdate , 'day') from dual; --day는 일요일을 기준으로 반올림됨. 
select round(systimestamp) from dual;

select trunc(sysdate) from dual;
select trunc(sysdate, 'year') from dual; --년 기준으로 자름
select trunc(sysdate , 'month') from dual; --월 기준으로 자름
select trunc(sysdate, 'day') from dual; -- 일 기준으로 자름(일요일 기준)