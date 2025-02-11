-- individual buffs - 1 stack @ X duration
-- combined   buffs - Y stack @ X duration

-- multiple sources -> same buff == stacks>=1 && refreshable
-- multiple sources -> ind. buff == stacks==1

/*
effect_target:
  - self # current agent
  - next # next agent
  - prev # prev agent
  - rest # other agents
  - all  # all agents
*/

create table effect (
    id text not null,
    name text not null,
    combat bool not null,
    source text not null,
    target text not null,
    stacks integer,
    duration decimal,
    refreshable bool default True,
    primary key (id)
);

create table effect_stat (
    effect_id text not null,
    stat_id text not null,
    attribute_id text not null,
    stat_value decimal not null,
    stackable bool default True,
    primary key (effect_id, stat_id),
    foreign key (effect_id) references effect(id),
    foreign key (stat_id) references stat(id),
    foreign key (attribute_id) references attribute(id)
);

-- Astral Voice
-- ATK% +10%
-- Whenever any squad member enters the field using a Quick Assist, all squad members gain 1 stack of Astral,
--         up to a maximum of 3 stacks, and lasting 15s. Repeated triggers reset the duration.
--         Each stack of Astral increases the DMG dealt by the character entering the field using a Quick Assist by 8%.
--         Only one instance of this effect can exist in the same squad.
insert into effect values('AstralVoice_2pc', 'Astral Voice 2PC', False,'party:self:always', 'party:self', null,null);
insert into effect values('AstralVoice_4pc', 'Astral Voice 4PC: Astral', True, 'party:all:assist', 'party:all', 3, 15);
insert into effect_stat values('AstralVoice_2pc', 'attack.percent', 'none', 10);
insert into effect_stat values('AstralVoice_4pc', 'damage.flat', 'none', 8);


-- Branch & Blade Song
-- Crit DMG +16%
-- When Anomaly Mastery exceeds or equals 115 points, the equipper's CRIT damage increases by 30%.
-- When any squad member applies Freeze or triggers the Shatter effect on an enemy, the equipper's CRIT Rate increases by 12%, lasting 15s.
insert into effect values('BranchBladeSong_2pc', 'Branch & Blade Song 2PC', False,'party:self:always', 'party:self', null,null);
insert into effect_stat values('BranchBladeSong_2pc', 'critical.damage.flat', 'none', 16);

insert into effect values('BranchBladeSong_4pc_1', 'Branch & Blade Song 4PC: Anomaly Mastery', True, 'party:self:stat:anomaly.mastery>=115', 'party:self', null, null);
insert into effect_stat values('BranchBladeSong_4pc_1', 'critical.damage.flat', 'none', 30);
insert into effect values('BranchBladeSong_4pc_2', 'Branch & Blade Song 4PC: Anomaly Trigger', True, 'party:any:anomaly:freeze|party:any:anomaly:shatter',  'party:self', null, 15);
insert into effect_stat values('BranchBladeSong_4pc_2', 'critical.rate.flat', 'none', 12);



-- Whenever any squad member enters the field using a Quick Assist,
-- all squad members gain 1 stack of Astral, up to a maximum of 3 stacks, and lasting 15s. Repeated triggers reset the duration.
-- Each stack of Astral increases the DMG dealt by the character entering the field using a Quick Assist by 8%.
-- Only one instance of this effect can exist in the same squad.

-- Drive Disc Branch & Blade Song S
-- Branch & Blade Song  Rank SRank ARank B  CRIT DMG +16%
-- When Anomaly Mastery exceeds or equals 115 points, the equipper's CRIT damage increases by 30%.
--
-- When any squad member applies Freeze or triggers the Shatter effect on an enemy, the equipper's CRIT Rate increases by 12%, lasting 15s.
