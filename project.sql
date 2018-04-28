-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-12-29 15:56:02
-- 服务器版本： 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alter_info_student` (IN `s_id` VARCHAR(10), IN `birth` DATE, IN `tele` VARCHAR(11))  NO SQL
BEGIN
UPDATE student SET birthday=birth,telephone=tele WHERE sid=s_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `alter_info_teacher` (IN `t_id` VARCHAR(10), IN `birth` DATE, IN `tele` VARCHAR(11))  NO SQL
BEGIN
UPDATE teacher SET birthday=birth,telephone=tele WHERE tid=t_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `change_password_student` (IN `s_id` VARCHAR(10), IN `pw` VARCHAR(32))  NO SQL
BEGIN
UPDATE student SET passwd=MD5(pw) WHERE sid=s_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `change_password_teacher` (IN `t_id` VARCHAR(10), IN `pw` VARCHAR(12))  NO SQL
BEGIN
UPDATE teacher SET passwd=MD5(pw) WHERE tid=t_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countStudent` (IN `c_id` VARCHAR(10), IN `date` DATE)  NO SQL
BEGIN
SELECT statu,ifnull(count(*),0) FROM student_sign WHERE student_sign.cid=c_id AND student_sign.sign_time=date GROUP BY statu;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createSignIn` (IN `c_id` VARCHAR(10))  NO SQL
    COMMENT '创建签到'
BEGIN
INSERT INTO course_sign VALUES (c_id,format(now(),'YYYY-MM-DD'));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_student` (IN `s_id` VARCHAR(10), IN `s_name` VARCHAR(10), IN `s_sex` VARCHAR(10), IN `birth` DATE, IN `tele` VARCHAR(11), IN `col_id` VARCHAR(10))  NO SQL
BEGIN
INSERT INTO student VALUES(s_id,s_name,s_sex,birth,tele,col_id,null);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_teacher` (IN `t_id` VARCHAR(10), IN `t_name` VARCHAR(10), IN `t_sex` VARCHAR(10), IN `birth` DATE, IN `t_rank` VARCHAR(10), IN `tele` VARCHAR(11), IN `t_colid` VARCHAR(10))  NO SQL
BEGIN
INSERT INTO teacher VALUES(t_id,t_name,t_sex,birth,t_rank,tele,t_colid,null);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCourse` (IN `c_id` VARCHAR(10), IN `c_name` VARCHAR(20), IN `t_id` VARCHAR(10), IN `credit` DOUBLE, IN `position` VARCHAR(20), IN `col_id` VARCHAR(10))  NO SQL
    COMMENT '插入课程'
BEGIN
SET @result='';
IF EXISTS (SELECT * FROM course WHERE cid=c_id) THEN
SET @result='Course ID exist.';
ELSEIF NOT EXISTS (SELECT * FROM teacher WHERE tid=t_id) THEN
SET @result='Teacher ID not exist.';
ELSEIF NOT EXISTS (SELECT * FROM college WHERE colid=col_id) THEN
SET @result='College ID not exist.';
ELSE
INSERT INTO course VALUES (c_id,c_name,t_id,credit,position,col_id);

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_student` (IN `s_id` VARCHAR(10), IN `password` VARCHAR(12))  NO SQL
BEGIN
SELECT * FROM student WHERE sid=s_id AND passwd=md5(password);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_teacher` (IN `t_id` VARCHAR(10), IN `password` VARCHAR(12))  NO SQL
BEGIN
SELECT * FROM teacher WHERE tid=t_id AND passwd=md5(password);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_allsignIn_student` (IN `s_id` VARCHAR(10))  NO SQL
BEGIN
SELECT course.cid,cname,tname,colname,credit,sign_time,student_sign.statu FROM course,college,teacher,student_course,student,student_sign WHERE course.colid=college.colid AND course.tid=teacher.tid AND student_course.sid=student.sid AND student_course.cid=course.cid AND student_sign.sid=student.sid AND student_sign.cid=course.cid AND student.sid=s_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_allsignIn_teacher` (IN `t_id` VARCHAR(10))  NO SQL
BEGIN
SELECT course.cid,cname,colname,sign_time FROM course,college,course_sign WHERE course.colid=college.colid AND course.tid=t_id AND course_sign.cid=course.cid;
END$$

