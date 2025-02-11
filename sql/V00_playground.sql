---- cleanup ----
drop table if exists disc_set_effect;
drop table if exists disc_set;

drop table if exists effect_stat;
drop table if exists effect;

drop table if exists disc_stat;
drop table if exists disc_main;
drop table if exists attribute;

drop table if exists slot;
drop table if exists rarity;

drop table if exists stat;
drop table if exists scaling;

---- schema ----
create table scaling
(
    id          text,
    description text not null,
    primary key (id)
);


create table stat
(
    key     text not null,
    scaling text not null,
    name    text not null,
    id      text generated always as ( key || ':' || scaling ) stored,
    primary key (id),
    unique (key, scaling),
    foreign key (scaling) references scaling (id)
);


create table rarity
(
    id   text,
    name text not null,
    primary key (id)
);


create table slot
(
    id   integer,
    name text not null,
    primary key (id)
);


create table attribute
(
    id   text not null,
    name text,
    primary key (id)
);


create table disc_main
(
    slot integer,
    stat text,
    primary key (slot, stat)
);

create table disc_stat
(
    rarity text    not null,
    stat   text    not null,
    main   bool    not null,
    value  decimal not null,
    primary key (rarity, stat, main)
);

---- data ----
insert into scaling
values ('base', 'Base value of a stat'),
       ('flat', 'Added to the current stat value'),
       ('rate', 'Added to the current stat value, calculated as (this / 100)'),
       ('percent', 'Added to the current stat value, calculated as (base * this / 100)');


insert into stat
values ('health', 'base', 'HP'),
       ('health', 'flat', 'HP'),
       ('health', 'percent', 'HP');

insert into stat
values ('attack', 'base', 'ATK'),
       ('attack', 'flat', 'ATK'),
       ('attack', 'percent', 'ATK');

insert into stat
values ('defence', 'base', 'DEF'),
       ('defence', 'flat', 'DEF'),
       ('defence', 'percent', 'DEF');

insert into stat
values ('impact', 'base', 'Impact'),
       ('impact', 'flat', 'Impact'),
       ('impact', 'percent', 'Impact');

insert into stat
values ('anomaly.mastery', 'base', 'Anomaly Mastery'),
       ('anomaly.mastery', 'flat', 'Anomaly Mastery'),
       ('anomaly.mastery', 'percent', 'Anomaly Mastery');

insert into stat
values ('decibel', 'base', 'Decibel'),
       ('decibel', 'flat', 'Decibel'),
       ('decibel', 'percent', 'Decibel');

insert into stat
values ('energy', 'base', 'Energy'),
       ('energy', 'flat', 'Energy'),
       ('energy', 'percent', 'Energy');

insert into stat
values ('penetration', 'rate', 'PEN'),
       ('penetration', 'flat', 'PEN');

insert into stat
values ('damage', 'rate', 'DMG');

insert into stat
values ('critical.rate', 'rate', 'Critical Rate');

insert into stat
values ('critical.damage', 'rate', 'Critical DMG');

insert into stat
values ('attribute.damage.all', 'rate', 'All Attribute DMG'),
       ('attribute.damage.electric', 'rate', 'Electric DMG'),
       ('attribute.damage.ether', 'rate', 'Ether DMG'),
       ('attribute.damage.fire', 'rate', 'Fire DMG'),
       ('attribute.damage.frost', 'rate', 'Frost DMG'),
       ('attribute.damage.ice', 'rate', 'Ice DMG'),
       ('attribute.damage.physical', 'rate', 'Physical DMG');

insert into stat
values ('attribute.resistance.all', 'rate', 'All Attribute RES'),
       ('attribute.resistance.electric', 'rate', 'Electric RES'),
       ('attribute.resistance.ether', 'rate', 'Ether RES'),
       ('attribute.resistance.fire', 'rate', 'Fire RES'),
       ('attribute.resistance.frost', 'rate', 'Frost RES'),
       ('attribute.resistance.ice', 'rate', 'Ice RES'),
       ('attribute.resistance.physical', 'rate', 'Physical RES');

insert into stat
values ('disorder.damage', 'rate', 'Disorder DMG');
insert into stat
values ('anomaly.damage', 'rate', 'Anomaly DMG');
insert into stat
values ('anomaly.proficiency', 'flat', 'Anomaly Proficiency');

