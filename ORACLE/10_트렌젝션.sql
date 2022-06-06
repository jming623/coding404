--오토커밋 확인
show autocommit;
--오토커밋 ON
set autocommit on;--오토커밋이 되어있다면 추가변경삭제를 하는 순간 적용이됨. (굉장히 위험)
--오토커밋 OFF
set autocommit off; 

select * from depts;

delete from depts where department_id = 10;
savepoint del1; --첫번째 저장지점(save point) 생성.

delete from depts where department_id = 20;
savepoint del2; --두번째 저장지점(save point) 생성.

rollback; --하면 삭제된 department_id 10,20번의 정보가 다시 나타난다.
rollback to del1; --department_id 20번의 정보가 삭제되기 전인 11행까지의 결과만을 저장하는 상태로 돌아간다.
rollback to del2; --14행까지의 결과만을 저장한 상태로 돌아가지만 이미 모두 삭제된 이후이기때문에 결과는 같다.

commit; --진짜로 반영!(커밋이후에는 어떤 방법을 쓰더라도 되돌릴 수 없음.)