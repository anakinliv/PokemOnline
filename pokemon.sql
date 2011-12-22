SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `POKEMON` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `POKEMON`;

/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2011/12/11 15:59:29                          */
/*==============================================================*/


drop table if exists appear_rate;

drop table if exists bag;

drop table if exists box;

drop table if exists chat;

drop table if exists effect;

drop table if exists evolve;

drop table if exists friend;

drop table if exists friend_request;

drop table if exists item;

drop table if exists item_effect;

drop table if exists map;

drop table if exists pet;

drop table if exists pm_skill;

drop table if exists pokemon;

drop table if exists skill;

drop table if exists skill_effect;

drop table if exists type;

drop table if exists type_relation;

drop table if exists user;

/*==============================================================*/
/* Table: appear_rate                                           */
/*==============================================================*/
create table appear_rate
(
   pmid                 smallint not null,
   areaid               smallint not null,
   rate                 smallint not null,
   primary key (pmid, areaid)
);

/*==============================================================*/
/* Table: bag                                                   */
/*==============================================================*/
create table bag
(
   userid               bigint not null,
   itemid               bigint not null,
   count                smallint not null,
   primary key (userid, itemid)
);

/*==============================================================*/
/* Table: box                                                   */
/*==============================================================*/
create table box
(
   userid               bigint not null,
   petid                bigint not null,
   primary key (userid, petid)
);