insert into stat
values ('anomaly.buildup.all', 'rate', 'Anomaly Buildup Rate'),
       ('anomaly.buildup.electric', 'rate', 'Electric Anomaly Buildup Rate'),
       ('anomaly.buildup.ether', 'rate', 'Ether Anomaly Buildup Rate'),
       ('anomaly.buildup.fire', 'rate', 'Fire Anomaly Buildup Rate'),
       ('anomaly.buildup.frost', 'rate', 'Frost Anomaly Buildup Rate'),
       ('anomaly.buildup.ice', 'rate', 'Ice Anomaly Buildup Rate'),
       ('anomaly.buildup.physical', 'rate', 'Physical Anomaly Buildup Rate');


insert into rarity
values ('X', 'Other'),
       ('B', 'B-rank'),
       ('A', 'A-rank'),
       ('S', 'S-rank');

insert into slot
values (1, '[1]'),
       (2, '[2]'),
       (3, '[3]'),
       (4, '[4]'),
       (5, '[5]'),
       (6, '[6]');

insert into attribute
values ('fire', 'Fire'),
       ('electric', 'Electric'),
       ('ice', 'Ice'),
       ('frost', 'Frost'),
       ('physical', 'Physical'),
       ('ether', 'Ether'),
       ('all', 'All');
       -- ('none', null);


insert into disc_main
values (1, 'health.flat');

insert into disc_main
values (2, 'attack.flat');

insert into disc_main
values (3, 'defence.flat');

insert into disc_main
values (4, 'health:percent'),
       (4, 'attack:percent'),
       (4, 'defence:percent'),
       (4, 'critical.rate:rate'),
       (4, 'critical.damage:rate'),
       (4, 'anomaly.proficiency:flat');

insert into disc_main
values (5, 'health:percent'),
       (5, 'attack:percent'),
       (5, 'defence:percent'),
       (5, 'penetration:rate'),
       (5, 'attribute.damage.electric:rate'),
       (5, 'attribute.damage.ether:rate'),
       (5, 'attribute.damage.fire:rate'),
       (5, 'attribute.damage.ice:rate'),
       (5, 'attribute.damage.physical:rate');

insert into disc_main
values (6, 'health:percent'),
       (6, 'attack:percent'),
       (6, 'defence:percent'),
       (6, 'anomaly.mastery:percent'),
       (6, 'impact:percent'),
       (6, 'energy:percent');

insert into disc_stat
values ('B', 'health:flat', true, 183),
       ('A', 'health:flat', true, 367),
       ('S', 'health:flat', true, 550);

insert into disc_stat
values ('B', 'attack:flat', true, 26),
       ('A', 'attack:flat', true, 53),
       ('S', 'attack:flat', true, 79);

insert into disc_stat
values ('B', 'defence:flat', true, 15),
       ('A', 'defence:flat', true, 31),
       ('S', 'defence:flat', true, 46);

insert into disc_stat
values ('B', 'health:percent', true, 2.5),
       ('A', 'health:percent', true, 5),
       ('S', 'health:percent', true, 7.5);

insert into disc_stat
values ('B', 'attack:percent', true, 2.5),
       ('A', 'attack:percent', true, 7.5),
       ('S', 'attack:percent', true, 5);

insert into disc_stat
values ('B', 'defence:percent', true, 4),
       ('A', 'defence:percent', true, 8),
       ('S', 'defence:percent', true, 12);

insert into disc_stat
values ('B', 'critical.rate:rate', true, 3),
       ('A', 'critical.rate:rate', true, 4.5),
       ('S', 'critical.rate:rate', true, 6);

insert into disc_stat
values ('B', 'critical.damage:rate', true, 4),
       ('A', 'critical.damage:rate', true, 8),
       ('S', 'critical.damage:rate', true, 12);

insert into disc_stat
values ('B', 'anomaly.proficiency:flat', true, 8),
       ('A', 'anomaly.proficiency:flat', true, 15),
       ('S', 'anomaly.proficiency:flat', true, 23);

insert into disc_stat
values ('B', 'penetration:rate', true, 2),
       ('A', 'penetration:rate', true, 4),
       ('S', 'penetration:rate', true, 6);

insert into disc_stat
values ('B', 'attribute.damage.electric:rate', true, 2.5),
       ('A', 'attribute.damage.electric:rate', true, 5),
       ('S', 'attribute.damage.electric:rate', true, 7.5);

