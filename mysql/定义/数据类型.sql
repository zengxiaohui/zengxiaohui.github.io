枚举ENUM：
	创建：
	CREATE TABLE Mysqlops_enum(ID INT NOT NULL AUTO_INCREMENT,
 		Job_type    ENUM('DBA','SA','Coding Engineer','JavaScript','NA','QA','','other') NOT NULL,
    	Work_City ENUM('shanghai','beijing','hangzhou','shenzhen','guangzhou','other') NOT NULL DEFAULT 'shanghai',
    	PRIMARY KEY(ID)
    )ENGINE=InnoDB CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
    插入值
	INSERT INTO Mysqlops_enum(ID,Job_type,Work_City) VALUES(2,'SA',''); 
	显示枚举所有可能的值
	show columns from Mysqlops_enum like 'Job_type'
	改变枚举所有可能的值
	ALTER TABLE  `Mysqlops_enum`  MODIFY COLUMN `Job_type` enum('a','b','c','d','e') ;

bigint
从 -2^63 (-9223372036854775808) 到 2^63-1 (9223372036854775807) 的整型数据（所有数字）。存储大小为 8 个字节。
P.S. bigint已经有长度了，在mysql建表中的length，只是用于显示的位数

int
	从 -2^31 (-2,147,483,648) 到 2^31 – 1 (2,147,483,647) 的整型数据（所有数字）。存储大小为 4 个字节。int 的 SQL-92 同义字为 integer。
	int（10）显示结果为0000000010
	int（3）显示结果为010

smallint
	从 -2^15 (-32,768) 到 2^15 – 1 (32,767) 的整型数据。存储大小为 2 个字节。

tinyint
	从 0 到 255 的整型数据。存储大小为 1 字节。

double:
	最大小数位为30 eg：double(50,30)

char（20） 类型 可以容纳20个字节，而英文每个字母是一个字节，可以容纳20个字符。中文一个汉字是2个字节，可以容纳10个汉字。最多可放255个字节

varchar最多可以存储65535个字节
varchar(20)最大可以存储20个字符
	abcdqwertyuioplkjhfg
	阿布大幅回升到了恢复高考结束高考房间的好

	utf8mb4最大长度15757个字符 65535/4
	utf8最大长度21009个字符  	65535/3
	gbk最大长度31514个字符    65535/2

text最多可以存储65535个字节
	能存至少35635个字符
