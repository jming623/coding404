--����Ŀ�� Ȯ��
show autocommit;
--����Ŀ�� ON
set autocommit on;--����Ŀ���� �Ǿ��ִٸ� �߰���������� �ϴ� ���� �����̵�. (������ ����)
--����Ŀ�� OFF
set autocommit off; 

select * from depts;

delete from depts where department_id = 10;
savepoint del1; --ù��° ��������(save point) ����.

delete from depts where department_id = 20;
savepoint del2; --�ι�° ��������(save point) ����.

rollback; --�ϸ� ������ department_id 10,20���� ������ �ٽ� ��Ÿ����.
rollback to del1; --department_id 20���� ������ �����Ǳ� ���� 11������� ������� �����ϴ� ���·� ���ư���.
rollback to del2; --14������� ������� ������ ���·� ���ư����� �̹� ��� ������ �����̱⶧���� ����� ����.

commit; --��¥�� �ݿ�!(Ŀ�����Ŀ��� � ����� ������ �ǵ��� �� ����.)