CREATE DEFINER=`koroti`@`localhost` PROCEDURE `show_coursesign_teacher` (IN `c_id` VARCHAR(10), IN `signtime` DATE)  NO SQL
BEGIN
SELECT student.sid,sname,cname,sign_time,statu FROM student_sign,student,course WHERE course.cid=c_id AND sign_time=signtime AND student.sid=student_sign.sid AND student_sign.cid=course.cid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_course_student` (IN `s_id` VARCHAR(10))  NO SQL
    COMMENT '打印课程信息（学生）'
BEGIN
SELECT course.cid,cname,tname,colname,position,credit FROM course,college,teacher,student_course,student WHERE course.colid=college.colid AND course.tid=teacher.tid AND student_course.sid=student.sid AND student_course.cid=course.cid AND student.sid=s_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_course_teacher` (IN `t_id` VARCHAR(10))  NO SQL
    COMMENT '打印课程信息（老师）'
BEGIN
SELECT cid,cname,colname,position,credit FROM course,college WHERE course.colid=college.colid AND course.tid=t_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_info_student` (IN `s_id` VARCHAR(10))  NO SQL
BEGIN
SELECT sid,sname,sex,birthday,telephone,colname FROM student,college WHERE sid=s_id AND student.colid=college.colid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_info_teacher` (IN `t_id` VARCHAR(10))  NO SQL
BEGIN
SELECT tid,tname,sex,birthday,rank,telephone,colname FROM teacher,college WHERE tid=t_id AND teacher.colid=college.colid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_signIn_student` (IN `s_id` VARCHAR(10), IN `c_id` VARCHAR(10))  NO SQL
BEGIN
SELECT * FROM student_sign WHERE sid=s_id AND cid=c_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_signIn_teacher` (IN `c_id` VARCHAR(10))  NO SQL
    COMMENT '打印出课程的签到时间（老师）'
