CREATE TABLE `areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `alerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `chk` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_2_idx` (`area`),
  CONSTRAINT `fk_2` FOREIGN KEY (`area`) REFERENCES `areas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
SELECT * FROM covidb.alerts;


CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `nickname_UNIQUE` (`nickname`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cntname` varchar(100) NOT NULL,
  `cntcode` varchar(50) NOT NULL,
  `area` int(11) NOT NULL,
  `sex` tinyint(2) NOT NULL,
  `age` int(11) NOT NULL,
  `home` varchar(100) DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  `route` varchar(100) DEFAULT NULL,
  `first` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `hospi` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk1_idx` (`area`),
  CONSTRAINT `fk1` FOREIGN KEY (`area`) REFERENCES `areas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;


CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `area` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` varchar(1024) NOT NULL,
  `view` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk1_idx` (`user`),
  KEY `fk2_idx` (`area`),
  CONSTRAINT `fk_p_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_p_2` FOREIGN KEY (`area`) REFERENCES `areas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

CREATE TABLE `covidb`.`mapmark` (
  `id` INT NOT NULL,
  `lat` DOUBLE NOT NULL,
  `lng` DOUBLE NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `date` datetime NOT NULL,
  `patient` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_idx` (`patient` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk`
    FOREIGN KEY (`patient`)
    REFERENCES `covidb`.`patients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

CREATE TABLE `covidb`.`comments` (
  `id` INT NOT NULL,
  `posts` INT NOT NULL,
  `user` INT NOT NULL,
  `content` VARCHAR(1024) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `cmt_fk1_idx` (`posts` ASC),
  INDEX `cmt_fk2_idx` (`user` ASC),
  CONSTRAINT `cmt_fk1`
    FOREIGN KEY (`posts`)
    REFERENCES `covidb`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cmt_fk2`
    FOREIGN KEY (`user`)
    REFERENCES `covidb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    
 
INSERT INTO covidb.areas (id,name,x,y) VALUES(1,"서울",37.517809,126.983007);
INSERT INTO covidb.areas (id,name,x,y) VALUES(2,"울산",35.539625,129.311528);
INSERT INTO covidb.areas (id,name,x,y) VALUES(3,"부산",35.157394,129.059108);
INSERT INTO covidb.areas (id,name,x,y) VALUES(4,"대구",35.871104,128.581899);
INSERT INTO covidb.areas (id,name,x,y) VALUES(5,"제주",33.500538,126.52927);
INSERT INTO covidb.areas (id,name,x,y) VALUES(6,"광주",35.154697,126.832132);

INSERT INTO covidb.users (id,nickname,email,password,role) VALUES(1,"홍길동이","happy123@naver.com","123",1);
INSERT INTO covidb.patients (id,cntname,cntcode,area,sex,age,home,job,route,first,end,hospi) 
VALUES(1,"대한민국","kr",1,0,23,"강남","대학생","이태원클럽",now(),null,"서울대병원@www.snuh.org/intro.do");
INSERT INTO covidb.patients (id,cntname,cntcode,area,sex,age,home,job,route,first,end,hospi) 
VALUES(2,"대한민국","kr",2,1,35,"무거동","회사원","2차 감염",now(),null,"울산대병원@www.uuh.ulsan.kr");
INSERT INTO covidb.patients (id,cntname,cntcode,area,sex,age,home,job,route,first,end,hospi) 
VALUES(3,"미국","us",3,1,26,"해운대구","강사","해외 입국자(미국)",now(),null,"부산대병원@www.pnuh.or.kr");
INSERT INTO covidb.patients (id,cntname,cntcode,area,sex,age,home,job,route,first,end,hospi) 
VALUES(4,"대한민국","kr",4,0,66,"달서구","무직","2차 감염",now(),null,"대구대병원@www.durc.daegu.ac.kr");
INSERT INTO covidb.patients (id,cntname,cntcode,area,sex,age,home,job,route,first,end,hospi) 
VALUES(5,"일본","jp",5,1,20,"요코하마","대학생","해외 입국자(일본)",now(),null,"제주대병원@www.jejunuh.co.kr");
INSERT INTO covidb.patients (id,cntname,cntcode,area,sex,age,home,job,route,first,end,hospi) 
VALUES(6,"대한민국","kr",6,0,42,"진월동","회사원","2차 감염",now(),null,"전남대병원@www.cnuh.com");
INSERT INTO covidb.posts (id,user,area,title,content,view,date) VALUES(1,1,1,"서울 지역의 커뮤니티입니다","반갑습니다",1,NOW());
INSERT INTO covidb.posts (id,user,area,title,content,view,date) VALUES(2,1,2,"울산 지역의 커뮤니티입니다","반갑습니다",1,NOW());
INSERT INTO covidb.posts (id,user,area,title,content,view,date) VALUES(3,1,3,"부산 지역의 커뮤니티입니다","반갑습니다",1,NOW());
INSERT INTO covidb.posts (id,user,area,title,content,view,date) VALUES(4,1,4,"대구 지역의 커뮤니티입니다","반갑습니다",1,NOW());
INSERT INTO covidb.posts (id,user,area,title,content,view,date) VALUES(5,1,5,"제주 지역의 커뮤니티입니다","반갑습니다",1,NOW());
INSERT INTO covidb.posts (id,user,area,title,content,view,date) VALUES(6,1,6,"광주 지역의 커뮤니티입니다","반갑습니다",1,NOW());
INSERT INTO covidb.alerts (id,area,title,chk, date) VALUES(1,1,"바깥 외출 시 마스크를 반드시 착용해주세요!","주의",NOW());
INSERT INTO covidb.alerts (id,area,title,chk, date) VALUES(2,2,"바깥 외출 시 마스크를 반드시 착용해주세요!","주의",NOW());
INSERT INTO covidb.alerts (id,area,title,chk, date) VALUES(3,3,"바깥 외출 시 마스크를 반드시 착용해주세요!","주의",NOW());
INSERT INTO covidb.alerts (id,area,title,chk, date) VALUES(4,4,"바깥 외출 시 마스크를 반드시 착용해주세요!","주의",NOW());
INSERT INTO covidb.alerts (id,area,title,chk, date) VALUES(5,5,"바깥 외출 시 마스크를 반드시 착용해주세요!","주의",NOW());
INSERT INTO covidb.alerts (id,area,title,chk, date) VALUES(6,6,"바깥 외출 시 마스크를 반드시 착용해주세요!","주의",NOW());
INSERT INTO `covidb`.`comments` (`id`, `posts`, `user`, `content`, `date`) VALUES ('1', '1', '1', '잘 읽었습니다!', NOW());
INSERT INTO `covidb`.`comments` (`id`, `posts`, `user`, `content`, `date`) VALUES ('2', '2', '1', '잘 읽었습니다.', NOW());
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('1', '37.5548545', '126.969777', '2020-06-21 00:00:00', '서울역', '1');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('2', '35.5394197', '129.3526638', '2020-06-26 00:00:00', '태화강역', '2');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('3', '35.158683', '129.1600449', '2020-06-28 00:00:00', '해운대', '3');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('4', '35.827294', '128.612868', '2020-06-24 00:00:00', '수성랜드', '4');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('5', '37.534826', '126.993941', '2020-06-24 00:00:00', '이태원클럽', '1');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('6', '37.483379', '126.981562', '2020-06-24 00:00:00', '하이마트', '1');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('7', '37.513962', '126.944834', '2020-06-25 00:00:00', '버거킹', '1');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('8', '35.535266', '129.324713', '2020-06-26 00:00:00', 'gs24', '2');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('9', '35.555868', '129.279973', '2020-06-26 00:00:00', 'ok마트', '2');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('10', '35.196738', '129.115661', '2020-06-24 00:00:00', '홈플러스', '3');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('11', '35.871747', '128.559224', '2020-06-27 00:00:00', '대구서구청', '4');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('12', '35.876294', '128.596038', '2020-06-26 00:00:00', '대구역', '4');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('13', '33.506983', '126.492962', '2020-06-28 00:00:00', '제주공항', '5');
INSERT INTO `covidb`.`mapmark` (`id`, `lat`, `lng`, `date`, `title`, `patient`) VALUES ('14', '35.15563', '126.854211', '2020-06-27 00:00:00', '롯데리아', '6');