/*==============================================================*/
/* Table: chat                                                  */
/*==============================================================*/
create table chat
(
   chatid               bigint auto_increment not null,
   userid               bigint not null,
   time                 datetime not null,
   content              varchar(128) not null,
   primary key (chatid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

/*==============================================================*/
/* Table: effect                                                */
/*==============================================================*/
create table effect
(
   effectid             bigint auto_increment not null,
   target               bigint not null,
   value                bigint not null,
   primary key (effectid)
);

/*==============================================================*/
/* Table: evolve                                                */
/*==============================================================*/
create table evolve
(
   from_pokemon         smallint not null,
   to_pokemon           smallint not null,
   level                smallint not null,
   primary key (from_pokemon, to_pokemon, level)
);

/*==============================================================*/
/* Table: friend                                                */
/*==============================================================*/
create table friend
(
   usera                bigint not null,
   userb                bigint not null,
   primary key (usera, userb)
);

/*==============================================================*/
/* Table: friend_request                                        */
/*==============================================================*/
create table friend_request
(
   from_user            bigint not null,
   to_user              bigint not null,
   primary key (from_user, to_user)
);

/*==============================================================*/
/* Table: item                                                  */
/*==============================================================*/
create table item
(
   itemid               bigint auto_increment not null,
   itemname             char(10) not null,
   description          varchar(100),
   primary key (itemid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

/*==============================================================*/
/* Table: item_effect                                           */
/*==============================================================*/
create table item_effect
(
   itemid               bigint not null,
   effectid             bigint not null,
   primary key (itemid, effectid)
);

/*==============================================================*/
/* Table: map                                                   */
/*==============================================================*/
create table map
(
   mapid                smallint not null,
   areaid               smallint auto_increment not null,
   primary key (areaid)
);

/*==============================================================*/
/* Table: pet                                                   */
/*==============================================================*/
create table pet
(
   pmid                 smallint not null,
   petid                bigint auto_increment not null,
   skill_a              int,
   curpp_a              smallint,
   maxpp_a              smallint,
   skill_b              int,
   curpp_b              smallint,
   maxpp_b              smallint,
   skill_c              int,
   curpp_c              smallint,
   maxpp_c              smallint,
   skill_d              int,
   curpp_d              smallint,
   maxpp_d              smallint,
   name                 varchar(16) not null,
   max_hp               smallint not null,
   cur_hp               smallint not null,
   intimate             smallint not null,
   personal_hp          smallint not null,
   personal_attack      smallint not null,
   personal_defense     smallint not null,
   personal_sattack     smallint not null,
   personal_sdefense    smallint not null,
   personal_speed       smallint not null,
   effort_hp            smallint not null,
   effort_attack        smallint not null,
   effort_defense       smallint not null,
   effort_sattack        smallint not null,
   effort_sdefense      smallint not null,
   effort_speed         smallint not null,
   level                smallint not null,
   exp                  int not null,
   pm_status            int not null,
   primary key (petid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

/*==============================================================*/
/* Table: pm_skill                                              */
/*==============================================================*/
create table pm_skill
(
   pmid                 smallint not null,
   skillid              int not null,
   level                smallint not null,
   primary key (skillid, pmid)
);

/*==============================================================*/
/* Table: pokemon                                               */
/*==============================================================*/
create table pokemon
(
   pmid                 smallint auto_increment not null,
   typeid               smallint,
   name                 char(10) not null,
   hp                   smallint not null,
   attack               smallint not null,
   defense              smallint not null,
   sattack              smallint not null,
   sdefense             smallint not null,
   speed                smallint not null,
   catchrate            smallint not null,
   levelup_exp          int not null,
   primary key (pmid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

/*==============================================================*/
/* Table: skill                                                 */
/*==============================================================*/
create table skill
(
   skillid              int auto_increment not null,
   typeid               smallint not null,
   skillname            varchar(10) not null,
   description          varchar(100) not null,
   primary key (skillid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

/*==============================================================*/
/* Table: skill_effect                                          */
/*==============================================================*/
create table skill_effect
(
   skillid              int not null,
   effectid             bigint not null,
   accuracy             int not null,
   primary key (skillid, effectid)
);

/*==============================================================*/
/* Table: type                                                  */
/*==============================================================*/
create table type
(
   typeid               smallint auto_increment not null,
   typename             char(5) not null,
   primary key (typeid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

/*==============================================================*/
/* Table: type_relation                                         */
/*==============================================================*/
create table type_relation
(
   from_type            smallint not null,
   to_type              smallint not null,
   effectid             bigint not null,
   primary key (from_type, to_type, effectid)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   userid               bigint auto_increment not null,
   areaid               smallint not null,
   pet_1                bigint,
   pet_2                bigint,
   pet_3                bigint,
   pet_4                bigint,
   pet_5                bigint,
   pet_6                bigint,
   username             char(16) not null,
   password             char(160) not null,
   type                 smallint not null,
   rights               smallint not null,
   money                bigint not null,
   punishment_level     smallint not null,
   primary key (userid)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

alter table appear_rate add constraint FK_Reference_16 foreign key (pmid)
      references pokemon (pmid) on delete restrict on update restrict;

alter table appear_rate add constraint FK_Reference_17 foreign key (areaid)
      references map (areaid) on delete restrict on update restrict;

alter table bag add constraint FK_Reference_11 foreign key (userid)
      references user (userid) on delete restrict on update restrict;

alter table bag add constraint FK_Reference_12 foreign key (itemid)
      references item (itemid) on delete restrict on update restrict;

alter table box add constraint FK_Reference_26 foreign key (userid)
      references user (userid) on delete restrict on update restrict;

alter table box add constraint FK_Reference_27 foreign key (petid)
      references pet (petid) on delete restrict on update restrict;

alter table chat add constraint FK_Reference_34 foreign key (userid)
      references user (userid) on delete restrict on update restrict;

alter table evolve add constraint FK_Reference_10 foreign key (to_pokemon)
      references pokemon (pmid) on delete restrict on update restrict;

alter table evolve add constraint FK_Reference_9 foreign key (from_pokemon)
      references pokemon (pmid) on delete restrict on update restrict;

alter table friend add constraint FK_Reference_1 foreign key (usera)
      references user (userid) on delete restrict on update restrict;

alter table friend add constraint FK_Reference_2 foreign key (userb)
      references user (userid) on delete restrict on update restrict;

alter table friend_request add constraint FK_Reference_13 foreign key (from_user)
      references user (userid) on delete restrict on update restrict;

alter table friend_request add constraint FK_Reference_14 foreign key (to_user)
      references user (userid) on delete restrict on update restrict;

alter table item_effect add constraint FK_Reference_35 foreign key (itemid)
      references item (itemid) on delete restrict on update restrict;

alter table item_effect add constraint FK_Reference_36 foreign key (effectid)
      references effect (effectid) on delete restrict on update restrict;

alter table pet add constraint FK_Reference_19 foreign key (skill_a)
      references skill (skillid) on delete restrict on update restrict;

alter table pet add constraint FK_Reference_20 foreign key (skill_b)
      references skill (skillid) on delete restrict on update restrict;

alter table pet add constraint FK_Reference_21 foreign key (skill_c)
      references skill (skillid) on delete restrict on update restrict;

alter table pet add constraint FK_Reference_22 foreign key (skill_d)
      references skill (skillid) on delete restrict on update restrict;

alter table pet add constraint FK_Reference_4 foreign key (pmid)
      references pokemon (pmid) on delete restrict on update restrict;

alter table pm_skill add constraint FK_Reference_24 foreign key (skillid)
      references skill (skillid) on delete restrict on update restrict;

alter table pm_skill add constraint FK_Reference_25 foreign key (pmid)
      references pokemon (pmid) on delete restrict on update restrict;

alter table pokemon add constraint FK_Reference_40 foreign key (typeid)
      references type (typeid) on delete restrict on update restrict;

alter table skill add constraint FK_Reference_23 foreign key (typeid)
      references type (typeid) on delete restrict on update restrict;

alter table skill_effect add constraint FK_Reference_37 foreign key (skillid)
      references skill (skillid) on delete restrict on update restrict;

alter table skill_effect add constraint FK_Reference_38 foreign key (effectid)
      references effect (effectid) on delete restrict on update restrict;

alter table type_relation add constraint FK_Reference_39 foreign key (effectid)
      references effect (effectid) on delete restrict on update restrict;

alter table type_relation add constraint FK_Reference_7 foreign key (from_type)
      references type (typeid) on delete restrict on update restrict;

alter table type_relation add constraint FK_Reference_8 foreign key (to_type)
      references type (typeid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_15 foreign key (areaid)
      references map (areaid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_28 foreign key (pet_6)
      references pet (petid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_29 foreign key (pet_1)
      references pet (petid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_30 foreign key (pet_2)
      references pet (petid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_31 foreign key (pet_3)
      references pet (petid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_32 foreign key (pet_4)
      references pet (petid) on delete restrict on update restrict;

alter table user add constraint FK_Reference_33 foreign key (pet_5)
      references pet (petid) on delete restrict on update restrict;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;