BEGIN
SELECT course.cid,cname,colname,credit,sign_time FROM course,college,course_sign WHERE course.colid=college.colid AND course.cid=c_id AND course_sign.cid=course.cid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_signList` (IN `c_id` VARCHAR(10))  NO SQL
    COMMENT '展示上课学生名单'
BEGIN
SELECT student.sid,sname,sex,colname from student,student_course,college WHERE student.sid=student_course.sid AND student.colid=college.colid AND student_course.cid=c_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sign_student` (IN `s_id` VARCHAR(10), IN `c_id` VARCHAR(10), IN `_statu` VARCHAR(10))  NO SQL
BEGIN
INSERT INTO student_sign VALUES(s_id,c_id,CURDATE(),_statu);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sign_teacher` (IN `c_id` VARCHAR(10))  NO SQL
BEGIN
INSERT INTO course_sign VALUES(c_id,CURDATE());
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `college`
--

CREATE TABLE `college` (
  `colid` varchar(10) COLLATE utf8_bin NOT NULL,
  `colname` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `college`
--

INSERT INTO `college` (`colid`, `colname`) VALUES
('0001', '计算机与软件学院'),
('0002', '社会与心理学院'),
('0003', '数学与统计学院'),
('0004', '外国语学院'),
('0005', '建筑与规划学院'),
('0006', '经济学院'),
('0007', '法学院'),
('0008', '医学院'),
('150', '计算机与软件学院');

--
-- 触发器 `college`
--
DELIMITER $$
CREATE TRIGGER `after_delete_college` AFTER DELETE ON `college` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"college","delete",old.colid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_college` AFTER INSERT ON `college` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"college","insert",new.colid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_college` AFTER UPDATE ON `college` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"college","update",old.colid);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `course`
--

CREATE TABLE `course` (
  `cid` varchar(10) COLLATE utf8_bin NOT NULL,
  `cname` varchar(20) COLLATE utf8_bin NOT NULL,
  `tid` varchar(10) COLLATE utf8_bin NOT NULL,
  `credit` double NOT NULL,
  `position` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `colid` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `course`
--

INSERT INTO `course` (`cid`, `cname`, `tid`, `credit`, `position`, `colid`) VALUES
('0001', '程序设计', '0000169115', 3, 'L1-609', '0001'),
('0002', '数据库', '0000169115', 3, 'L3-309', '0001'),
('0003', '软件工程', '0000155489', 2, 'L2-210', '0001'),
('0004', '互联网', '0000155489', 3, 'L3-404', '0001'),
('0005', 'JAVA', '0000155489', 2, 'L3-312', '0001'),
('0006', '马克思主义', '0000144159', 2, 'L4-202', '0002'),
('0007', '高等数学', '0000153221', 4, 'L1-409', '0003'),
('0008', '线性代数', '0000131664', 3, 'L1-302', '0003'),
('0009', '毛概', '0000144159', 3, 'L3-309', '0002'),
('1', '程序设计', '1', 3, 'L1-303', '150'),
('2', '数据库', '1', 3, 'L1-603', '150'),
('3', 'Java', '2', 2, 'L3-404', '150');

--
-- 触发器 `course`
--
DELIMITER $$
CREATE TRIGGER `after_delete_course` AFTER DELETE ON `course` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"course","delete",old.cid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_course` AFTER INSERT ON `course` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"course","insert",new.cid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_course` AFTER UPDATE ON `course` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"course","update",old.cid);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `course_sign`
--

CREATE TABLE `course_sign` (
  `cid` varchar(10) COLLATE utf8_bin NOT NULL,
  `sign_time` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `course_sign`
--

INSERT INTO `course_sign` (`cid`, `sign_time`) VALUES
('0001', '2017-12-25'),
('0001', '2017-12-27'),
('0001', '2017-12-28'),
('0001', '2017-12-29'),
('0002', '2017-12-27'),
('0002', '2017-12-28'),
('0002', '2017-12-29'),
('0003', '2017-12-27'),
('0003', '2017-12-29'),
('0006', '2017-12-25'),
('0006', '2017-12-27'),
('0009', '2017-12-25'),
('0009', '2017-12-27');

-- --------------------------------------------------------

--
-- 表的结构 `logs`
--

CREATE TABLE `logs` (
  `logid` int(5) NOT NULL,
  `who` varchar(50) COLLATE utf8_bin NOT NULL,
  `time` datetime NOT NULL,
  `table_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `operation` varchar(6) COLLATE utf8_bin NOT NULL,
  `key_value` varchar(20) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `logs`
--

INSERT INTO `logs` (`logid`, `who`, `time`, `table_name`, `operation`, `key_value`) VALUES
(1, 'koroti@localhost', '2017-12-27 21:51:43', 'college', 'delete', 'p007'),
(2, 'root@localhost', '2017-12-27 21:52:26', 'college', 'insert', 'p007'),
(3, 'koroti@localhost', '2017-12-27 21:53:04', 'college', 'delete', 'p007'),
(4, 'root@localhost', '2017-12-27 22:02:09', 'student_course', 'insert', '017_3'),
(5, 'root@localhost', '2017-12-27 22:03:02', 'student_course', 'delete', '017_3'),
(6, 'koroti@localhost', '2017-12-28 19:50:34', 'college', 'update', '0005');

-- --------------------------------------------------------

--
-- 表的结构 `student`
--