insert into disc_stat
values ('B', 'attribute.damage.ether:rate', true, 2.5),
       ('A', 'attribute.damage.ether:rate', true, 5),
       ('S', 'attribute.damage.ether:rate', true, 7.5);

insert into disc_stat
values ('B', 'attribute.damage.fire:rate', true, 2.5),
       ('A', 'attribute.damage.fire:rate', true, 5),
       ('S', 'attribute.damage.fire:rate', true, 7.5);

insert into disc_stat
values ('B', 'attribute.damage.ice:rate', true, 2.5),
       ('A', 'attribute.damage.ice:rate', true, 5),
       ('S', 'attribute.damage.ice:rate', true, 7.5);

insert into disc_stat
values ('B', 'attribute.damage.physical:rate', true, 2.5),
       ('A', 'attribute.damage.physical:rate', true, 5),
       ('S', 'attribute.damage.physical:rate', true, 7.5);

insert into disc_stat
values ('B', 'anomaly.mastery:percent', true, 2.5),
       ('A', 'anomaly.mastery:percent', true, 5),
       ('S', 'anomaly.mastery:percent', true, 7.5);

insert into disc_stat
values ('B', 'impact:percent', true, 1.5),
       ('A', 'impact:percent', true, 3),
       ('S', 'impact:percent', true, 4.5);

insert into disc_stat
values ('B', 'energy:percent', true, 5),
       ('A', 'energy:percent', true, 10),
       ('S', 'energy:percent', true, 15);

-- secondary stats
insert into disc_stat
values ('B', 'health:flat', false, 39),
       ('A', 'health:flat', false, 79),
       ('S', 'health:flat', false, 112);

insert into disc_stat
values ('B', 'attack:flat', false, 7),
       ('A', 'attack:flat', false, 15),
       ('S', 'attack:flat', false, 19);

insert into disc_stat
values ('B', 'defence:flat', false, 5),
       ('A', 'defence:flat', false, 10),
       ('S', 'defence:flat', false, 15);

insert into disc_stat
values ('B', 'health:percent', false, 1),
       ('A', 'health:percent', false, 2),
       ('S', 'health:percent', false, 3);

insert into disc_stat
values ('B', 'attack:percent', false, 1),
       ('A', 'attack:percent', false, 2),
       ('S', 'attack:percent', false, 3);

insert into disc_stat
values ('B', 'defence:percent', false, 1.60),
       ('A', 'defence:percent', false, 3.20),
       ('S', 'defence:percent', false, 4.80);

insert into disc_stat
values ('B', 'penetration:flat', false, 3),
       ('A', 'penetration:flat', false, 6),
       ('S', 'penetration:flat', false, 9);

insert into disc_stat
values ('B', 'critical.rate:rate', false, 0.80),
       ('A', 'critical.rate:rate', false, 1.60),
       ('S', 'critical.rate:rate', false, 2.40);

insert into disc_stat
values ('B', 'critical.damage:rate', false, 1.60),
       ('A', 'critical.damage:rate', false, 3.20),
       ('S', 'critical.damage:rate', false, 4.80);

insert into disc_stat
values ('B', 'anomaly.proficiency:flat', false, 3),
       ('A', 'anomaly.proficiency:flat', false, 6),
       ('S', 'anomaly.proficiency:flat', false, 9);


-- #################

drop table if exists effect cascade;
create table effect
(
    id          text,
    name        text not null,
    combat      bool not null,
    trigger     text not null,
    target      text not null,
    stacks      integer,
    duration    decimal,
    refreshable bool default True,
    primary key (id)
);

drop table if exists effect_stat cascade;
create table effect_stat (
    effect text not null,
    stat text not null,
    value decimal not null,
    stackable bool default True,
    primary key (effect, stat),
    foreign key (effect) references effect(id),
    foreign key (stat) references stat(id)
);
-- create table effect_buff (
--
-- );

drop table if exists disc_set cascade;
create table disc_set
(
    id text,
    name text not null,
    primary key (id)
--     stat text not null,
--     value decimal not null,
--     effect text not null,
--     foreign key (stat) references stat(id),
--     foreign key (effect) references effect(id)
);

drop table if exists disc_set_effect cascade;
create table disc_set_effect
(
    dist_set text not null,
    count integer not null,
    effect text not null,
    seq integer not null,
    primary key (dist_set, effect),
    foreign key (dist_set) references disc_set(id),
    foreign key (effect) references effect(id),
    unique (dist_set, count, seq)
);

