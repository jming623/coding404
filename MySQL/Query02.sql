## myweb에 FreeBoardMapper 

## mysql에서 rownum사용하기 위해서는 @rownum := @rownum +1 rn로 쓰고 같은레벨에서 초기화가 필요합니다. (select @rownum := 0) c
## mysql에서 서브쿼리절에는 엘리어스가 필수입니다.

select *
from(select @rownum := @rownum + 1 rn,
			a.*
	 from(select *
		  from freeboard
		  where 1=1
		  order by bno desc) a
) b ,(select @rownum := 0) c
where rn > 0 and rn <= 10;


insert into FREEBOARD(title,writer,content)
		 values('test', 'admin', 'admin');
commit;


## mysql에 select sysdate from dual -> select now()

select now();


## mysql에 trunc() -> truncate() ## truncate()는 반드시 버릴자릿수를 명시해주어야합니다.
## mysql에 to_char() -> date_format() ## %Y%m%d%H%i%s .년월일시분초
## mysql에서는 ||를 사용할 수없다 concat(,)사용해줘야함

select *
from(select @rownum := @rownum +1 rn,
            a.*,
			case when gap <= 60 then '방금전'
			when gap <= 60 * 24 then concat(truncate(gap / 60, 0),'시간전')
			else date_format(replydate,'%Y-%m-%d')
			end as timegap
      from(select bno,
                  rno,
                  reply,
				  replyid,
                  replydate,
                  updatedate,
                  truncate( (now() - replydate) / 60, 0)  as gap
		   from FREEREPLY where bno = 1 order by rno desc ) a 
	  ) b, (select @rownum := 0) c
where rn > 0 and rn <= 10;

select * from FREEREPLY;

insert into FREEREPLY (bno,reply,replyId,replyPw) values(1,'test','admin','admin');
commit;

insert into FREEREPLY (bno,reply,replyId,replyPw) values(2,'test','admin','admin');

select * from users;