CREATE TABLE `student` (
  `sid` varchar(10) COLLATE utf8_bin NOT NULL,
  `sname` varchar(10) COLLATE utf8_bin NOT NULL,
  `sex` varchar(6) COLLATE utf8_bin NOT NULL,
  `birthday` date DEFAULT NULL,
  `telephone` varchar(11) COLLATE utf8_bin DEFAULT NULL,
  `colid` varchar(10) COLLATE utf8_bin NOT NULL,
  `passwd` varchar(32) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `student`
--

INSERT INTO `student` (`sid`, `sname`, `sex`, `birthday`, `telephone`, `colid`, `passwd`) VALUES
('017', '123', '男', '1996-02-02', '13123456789', '150', '738cccd4fda172441f216712a488dca6'),
('2014153945', 'ccb', '女', '1994-06-07', '13123456798', '0002', '63eee26c83c84146542725a943efb032'),
('2014157541', 'pyy', '女', '1995-04-07', '18123456789', '0004', '7fcafc07c16445490d5897609c36f214'),
('2015150017', 'wzy', '男', '1996-11-17', '18123456789', '0001', '0fb7babf409c3bbc10bb3c4e60eebe0e'),
('2015150227', 'zhy', '男', '1996-01-16', '18123456789', '0001', 'e1f8053031ffc3086016274dabd0f083'),
('2016250211', 'fph', '女', '1997-08-17', '18123456789', '0001', 'a9fc21ef2caa043762ab45a686214fc5'),
('2016588457', 'zfq', '男', '1997-03-27', '13123456798', '0005', 'a3aefe4221583e1c49e2e4ab287143ce'),
('2017566123', 'gyd', '男', '1999-09-09', '18123456789', '0001', '73e473a31ea094928003e1fd337ff5b9'),
('227', '123', '男', '1996-11-19', '13123456789', '150', 'e10adc3949ba59abbe56e057f20f883e');

--
-- 触发器 `student`
--
DELIMITER $$
CREATE TRIGGER `after_delete_student` AFTER DELETE ON `student` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"student","delete",old.sid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_student` AFTER INSERT ON `student` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"student","insert",new.sid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_student` AFTER UPDATE ON `student` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"student","update",old.sid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `createStudentPasswd` BEFORE INSERT ON `student` FOR EACH ROW BEGIN
SET new.passwd=md5(RIGHT(new.sid,6));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `student_course`
--

CREATE TABLE `student_course` (
  `sid` varchar(10) COLLATE utf8_bin NOT NULL,
  `cid` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `student_course`
--

INSERT INTO `student_course` (`sid`, `cid`) VALUES
('2014153945', '0001'),
('2014157541', '0001'),
('2015150017', '0001'),
('2015150227', '0001'),
('2016250211', '0001'),
('2016588457', '0001'),
('2017566123', '0001'),
('2014153945', '0002'),
('2014157541', '0002'),
('2015150017', '0002'),
('2015150227', '0002'),
('2016250211', '0002'),
('2016588457', '0002'),
('2017566123', '0002'),
('2015150227', '0003'),
('2015150227', '0006'),
('2015150227', '0009'),
('017', '1'),
('227', '1'),
('017', '2'),
('227', '2'),
('227', '3');

--
-- 触发器 `student_course`
--
DELIMITER $$
CREATE TRIGGER `after_delete_student_course` AFTER DELETE ON `student_course` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"student_course","delete",CONCAT(old.sid,"_",old.cid));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_student_course` AFTER INSERT ON `student_course` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"student_course","insert",CONCAT(new.sid,"_",new.cid));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_student_course` AFTER UPDATE ON `student_course` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"student_course","update",CONCAT(old.sid,"_",old.cid));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `student_sign`
--

