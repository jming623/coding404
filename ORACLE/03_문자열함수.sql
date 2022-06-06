 --dual�� �������̺�
select 'hello world', 'SQL' from dual;

--���� ���� �Լ�
--lower , upper , initcap

select lower('hello WORLD') , upper('hello WORLD') , initcap ('hello WORLD') from dual;

select lower(first_name), upper(first_name), initcap(first_name)  from employees;

--�Լ��� where���ǿ��� ���ϴ�.
select * from employees where lower(first_name) = 'ellen';  --������ ã����
select * from employees where first_name = 'ellen';  --������ ã����������

-- length() ���ڿ� ���� , instr() ���ڿ� ã��
select 'abcdef' ,length('abcdef') , instr('abcdef', 'b') from dual; --abcdef�÷��� b�� ���۵Ǵ� ��ġ
--instr(  ,  )ù��° ���� ��� �ι�° ���� ã�� ��  

select first_name , length(first_name), instr(first_name, 'a') from employees;


--concat(��,��) ���ڿ� ������, substr(Ÿ��, �����ε���, �ڸ�����) ���ڿ� �ڸ���

select concat('hello' , 'world') from dual; --�����߰��� ���� �� �ٸ� ���� �ְ�ʹٸ� ��� �ؾ��ұ� 
--concat�� �Ű������� ���� 3���� �־��ټ��� ������ ��ø�� ����Ѵ�.
select concat(concat('hello' , ' crazy '),'world') from dual;

select 'hello' ||'world' from dual; --���� �̷��Ե� ����� �ֱ��ϴ�.

select substr('abcdef',2,5) from dual;
--�̷��� �ϸ� �׻� ���������� �߶��� �� �ֳ�? length - (���۰�-1)  (�����ʿ�)
select substr('abcdef',2 ,length('abcdef')- 1) from dual;

select first_name, concat(first_name , last_name), substr(first_name, 1 , 3) from employees;


-- LPAD , RPAD ��,���� ������ ���ڿ��� ä���
select 'abc' ,lpad('abc',10,'*') from dual; -- lpad(Ÿ��, �ִ��ڸ��� , �����ڸ��� ä�ﰪ) 
--�̹� abc3���ǰ��� �־ *�� ���ʿ� 7���� �����.
select 'abc', rpad('abc',10, '*') from dual;


-- LTRIM, RTRIM, TRIM �������� ���ʰ�������, ������ ��������, ���� ��������
select '    hello world    ', LTRIM('    hello world    ') from dual;--���� ���鸸 ���ŵǾ���.
select '    hello world    ', RTRIM('    hello world    ') from dual;--������ ���鸸 ���ŵǾ���.
select '    hello world    ', TRIM('    hello world    ') from dual;--���� ������ ��� ���ŵǾ���.


--replace() ���ڿ� �ٲٱ� replace(Ÿ��,�ٲܴ��, ��ü�Ұ�)
select 'my dream is president' , replace('my dream is president', 'president' , 'teacher' ) from dual;
--��ø�� ����ؼ� ������ �����ʹٸ�?
select replace(replace('my dream is president', 'president' , 'teacher'),' ','') from dual;
--replace�� ���� teacher�� �ٲ� ���ڿ��� �ٽ� replace�� ����� �Ǵ� ����

select replace(concat(first_name||' ',last_name), ' ', '' )from employees;

select replace('he llo w orld', ' ','') from dual;

