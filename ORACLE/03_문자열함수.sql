 --dual은 가상테이블
select 'hello world', 'SQL' from dual;

--문자 조작 함수
--lower , upper , initcap

select lower('hello WORLD') , upper('hello WORLD') , initcap ('hello WORLD') from dual;

select lower(first_name), upper(first_name), initcap(first_name)  from employees;

--함수는 where조건에도 들어갑니다.
select * from employees where lower(first_name) = 'ellen';  --엘렌이 찾아짐
select * from employees where first_name = 'ellen';  --엘렌이 찾아지지않음

-- length() 문자열 길이 , instr() 문자열 찾기
select 'abcdef' ,length('abcdef') , instr('abcdef', 'b') from dual; --abcdef컬럼에 b가 시작되는 위치
--instr(  ,  )첫번째 값은 대상 두번째 값은 찾는 값  

select first_name , length(first_name), instr(first_name, 'a') from employees;


--concat(값,값) 문자열 붙히기, substr(타겟, 시작인덱스, 자를개수) 문자열 자르기

select concat('hello' , 'world') from dual; --여기중간에 만약 또 다른 값을 넣고싶다면 어떻게 해야할까 
--concat의 매개변수로 값을 3개를 넣어줄수는 없으니 중첩을 사용한다.
select concat(concat('hello' , ' crazy '),'world') from dual;

select 'hello' ||'world' from dual; --물론 이렇게도 만들수 있긴하다.

select substr('abcdef',2,5) from dual;
--이렇게 하면 항상 마지막까지 잘라줄 수 있나? length - (시작값-1)  (검증필요)
select substr('abcdef',2 ,length('abcdef')- 1) from dual;

select first_name, concat(first_name , last_name), substr(first_name, 1 , 3) from employees;


-- LPAD , RPAD 좌,우측 지정된 문자열로 채우기
select 'abc' ,lpad('abc',10,'*') from dual; -- lpad(타겟, 최대자릿수 , 남는자리를 채울값) 
--이미 abc3개의값이 있어서 *는 왼쪽에 7개만 생겼다.
select 'abc', rpad('abc',10, '*') from dual;


-- LTRIM, RTRIM, TRIM 공백제거 왼쪽공백제거, 오른쪽 공백제거, 양쪽 공백제거
select '    hello world    ', LTRIM('    hello world    ') from dual;--왼쪽 공백만 제거되었다.
select '    hello world    ', RTRIM('    hello world    ') from dual;--오른쪽 공백만 제거되었다.
select '    hello world    ', TRIM('    hello world    ') from dual;--양쪽 공백이 모두 제거되었다.


--replace() 문자열 바꾸기 replace(타겟,바꿀대상, 대체할값)
select 'my dream is president' , replace('my dream is president', 'president' , 'teacher' ) from dual;
--중첩을 사용해서 공백을 지우고싶다면?
select replace(replace('my dream is president', 'president' , 'teacher'),' ','') from dual;
--replace를 통해 teacher로 바뀐 문자열이 다시 replace의 대상이 되는 구문

select replace(concat(first_name||' ',last_name), ' ', '' )from employees;

select replace('he llo w orld', ' ','') from dual;