CREATE TABLE `student_sign` (
  `sid` varchar(10) COLLATE utf8_bin NOT NULL,
  `cid` varchar(10) COLLATE utf8_bin NOT NULL,
  `sign_time` date NOT NULL,
  `statu` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `student_sign`
--

INSERT INTO `student_sign` (`sid`, `cid`, `sign_time`, `statu`) VALUES
('2014153945', '0001', '2017-12-25', '出勤'),
('2014153945', '0001', '2017-12-27', '出勤'),
('2014153945', '0001', '2017-12-28', '出勤'),
('2014153945', '0001', '2017-12-29', '出勤'),
('2014153945', '0002', '2017-12-27', '缺勤'),
('2014153945', '0002', '2017-12-28', '出勤'),
('2014153945', '0002', '2017-12-29', '请假'),
('2014157541', '0001', '2017-12-25', '请假'),
('2014157541', '0001', '2017-12-27', '缺勤'),
('2014157541', '0001', '2017-12-28', '出勤'),
('2014157541', '0001', '2017-12-29', '缺勤'),
('2014157541', '0002', '2017-12-27', '出勤'),
('2014157541', '0002', '2017-12-28', '出勤'),
('2014157541', '0002', '2017-12-29', '出勤'),
('2015150017', '0001', '2017-12-25', '出勤'),
('2015150017', '0001', '2017-12-27', '出勤'),
('2015150017', '0001', '2017-12-28', '请假'),
('2015150017', '0001', '2017-12-29', '出勤'),
('2015150017', '0002', '2017-12-27', '出勤'),
('2015150017', '0002', '2017-12-28', '缺勤'),
('2015150017', '0002', '2017-12-29', '出勤'),
('2015150227', '0001', '2017-12-25', '出勤'),
('2015150227', '0001', '2017-12-27', '出勤'),
('2015150227', '0001', '2017-12-28', '出勤'),
('2015150227', '0001', '2017-12-29', '出勤'),
('2015150227', '0002', '2017-12-27', '出勤'),
('2015150227', '0002', '2017-12-28', '出勤'),
('2015150227', '0002', '2017-12-29', '出勤'),
('2015150227', '0003', '2017-12-27', '出勤'),
('2015150227', '0003', '2017-12-29', '缺勤'),
('2015150227', '0006', '2017-12-25', '请假'),
('2015150227', '0006', '2017-12-27', '出勤'),
('2015150227', '0009', '2017-12-25', '请假'),
('2015150227', '0009', '2017-12-27', '缺勤'),
('2016250211', '0001', '2017-12-25', '出勤'),
('2016250211', '0001', '2017-12-27', '请假'),
('2016250211', '0001', '2017-12-28', '缺勤'),
('2016250211', '0001', '2017-12-29', '出勤'),
('2016250211', '0002', '2017-12-27', '出勤'),
('2016250211', '0002', '2017-12-28', '出勤'),
('2016250211', '0002', '2017-12-29', '出勤'),
('2016588457', '0001', '2017-12-25', '缺勤'),
('2016588457', '0001', '2017-12-27', '出勤'),
('2016588457', '0001', '2017-12-28', '出勤'),
('2016588457', '0001', '2017-12-29', '出勤'),
('2016588457', '0002', '2017-12-27', '请假'),
('2016588457', '0002', '2017-12-28', '请假'),
('2016588457', '0002', '2017-12-29', '出勤'),
('2017566123', '0001', '2017-12-25', '出勤'),
('2017566123', '0001', '2017-12-27', '出勤'),
('2017566123', '0001', '2017-12-28', '出勤'),
('2017566123', '0001', '2017-12-29', '缺勤'),
('2017566123', '0002', '2017-12-27', '缺勤'),
('2017566123', '0002', '2017-12-28', '出勤'),
('2017566123', '0002', '2017-12-29', '出勤');

-- --------------------------------------------------------

--
-- 表的结构 `teacher`
--

CREATE TABLE `teacher` (
  `tid` varchar(10) COLLATE utf8_bin NOT NULL,
  `tname` varchar(10) COLLATE utf8_bin NOT NULL,
  `sex` varchar(6) COLLATE utf8_bin NOT NULL,
  `birthday` date DEFAULT NULL,
  `rank` varchar(15) COLLATE utf8_bin NOT NULL,
  `telephone` varchar(11) COLLATE utf8_bin NOT NULL,
  `colid` varchar(10) COLLATE utf8_bin NOT NULL,
  `passwd` varchar(32) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `teacher`
--

INSERT INTO `teacher` (`tid`, `tname`, `sex`, `birthday`, `rank`, `telephone`, `colid`, `passwd`) VALUES
('0000131664', 'ggk', '男', '1986-01-07', '副教授', '18123456789', '0005', '0275908e0c664cc3d0d1656794dcdc27'),
('0000144159', 'llg', '男', '1981-01-01', '教授', '18123456789', '0003', 'c8d41db1f13878006f4a327708831488'),
('0000147556', 'zxf', '男', '1980-11-06', '教授助理', '18123456789', '0001', 'a3b630d458ca35f2d63085f32d928931'),
('0000153221', 'dfg', '男', '1985-05-06', '副教授', '18123456789', '0002', '10b788382c0404a0f72e22e0c032ae50'),
('0000154621', 'zd', '女', '1988-04-25', '教授', '18123456789', '0001', 'c3f5588a02e39e607291c5c930775805'),
('0000155489', 'ryg', '女', '1984-06-07', '教授', '18123456789', '0001', '148003ab8113405faec7481eea75a8fd'),
('0000169115', 'mft', '男', '1978-12-20', '教授助理', '18123456789', '0001', '7f772538dd1ff73f3df357209ca82ee4'),
('1', '钱嘉伟', '男', '1980-11-22', '教授', '13123456789', '150', 'e10adc3949ba59abbe56e057f20f883e'),
('2', '张滇', '女', '1980-01-22', '教授', '13123456789', '150', 'e10adc3949ba59abbe56e057f20f883e'),
('root', 'Admin', '无', '1996-08-08', '管理员', '13123456789', '0001', 'e10adc3949ba59abbe56e057f20f883e');

--
-- 触发器 `teacher`
--
DELIMITER $$
CREATE TRIGGER `after_delete_teacher` AFTER DELETE ON `teacher` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"teacher","delete",old.tid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_teacher` AFTER INSERT ON `teacher` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"teacher","insert",new.tid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_teacher` AFTER UPDATE ON `teacher` FOR EACH ROW BEGIN
INSERT INTO logs VALUES(null,user(),NOW(),"teacher","update",old.tid);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `createTeacherPasswd` BEFORE INSERT ON `teacher` FOR EACH ROW BEGIN
SET new.passwd=md5(RIGHT(new.tid,6));
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `college`
--
ALTER TABLE `college`
  ADD PRIMARY KEY (`colid`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `tid` (`tid`),
  ADD KEY `colid` (`colid`);

--
-- Indexes for table `course_sign`
--
ALTER TABLE `course_sign`
  ADD PRIMARY KEY (`cid`,`sign_time`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`logid`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `colid` (`colid`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
  ADD PRIMARY KEY (`sid`,`cid`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `student_sign`
--
ALTER TABLE `student_sign`
  ADD PRIMARY KEY (`sid`,`cid`,`sign_time`),
  ADD KEY `cid` (`cid`),
  ADD KEY `student_sign_ibfk_1` (`cid`,`sign_time`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `colid` (`colid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `logs`
--
ALTER TABLE `logs`
  MODIFY `logid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- 限制导出的表
--

--
-- 限制表 `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `teacher` (`tid`),
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`colid`) REFERENCES `college` (`colid`);

--
-- 限制表 `course_sign`
--
ALTER TABLE `course_sign`
  ADD CONSTRAINT `course_sign_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`);

--
-- 限制表 `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`colid`) REFERENCES `college` (`colid`);

--
-- 限制表 `student_course`
--
ALTER TABLE `student_course`
  ADD CONSTRAINT `student_course_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`),
  ADD CONSTRAINT `student_course_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`);

--
-- 限制表 `student_sign`
--
ALTER TABLE `student_sign`
  ADD CONSTRAINT `student_sign_ibfk_1` FOREIGN KEY (`cid`,`sign_time`) REFERENCES `course_sign` (`cid`, `sign_time`),
  ADD CONSTRAINT `student_sign_ibfk_4` FOREIGN KEY (`sid`,`cid`) REFERENCES `student_course` (`sid`, `cid`);

--
-- 限制表 `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`colid`) REFERENCES `college` (`colid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
