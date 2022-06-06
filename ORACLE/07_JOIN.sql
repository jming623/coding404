
select * from info;
select * from auth;

--INNER JOIN 이너조인
SELECT * FROM INFO  INNER JOIN AUTH ON INFO.ID = AUTH.ID;
--이너조인은 NULL값을 가지고있으면 출력되지 않는다.

select * from employees;

select * 
from employees e
inner join departments d
on e.department_id = d.department_id
where hire_date <= '10/01/01'
--GROUP BY
--HAVING
order by hire_date asc;

--SELECT문의 열을 선택할 때 ID만 쓰게되면 모호하다.(양쪽 테이블에 ID가 존재하기 때문에)
--이럴 떄 컬럼에 테이블이름.컬럼명 을 직접 지칭해서 정삭적으로 조회 합니다. 
SELECT BNO, TITLE , CONTENT , ID, NAME ,JOB
FROM INFO
INNER JOIN AUTH ON INFO.ID = AUTH.ID; 
--이렇게호출할 경우 열의 정의가 애매합니다 라는 오류가 발생한다.
--이유는 ID가 두개인데 어떤 ID를 호출할 것인지가 애매해서 발생한다. 아래처럼 실행하면 정상호출됨.
SELECT BNO, TITLE , CONTENT , INFO.ID, NAME ,JOB
FROM INFO
INNER JOIN AUTH ON INFO.ID = AUTH.ID; 

--테이블명이 길어지면 복잡해지는 상황에 대비하여 테이블에도 엘리어스 선언이 가능하다.
SELECT  BNO, TITLE, CONTENT , I.ID , NAME, JOB
FROM INFO I --INFO테이블을 I라는 별칭으로 쓰겠다
INNER JOIN AUTH A --AUTH테이블을 I라는 별칭으로 쓰겠다
ON I.ID = A.ID ;

--조건절은 INNER JOIN ~ ON ~ 이후에 
SELECT  BNO, TITLE, CONTENT , I.ID , NAME, JOB
FROM INFO I 
INNER JOIN AUTH A 
ON I.ID = A.ID
WHERE JOB ='전업주부'
--GROUP BY
--HAVING
ORDER BY BNO DESC;

--아우터 조인
--left outer join(왼쪽기준으로 정렬)
select * from info i left outer join auth a on i.id=a.id;

--right outer join(오른쪽기준으로 정렬)
select * from info i right outer join auth a on i.id=a.id;

select * from employees e right outer join departments d on e.department_id = d.department_id;
--사실 left,right join은 순서만 바꿔줘도 같아진다.(단 ,정렬순서는 바뀜)
select * from auth a left outer join info i on i.id=a.id;

--full outer join(양쪽 테이블이 다나옴.)
select * from info i full outer join auth a on i.id=a.id;
--from바로뒤에 오는 테이블 기준으로 null값 포함 호출한뒤 join뒤에오는 테이블 기준으로 null값 또한 호출해줌.

--cross join (잘못된 조인)
select * from info i cross join auth a;

--3개의 테이블도 조인이 될까요?
select * from employees;-- (pk:employee_id, fk:department_id)
select * from departments;--(pk:department_id , fk:location_id)
select * from locations;--(pk:location_id , fk:county_id)

select * 
from employees e 
left outer join departments d on e.department_id = d.department_id
left outer join locations l on d.location_id = l.location_id;