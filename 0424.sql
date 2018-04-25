drop database shop;
create database shop;
alter database shop default character set utf8 collate utf8_bin;
use shop;
create table`商品表`
(
`商品编号`  char(4) primary key,
`商品名称`  varchar(100),
`单价`      float,
`库存数量`  int
);
create  table`客户表` 
(
客户编号       char(4) primary key ,
客户名称       char(20) ,
电话           char(20)
);
create table`订单表`
(
订单编号         int primary key auto_increment ,
商品编号         char(4) not null ,
客户编号         char(4) not null ,
订购时间         datetime ,
订购数量         int ,
金额             float
);
truncate table`商品表`;
truncate table`订单表`;
insert into `商品表`(`商品编号`,`商品名称`,`单价`,`库存数量`)
values('A001','无线鼠标',40,500),
('A002','笔记本电脑',5500,50),
('A003','台式电脑',3500,120),
('A004','投影仪',4000,70),
('A005','空调',2500,200);
insert into `客户表`(`客户编号`,`客户名称`,`电话`)
values('U001','王五','13012345678'),
('U002','张三','18976541238'),
('U003','李四','028-8777666'),
('U004','李红',null),
('U005','电商代购','010-53124569');

update `商品表` set `单价` = `单价` * 1.1 where `商品编号` = 'A001';
update `商品表` set `库存数量` = `库存数量` + 100 where `库存数量` < 100;

start transaction;
update `商品表` set `库存数量` = `库存数量` - 50;
insert into `订单表` select null,`商品编号`,'U002',now(),50,`单价`*50 from `商品表`;
commit;

start transaction;
update `商品表` set `库存数量` = `库存数量` - 10 where `商品编号` = 'A004';
update `商品表` set `库存数量` = `库存数量` - 50 where `商品编号` = 'A002';
update `商品表` set `库存数量` = `库存数量` - 30 where `商品编号` = 'A003' ;
update `商品表` set `库存数量` = `库存数量` - 20 where `商品编号` = 'A005';
insert into `订单表` select null,`商品编号`,'U005',now(),10,`单价`*10 from `商品表` where `商品编号` = 'A004';
insert into `订单表` select null,`商品编号`,'U001',now(),50,`单价`*50 from `商品表` where `商品编号` = 'A002';
insert into `订单表` select null,`商品编号`,'U004',now(),30,`单价`*30 from `商品表` where `商品编号` = 'A003';
insert into `订单表` select null,`商品编号`,'U004',now(),20,`单价`*20 from `商品表` where `商品编号` = 'A005';
commit;

--4.1
select * from `订单表` order by `金额` desc;
--4.2
select * from `商品表` where `库存数量` < 100;
--4.3
select `客户名称`,`电话` from `客户表` where `电话` like '%-%';
--4.4
select sum(`库存数量`) `库存总量` from `商品表`;
--4.5
select A.`客户编号`,B.`客户名称`, count(A.`订单编号`) `订单数` 
from `订单表` A join `客户表` B
on A.`客户编号` = B.`客户编号`
where B.`客户编号` = 'U002';
--4.6
select A.`客户编号`,B.`客户名称`,A.`订购数量`,A.`金额` 
from `订单表`A join `客户表`B
on A.`客户编号` = B.`客户编号`
where B.`客户名称` = '张三'
having A.`金额` > 4000;
--4.7
select * from `客户表`
where `客户编号` not in (select `客户编号` from `订单表`);
--4.8
select `客户编号`,sum(`金额`)`总金额` from `订单表` group by `客户编号`;
--4.9
select B.`商品名称`,sum(A.`订购数量`) `订购总量` 
from `订单表`A join `商品表`B
on A.`商品编号` = B.`商品编号`
group by A.`商品编号`
having `订购总量` > 100;
--4.10
delete from `订单表`
where `客户编号` in (select `客户编号` from `客户表` where `电话` is null);

select * from `客户表` where `电话` is null;