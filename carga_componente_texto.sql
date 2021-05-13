create or replace procedure carga_componente_texto is

  type array_subset is varray(2) of varchar2(10);
  subset array_subset := array_subset('AMAZONAS', 'RORAIMA');

  vpole_lb      b$pole_lb%rowtype;
  vtower_lb     b$tower_lb%rowtype;
  vpontalete_lb b$pontalete_lb%rowtype;
  vstructure_lb b$structure_lb%rowtype;
  vxfmr_lb      b$xfmr_lb%rowtype;

  fno_poste        number(5) default 208;
  fno_torre        number(5) default 260;
  fno_pontalete    number(5) default 230;
  fno_pontonotavel number(5) default 209;
  fno_transfdist   number(5) default 314;

begin

  --deletando registros poste 
  execute immediate 'ALTER TABLE B$POLE_LB DISABLE ALL TRIGGERS';
  delete from B$POLE_LB l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_poste
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  --deletando registros torre
  execute immediate 'ALTER TABLE B$TOWER_LB DISABLE ALL TRIGGERS';
  delete from B$TOWER_LB l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_torre
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  --deletando registros pontalete
  execute immediate 'ALTER TABLE B$PONTALETE_LB DISABLE ALL TRIGGERS';
  delete from B$PONTALETE_LB l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_pontalete
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  --deletando registros ponto notavel
  execute immediate 'ALTER TABLE B$STRUCTURE_LB DISABLE ALL TRIGGERS';
  delete from B$STRUCTURE_LB l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_pontonotavel
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  --deletando registros transformador
  execute immediate 'ALTER TABLE B$XFMR_LB DISABLE ALL TRIGGERS';
  delete from B$XFMR_LB l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_transfdist
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  for i in 1 .. subset.count loop
  
    --texto poste
    for c in (select a.g3e_fid, a.g3e_fno, 20803 as g3e_cno, a.g3e_geometry
                from b$pole_pt a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_poste
               where b.subset = subset(i)) loop
      begin
        vpole_lb          := null;
        vpole_lb.g3e_fid  := c.g3e_fid;
        vpole_lb.g3e_cno  := c.g3e_cno;
        vpole_lb.g3e_fno  := c.g3e_fno;
        vpole_lb.g3e_cid  := 1;
        vpole_lb.g3e_id   := pole_lb_seq.nextval;
        vpole_lb.ltt_id   := 0;
        vpole_lb.ltt_date := sysdate;
      
        vpole_lb.g3e_geometry := sdo_util.AffineTransforms(geometry    => c.g3e_geometry,
                                                           translation => 'TRUE',
                                                           tx          => 0.00005,
                                                           ty          => 0.00005,
                                                           tz          => 0.0,
                                                           scaling     => 'FALSE',
                                                           psc1        => NULL,
                                                           sx          => 0.0,
                                                           sy          => 0.0,
                                                           sz          => 0.0,
                                                           rotation    => 'FALSE',
                                                           p1          => NULL,
                                                           angle       => 0.0,
                                                           dir         => -1,
                                                           line1       => NULL,
                                                           shearing    => 'FALSE',
                                                           shxy        => 0.0,
                                                           shyx        => 0.0,
                                                           shxz        => 0.0,
                                                           shzx        => 0.0,
                                                           shyz        => 0.0,
                                                           shzy        => 0.0,
                                                           reflection  => 'FALSE',
                                                           pref        => NULL,
                                                           lineR       => NULL,
                                                           dirR        => -1,
                                                           planeR      => 'FALSE',
                                                           n           => NULL,
                                                           bigD        => NULL);
      
        insert into b$pole_lb values vpole_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fim texto poste
  
    --texto torre
    for c in (select a.g3e_fid, a.g3e_fno, 26003 as g3e_cno, a.g3e_geometry
                from b$tower_pt a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_torre
               where b.subset = subset(i)) loop
      begin
        vtower_lb          := null;
        vtower_lb.g3e_fid  := c.g3e_fid;
        vtower_lb.g3e_cno  := c.g3e_cno;
        vtower_lb.g3e_fno  := c.g3e_fno;
        vtower_lb.g3e_cid  := 1;
        vtower_lb.g3e_id   := tower_lb_seq.nextval;
        vtower_lb.ltt_id   := 0;
        vtower_lb.ltt_date := sysdate;
      
        vtower_lb.g3e_geometry := sdo_util.AffineTransforms(geometry    => c.g3e_geometry,
                                                            translation => 'TRUE',
                                                            tx          => 0.00005,
                                                            ty          => 0.00005,
                                                            tz          => 0.0,
                                                            scaling     => 'FALSE',
                                                            psc1        => NULL,
                                                            sx          => 0.0,
                                                            sy          => 0.0,
                                                            sz          => 0.0,
                                                            rotation    => 'FALSE',
                                                            p1          => NULL,
                                                            angle       => 0.0,
                                                            dir         => -1,
                                                            line1       => NULL,
                                                            shearing    => 'FALSE',
                                                            shxy        => 0.0,
                                                            shyx        => 0.0,
                                                            shxz        => 0.0,
                                                            shzx        => 0.0,
                                                            shyz        => 0.0,
                                                            shzy        => 0.0,
                                                            reflection  => 'FALSE',
                                                            pref        => NULL,
                                                            lineR       => NULL,
                                                            dirR        => -1,
                                                            planeR      => 'FALSE',
                                                            n           => NULL,
                                                            bigD        => NULL);
      
        insert into b$tower_lb values vtower_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fin texto torre
  
    --texto pontalete
    for c in (select a.g3e_fid, a.g3e_fno, 23003 as g3e_cno, a.g3e_geometry
                from b$pontalete_pt a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_pontalete
               where b.subset = subset(i)) loop
      begin
        vpontalete_lb          := null;
        vpontalete_lb.g3e_fid  := c.g3e_fid;
        vpontalete_lb.g3e_cno  := c.g3e_cno;
        vpontalete_lb.g3e_fno  := c.g3e_fno;
        vpontalete_lb.g3e_cid  := 1;
        vpontalete_lb.g3e_id   := pontalete_lb_seq.nextval;
        vpontalete_lb.ltt_id   := 0;
        vpontalete_lb.ltt_date := sysdate;
      
        vpontalete_lb.g3e_geometry := sdo_util.AffineTransforms(geometry    => c.g3e_geometry,
                                                                translation => 'TRUE',
                                                                tx          => 0.00005,
                                                                ty          => 0.00005,
                                                                tz          => 0.0,
                                                                scaling     => 'FALSE',
                                                                psc1        => NULL,
                                                                sx          => 0.0,
                                                                sy          => 0.0,
                                                                sz          => 0.0,
                                                                rotation    => 'FALSE',
                                                                p1          => NULL,
                                                                angle       => 0.0,
                                                                dir         => -1,
                                                                line1       => NULL,
                                                                shearing    => 'FALSE',
                                                                shxy        => 0.0,
                                                                shyx        => 0.0,
                                                                shxz        => 0.0,
                                                                shzx        => 0.0,
                                                                shyz        => 0.0,
                                                                shzy        => 0.0,
                                                                reflection  => 'FALSE',
                                                                pref        => NULL,
                                                                lineR       => NULL,
                                                                dirR        => -1,
                                                                planeR      => 'FALSE',
                                                                n           => NULL,
                                                                bigD        => NULL);
      
        insert into b$pontalete_lb values vpontalete_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fin texto pontalete
  
    --texto ponto notavel
    for c in (select a.g3e_fid, a.g3e_fno, 20903 as g3e_cno, a.g3e_geometry
                from b$structure_pt a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_pontonotavel
               where b.subset = subset(i)) loop
      begin
        vstructure_lb          := null;
        vstructure_lb.g3e_fid  := c.g3e_fid;
        vstructure_lb.g3e_cno  := c.g3e_cno;
        vstructure_lb.g3e_fno  := c.g3e_fno;
        vstructure_lb.g3e_cid  := 1;
        vstructure_lb.g3e_id   := structure_lb_seq.nextval;
        vstructure_lb.ltt_id   := 0;
        vstructure_lb.ltt_date := sysdate;
      
        vstructure_lb.g3e_geometry := sdo_util.AffineTransforms(geometry    => c.g3e_geometry,
                                                                translation => 'TRUE',
                                                                tx          => 0.00005,
                                                                ty          => 0.00005,
                                                                tz          => 0.0,
                                                                scaling     => 'FALSE',
                                                                psc1        => NULL,
                                                                sx          => 0.0,
                                                                sy          => 0.0,
                                                                sz          => 0.0,
                                                                rotation    => 'FALSE',
                                                                p1          => NULL,
                                                                angle       => 0.0,
                                                                dir         => -1,
                                                                line1       => NULL,
                                                                shearing    => 'FALSE',
                                                                shxy        => 0.0,
                                                                shyx        => 0.0,
                                                                shxz        => 0.0,
                                                                shzx        => 0.0,
                                                                shyz        => 0.0,
                                                                shzy        => 0.0,
                                                                reflection  => 'FALSE',
                                                                pref        => NULL,
                                                                lineR       => NULL,
                                                                dirR        => -1,
                                                                planeR      => 'FALSE',
                                                                n           => NULL,
                                                                bigD        => NULL);
      
        insert into b$structure_lb values vstructure_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fin texto ponto notavel
  
    --texto transformador distribuição
    for c in (select a.g3e_fid, a.g3e_fno, 31403 as g3e_cno, a.g3e_geometry
                from b$xfmr_pt a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_transfdist
               where b.subset = subset(i)) loop
      begin
        vxfmr_lb          := null;
        vxfmr_lb.g3e_fid  := c.g3e_fid;
        vxfmr_lb.g3e_cno  := c.g3e_cno;
        vxfmr_lb.g3e_fno  := c.g3e_fno;
        vxfmr_lb.g3e_cid  := 1;
        vxfmr_lb.g3e_id   := xfmr_lb_seq.nextval;
        vxfmr_lb.ltt_id   := 0;
        vxfmr_lb.ltt_date := sysdate;
      
        vxfmr_lb.g3e_geometry := sdo_util.AffineTransforms(geometry    => c.g3e_geometry,
                                                           translation => 'TRUE',
                                                           tx          => 0.00007,
                                                           ty          => 0.00007,
                                                           tz          => 0.0,
                                                           scaling     => 'FALSE',
                                                           psc1        => NULL,
                                                           sx          => 0.0,
                                                           sy          => 0.0,
                                                           sz          => 0.0,
                                                           rotation    => 'FALSE',
                                                           p1          => NULL,
                                                           angle       => 0.0,
                                                           dir         => -1,
                                                           line1       => NULL,
                                                           shearing    => 'FALSE',
                                                           shxy        => 0.0,
                                                           shyx        => 0.0,
                                                           shxz        => 0.0,
                                                           shzx        => 0.0,
                                                           shyz        => 0.0,
                                                           shzy        => 0.0,
                                                           reflection  => 'FALSE',
                                                           pref        => NULL,
                                                           lineR       => NULL,
                                                           dirR        => -1,
                                                           planeR      => 'FALSE',
                                                           n           => NULL,
                                                           bigD        => NULL);
      
        insert into b$xfmr_lb values vxfmr_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fin texto transformador distribuição
  
  end loop;

  execute immediate 'ALTER TABLE B$POLE_LB ENABLE ALL TRIGGERS';
  execute immediate 'ALTER TABLE B$TOWER_LB ENABLE ALL TRIGGERS';
  execute immediate 'ALTER TABLE B$PONTALETE_LB ENABLE ALL TRIGGERS';
  execute immediate 'ALTER TABLE B$STRUCTURE_LB ENABLE ALL TRIGGERS';
  execute immediate 'ALTER TABLE B$XFMR_LB ENABLE ALL TRIGGERS';

end;
