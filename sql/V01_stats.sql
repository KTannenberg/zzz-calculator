create table attribute (
    id text not null,
    name text,
    primary key(id)
);
insert into attribute values ('fire', 'Fire');
insert into attribute values ('electric', 'Electric');
insert into attribute values ('ice', 'Ice');
insert into attribute values ('frost', 'Frost');
insert into attribute values ('physical', 'Physical');
insert into attribute values ('ether', 'Ether');
insert into attribute values ('all', 'All');
insert into attribute values ('none', null);

create table stat_type
(
    id text,
    description text,
    primary key (id)
);

create table stat (
    key text not null,
    type text not null,
    name text not null,
    id text generated always as ( key || '.' || type ) stored,
    primary key (id),
    unique (key, type),
    foreign key (type) references stat_type(id)
);

insert into stat_type values ('base', 'Base value of a stat');
insert into stat_type values ('flat', 'Added to the current stat value');
insert into stat_type values ('rate',  'Added to the current stat value, calculated as (this / 100)');
insert into stat_type values ('percent', 'Added to the current stat value, calculated as (base * this / 100)');


insert into stat values ('damage', 'rate', 'DMG%');
insert into stat values ('skill.damage', 'rate', 'SKill DMG%');

insert into stat values ('health', 'base', 'Base HP');
insert into stat values ('health', 'flat', 'HP');
insert into stat values ('health', 'percent','HP%');

insert into stat values ('attack', 'base', 'Base ATK');
insert into stat values ('attack', 'flat', 'ATK');
insert into stat values ('attack', 'percent','ATK%');

insert into stat values ('defence', 'base', 'Base DEF');
insert into stat values ('defence', 'flat', 'DEF');
insert into stat values ('defence', 'percent','DEF%');

insert into stat values ('penetration', 'rate', 'PEN%');
insert into stat values ('penetration', 'flat', 'PEN');

#insert into stat values ('impact', 'base', 'Impact');
insert into stat values ('impact', 'rate', 'Impact');
insert into stat values ('impact', 'flat', 'Impact');

insert into stat values ('critical.rate', 'rate', 'Critical Rate');
insert into stat values ('critical.damage', 'rate', 'Critical DMG');

insert into stat values ('attribute.damage', 'rate', 'Attribute DMG');
insert into stat values ('attribute.resistance', 'rate', 'Attribute RES');

insert into stat values ('energy', 'flat', 'Energy');
insert into stat values ('energy', 'rate', 'Energy');

insert into stat values ('decibel', 'flat', 'Decibels');
insert into stat values ('decibel', 'rate', 'Decibels');

insert into stat values ('anomaly.damage', 'rate', 'Anomaly DMG');
insert into stat values ('anomaly.buildup', 'rate', 'Anomaly Buildup Rate');
insert into stat values ('anomaly.proficiency', 'flat', 'Anomaly Proficiency');
insert into stat values ('anomaly.mastery', 'rate', 'Anomaly Mastery');
