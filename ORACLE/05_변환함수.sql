--�� ��ȯ �Լ� TO_CHAR TO_DATE TO_NUMBER

--TO_CHAR (��¥�� ���ڷ� ���� OR ���ڸ� ���ڷ� ����)

--to_char(date,'pmt') ��¥�� ���ڷ� (YY-MM-DD HH:MI:SS)
select to_char(sysdate) from dual;
select to_char(sysdate,'YYYY"��"MM"��"DD"��"') from dual;-- (-,/,:,(����)�ܿ� �ٸ� ���ڴ� ""������ ���Ұ��� )
select to_char(sysdate,'YYYY-MM-DD') from dual; -- (-,/,:,(����)��""������ ��밡�� )
select to_char(sysdate, 'YY-MM-DD HH:MI:SS') from dual; 
select to_char(sysdate, 'YYYY"��"MM"��"DD"��" HH24"��"MI"��"SS"��"') from dual;

select first_name, hire_date from employees;
select first_name, to_char(hire_date,'YYYY-MM-DD') from employees;
-- to_char(hire_date,'YYYY-MM-DD')�̷��� ���� ���� ��û ����.
select first_name , to_char(hire_date , 'YY-MM-DD HH24:mi:ss') from employees;
select first_name , to_char(hire_date, 'YYYY"��" MM"��" DD"��"')from employees;

--to_char(number,'pmt') ���ڸ� ���ڷ� (9,.,,)
select to_char(20000,'99999') from dual;  --9�� �ڸ��� (�ſ��߿�) (�ڸ����� �����ϰ� �ָ� ####���� ��µȴ�.)
select to_char(20000.14,'99999.99') from dual; -- .�� �Ҽ��� �ڸ��� �ǹ�
select to_char(20000.14 , '99,999.99') from dual; -- ,�� �޸��� ǥ�� ����
select to_char(20000.14 , 'L99,999.99') from dual; --L�� ����ȭ�� ��ȣ ǥ�� ����
select to_char(20000.14 , '$99,999.99')from dual; -- �޷��� �׳� $ �����ָ��.

select first_name,to_char(salary,'$999,999.99') from employees;

--to number(����, ��������) ���ڸ� ���ڷ� (����ǥ���Ŀ��� �������� �ʴ� ������ �ٲ� �� ����.)
select '2000' + 2000 from dual; --��� ������ ���ڿ��� ���ڷ� �ڵ�����ȯ�� ���� 
select to_number('2000')+2000 from dual;  --�� �� ������(?,��������?) ǥ��

-- select '$3,300'+ 2000 from dual; $��ȣ������ ����ȯ�� �ȵ�
select to_number('$3,300' , '$9,999')+2000 from dual; -- ���� ����ǥ�������� $��ȣ�� ������ �ٽ� ������ �߻���Ŵ

select to_number(to_char(3300 , 'L9,999.99') ,'L9,999.99')from dual;
select to_char(3300 , 'L9,999.99') from dual;


--to date(����, ��¥ǥ������) ���ڸ� ��¥�� (��¥ǥ�����Ŀ��� �������� �ʴ� ������ �ٲ� �� ����.)
select to_date( '2021/03/31' ) from dual; --��� ��¥�� ���ڿ��� ��¥�� �ڵ�����ȯ�� ����
select sysdate - to_date('21/03/30') from dual; --�ϼ� 
--�ڵ�����ȯ�� �����ϱ�� ������  sysdate - '21/03/30'  �̷��Դ� �ȵǰ� to_date()�ȿ� �־��־�� �Ѵ�.

select to_date('2021/03/25' , 'YYYY/MM/DD') from dual; ----�� �� ������(?,��������?) ǥ��
select to_date('2021-03-25 14:51:24') from dual; --�������� �ڵ�����ȯ�� ��������
select to_date('2021-03-25 14:51:24' , 'YYYY-MM-DD HH24:MI:SS') from dual;

-- '20201130' ,'20201111'  ������ ���̳����� ���ϱ�
select to_date('20201130') - to_date('20201111') from dual; --��¥������ �������� 19�� ȣ���.
select to_date('20201130' , 'YYYYMMDD') - to_date('20201111' , 'YYYYMMDD') from dual; -- ���� �������� ǥ��
select '20201130' - '20201111' from dual; --���ڿ��� ���ڷ� �ڵ�����ȯ�Ǽ� ���ڳ����� �������� 19�� ȣ���.

-- xxxx��xx��xx�� �� ���
select to_date('20051002','YYYY"��"MM"��"DD"��"') from dual;--(X) ��,��,���� ���� date������ �ƴ�.

select to_char(to_date('20051002','YYYYMMDD'),'YYYY"��"MM"��"DD"��"')
as "xxxx��xx��xx�� ����" 
from dual; --(O) to_char(date,'pmt')����


-- NVL �Լ�
--nvl(�÷�, null�ϰ�� ��ȯ�Ұ�) - �ڡڡڡڡ�
select nvl(200, 0),nvl(null, 0) from dual;
select first_name , nvl(commission_pct, 0) as commission_pct from employees; --commission_pct�� null�̸� 0���� �����.

--nvl2(�÷�, null�� �ƴҰ�� ��ȯ�Ұ� , null�ϰ�� ��ȯ�Ұ�) - �ڡڡڡڡ�
select nvl2(null, 'null�ƴ�' , 'null��') from dual; --ù��° ���� null�̶�� 3��° ���� ����ǰ� �ƴ϶�� 2��° ���� �����.

select nvl2(commission_pct,'yes','no')from employees;

select first_name , 
       commission_pct,
       nvl2(commission_pct, salary +(salary * commission_pct) , salary ) 
from employees;


--decode (�÷�, �� , ��� , ��, ���... , default) - �ڡڡڡڡ� (if - else if - else)������ ���
select decode('C' , 'A', 'A�Դϴ�.' , 'B' , 'B�Դϴ�.' , 'C', 'C�Դϴ�.' , '���ξƴմϴ�.') FROM DUAL;
select decode('D' , 'A', 'A�Դϴ�.' , 'B' , 'B�Դϴ�.' , 'C', 'C�Դϴ�.' , '���ξƴմϴ�.') FROM DUAL;

select sysdate-1 from dual;
select decode(sysdate-1,'21/06/19','�����Դϴ�.','21/06/20','�����Դϴ�.','21/06/18','�����Դϴ�.')from dual;

SELECT FIRST_NAME , 
       SALARY,
       JOB_ID,
       DECODE(JOB_ID,'IT_PROG', SALARY * 0.5, 'AD_VP', SALARY * 0.4 , SALARY * 0.1) --������� �������̱⶧���� ���� ���ް� ���ؼ� ����ص� �ɵ�.
FROM EMPLOYEES;

--CASE~WHEN~THEN���� ...ELSE~END
--CASE �� WHEN �� THEN ��� ...ELSE ��� END

select first_name,
       job_id,
       salary as ����,       
       (case job_id when 'IT_PROG' then salary * 0.5
                    when 'AD_VP' then salary * 0.4
                    when 'AD_ASST' then salary * 0.6
                    else salary*0.1
        end) as ���ʽ�
from employees;
        