-- Astral Voice
insert into effect
values ('AstralVoice_2pc', 'Astral Voice 2PC', false, 'party:self:always', 'party:self', 1, -1, true),
       ('AstralVoice_4pc', 'Astral Voice 4PC', true, 'party:any:assist', 'party:all', 3, 15, true);
insert into effect_stat
values ('AstralVoice_2pc', 'attack:percent', 10),
       ('AstralVoice_4pc', 'damage:rate', 8);

-- Branch & Blade Song
insert into effect
values ('BranchBladeSong_2pc', 'Branch & Blade Song 2PC', false, 'party:self:always', 'party:self', 1, -1, true),
       ('BranchBladeSong_4pc_1', 'Branch & Blade Song 4PC: Anomaly Mastery', true, 'party:self:stat:anomaly.mastery>=115', 'party:self', 1, -1, true),
       ('BranchBladeSong_4pc_2', 'Branch & Blade Song 4PC: Anomaly Trigger', true, 'party:any:anomaly:freeze|party:any:anomaly:shatter', 'party:self', 1, 15, true);
insert into effect_stat
values ('BranchBladeSong_2pc', 'critical.damage:rate', 16),
       ('BranchBladeSong_4pc_1', 'critical.damage:rate', 30),
       ('BranchBladeSong_4pc_2', 'critical.rate:rate', 12);


insert into disc_set
values ('AstralVoice', 'Astral Voice'),
       ('BranchBladeSong', 'Branch & Blade Song'),

       ('FangedMetal', 'Fanged Metal'),
       ('FreedomBlues', 'Freedom Blues'),
       ('WoodpeckerElectro', 'Woodpecker Electro');

insert into disc_set_effect
values ('AstralVoice', 2, 'AstralVoice_2pc', 1),
       ('AstralVoice', 4, 'AstralVoice_4pc', 1);

insert into disc_set_effect
values ('BranchBladeSong', 2, 'BranchBladeSong_2pc', 1),
       ('BranchBladeSong', 4, 'BranchBladeSong_4pc_1', 1),
       ('BranchBladeSong', 4, 'BranchBladeSong_4pc_2', 2);


/* encoding effects of disc sets (and weapons as well for that matter)

   problem:
     - some disc sets have several independent effects with potentially different trigger conditions in 4PC set bonus
       - multiple effects example - Branch & Blade Song 4PC
         - When Anomaly Mastery exceeds or equals 115 points, the equipper's CRIT damage increases by 30%.
         - When any squad member applies Freeze or triggers the Shatter effect on an enemy, the equipper's CRIT Rate increases by 12%, lasting 15s.
       - multiple triggers example - Woodpecker Electro 4PC
         - Triggering a critical hit with a Basic Attack, Dodge Counter, or EX Special Attack increases the equipper's ATK by 9% for 6s.
           The buff duration for different skills are calculated seperately.

   solutions:
     - use `text[]` type for effect column
       - pros:
         - keeps information about the disc set in same table
         - faster fetch times as less joins
       - cons:
         - working with arrays in JDBC or SqlAlchemy is somewhat messy
         - not sure if postgres already supports FK constraints for each element of array, portability issues
     - create separate table `disc_set_effect`
       - pros:
         - easy to code and maintain
         - allows to create more complex combinations (e.g. 3PC sets)
       - cons:
         - extra join upon fetching
     - encode origin of effect directly in `effect` table
       - cons:
         - creating FKs will be near impossible, potential for dangling effects
         - values to be stored in `effect` table can get messy and and error-prone
           - e.g.:
             - agent.disc-set.BranchBladeSong=4
       - pros:
         - `trigger` and `target` columns in `effect` table already encode quite a bit of information, so it's nothing new
           - we might redesign these columns later however
         - fairly flexible, allows to quickly lookup all effects that should be applied at any given moment
         - makes it easy to find what caused the effect
         - same approach can be used for agent mindscapes and passives as well as weapon passives

   considerations:
     - should we make 2PC bonus into an effect as well?

   */


-- individual buffs - 1 stack @ X duration
-- combined   buffs - Y stack @ X duration

-- multiple sources -> same buff == stacks>=1 && refreshable
-- multiple sources -> ind. buff == stacks==1
