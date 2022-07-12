create table tbl_accounts (
    acc_id int(11) not null auto_increment,
    acc_name varchar(255) not null,
    acc_login varchar(20) not null,
    acc_password varchar(255) not null,
    primary key (acc_id),
    unique key acc_login (acc_login)
    ) engine=MyISAM auto_increment=6 default charset=latin1;

INSERT INTO tbl_accounts VALUES
    (1,'Daniel Challou','challou','489bf9d5c89ac6980e464fa9cd5a1724222d5e55'),
    (2,'Shaden Smith','shaden','80ea3d7fb87c288af49a17d5fb0d61c835455bf1'),
    (3,'Koorosh Vaziri','koorosh','e48e1d49b26ed33486bbd1a2885ce5458d949d8a'),
    (4,'John Doe' ,'john','32b67c82444a54596d94122a886518d4d6d6be66'),
    (5,'Jane Doe','jane','32b67c82444a54596d94122a886518d4d6d6be66');
