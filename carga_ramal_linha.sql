create or replace procedure carga_ramal_linha is

  vramal_ln b$ramal_ln%rowtype;

  fno_ramal        number(5) default 235;
  fno_poste        number(5) default 208;
  fno_torre        number(5) default 260;
  fno_pontalete    number(5) default 230;
  fno_pontonotavel number(5) default 209;

  geom1 sdo_geometry;
  geom2 sdo_geometry;

begin

  --deletando registros importados
  execute immediate 'ALTER TABLE B$RAMAL_LN DISABLE ALL TRIGGERS';
  delete from b$ramal_ln l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_ramal
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  for c in (select c0.g3e_fid     as fid_ramal,
                   c0.subset,
                   c0.location    codid1,
                   c1.g3e_fid     fid1,
                   c1.g3e_fno     fno1,
                   c0.street_name codid2,
                   c2.g3e_fid     fid2,
                   c2.g3e_fno     fno2
              from b$common_n c0
             inner join b$common_n c1
                on c1.cod_id = c0.location
             inner join b$common_n c2
                on c2.cod_id = c0.street_name
             where c0.g3e_fno = 235
               and c0.subset = 'AMAZONAS'
               and c0.subset = c1.subset
               and c0.subset = c2.subset) loop
    begin
      vramal_ln         := null;
      vramal_ln.g3e_fid := c.fid_ramal;
      vramal_ln.g3e_cno := 23502;
      vramal_ln.g3e_fno := fno_ramal;
      vramal_ln.g3e_cid := 1;
      vramal_ln.g3e_id  := ramal_ln_seq.nextval;
      vramal_ln.ltt_id  := 0;
    
      case c.fno1
        when fno_poste then
          select g3e_geometry
            into geom1
            from b$pole_pt
           where g3e_fid = c.fid1;
        when fno_torre then
          select g3e_geometry
            into geom1
            from b$tower_pt
           where g3e_fid = c.fid1;
        when fno_pontalete then
          select g3e_geometry
            into geom1
            from b$pontalete_pt
           where g3e_fid = c.fid1;
        when fno_pontonotavel then
          select g3e_geometry
            into geom1
            from b$structure_pt
           where g3e_fid = c.fid1;
      end case;
    
      case c.fno2
        when fno_poste then
          select g3e_geometry
            into geom2
            from b$pole_pt
           where g3e_fid = c.fid2;
        when fno_torre then
          select g3e_geometry
            into geom2
            from b$tower_pt
           where g3e_fid = c.fid2;
        when fno_pontalete then
          select g3e_geometry
            into geom2
            from b$pontalete_pt
           where g3e_fid = c.fid2;
        when fno_pontonotavel then
          select g3e_geometry
            into geom2
            from b$structure_pt
           where g3e_fid = c.fid2;
      end case;
      
      vramal_ln.g3e_geometry := carga_pontos2linha(geom1, geom2);
      
      insert into b$ramal_ln values vramal_ln;
      commit;
      
    
    exception
      when others then
        continue;
    end;
  
  end loop;
  
  
  
  
  for c in (select c0.g3e_fid     as fid_ramal,
                   c0.subset,
                   c0.location    codid1,
                   c1.g3e_fid     fid1,
                   c1.g3e_fno     fno1,
                   c0.street_name codid2,
                   c2.g3e_fid     fid2,
                   c2.g3e_fno     fno2
              from b$common_n c0
             inner join b$common_n c1
                on c1.cod_id = c0.location
             inner join b$common_n c2
                on c2.cod_id = c0.street_name
             where c0.g3e_fno = 235
               and c0.subset = 'RORAIMA'
               and c0.subset = c1.subset
               and c0.subset = c2.subset) loop
    begin
      vramal_ln         := null;
      vramal_ln.g3e_fid := c.fid_ramal;
      vramal_ln.g3e_cno := 23502;
      vramal_ln.g3e_fno := fno_ramal;
      vramal_ln.g3e_cid := 1;
      vramal_ln.g3e_id  := ramal_ln_seq.nextval;
      vramal_ln.ltt_id  := 0;
    
      case c.fno1
        when fno_poste then
          select g3e_geometry
            into geom1
            from b$pole_pt
           where g3e_fid = c.fid1;
        when fno_torre then
          select g3e_geometry
            into geom1
            from b$tower_pt
           where g3e_fid = c.fid1;
        when fno_pontalete then
          select g3e_geometry
            into geom1
            from b$pontalete_pt
           where g3e_fid = c.fid1;
        when fno_pontonotavel then
          select g3e_geometry
            into geom1
            from b$structure_pt
           where g3e_fid = c.fid1;
      end case;
    
      case c.fno2
        when fno_poste then
          select g3e_geometry
            into geom2
            from b$pole_pt
           where g3e_fid = c.fid2;
        when fno_torre then
          select g3e_geometry
            into geom2
            from b$tower_pt
           where g3e_fid = c.fid2;
        when fno_pontalete then
          select g3e_geometry
            into geom2
            from b$pontalete_pt
           where g3e_fid = c.fid2;
        when fno_pontonotavel then
          select g3e_geometry
            into geom2
            from b$structure_pt
           where g3e_fid = c.fid2;
      end case;
      
      vramal_ln.g3e_geometry := carga_pontos2linha(geom1, geom2);
      
      insert into b$ramal_ln values vramal_ln;
      commit;
      
    
    exception
      when others then
        continue;
    end;
  
  end loop;
  
  execute immediate 'ALTER TABLE B$RAMAL_LN  ENABLE ALL TRIGGERS';

end;
