delete from 表 where 字段=？ or ....
update 表 set 字段 = ？, .... where id = ?
select * from 表 where id = ?
INSERT INTO tbl_name (col1,col2) VALUES(15,col1*2); 
创建数据库：
CREATE DATABASE IF NOT EXISTS `mms` DEFAULT CHARACTER SET utf8; 
导入sql给数据库：
	mysql>use database_name 
	mysql>source d:\datafilename.sql 

查询最后一行数据：
	SELECT * FROM customer ORDER BY customerId DESC LIMIT 1;

初始化表：truncate table '表名'

查询某表中某列是否含有相同的某行数据：
SELECT customerCardId,count(*) as count FROM customer GROUP BY customerCardId HAVING count>1;

bigint(20)数字长度 最大20位
20bit吗，还是能输入20个数字
是你输入的数字的长度 ，也就是位数  -2^63 (-9,223,372,036,854,775,808) 至 2^63-1 (9,223,372,036,854,775,807)   它的范围是20位数字

varchar(3)
非空CHAR的最大总长度是255【字节】；非空VARCHAR的最大总长度是65533【字节】，超过5000个字符就用text

重命名表：ALTER TABLE i_origin_move RENAME AS o_origin_move

将列转为一行
select GROUP_CONCAT(start_pin_id, ",",end_pin_id)
	from t_origin_move AS o
WHERE
	collinfo_id=826 AND origin_type=true

	删除表
DROP TABLE  tbl_name;
或者是
DROP TABLE IF EXISTS tbl_name;

显示用户权限：
show grants for lixiang@"192.168.1.230";
赋予用户执行存储过程的权限：
grant execute on report1.* to 'lixiang'@'192.168.1.230';

乱序排序：ORDER BY RAND()

去除括号和括号里的内容："18611497688(本人)" -> 18611497688
	select 
		case 
    when instr(customerTele,'(') and instr(customerTele,')') then 
        concat(left(customerTele, instr(customerTele,'(')-1),substr(customerTele, instr(customerTele,')')+1))
    when instr(customerTele,'(') then  left(customerTele, instr(customerTele, '(')-1)
    when instr(customerTele, ')') then  substr(customerTele, instr(customerTele, ')')+1)
    else customerTele
    end
from customer