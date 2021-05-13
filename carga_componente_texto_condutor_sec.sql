create or replace procedure carga_componente_texto_condutor_sec is

  type array_subset is varray(2) of varchar2(10);
  subset array_subset := array_subset('AMAZONAS', 'RORAIMA');

  vseccond_lb b$seccond_lb%rowtype;

  fno_conductorsec number(5) default 316;

begin

  --deletando registros conductor secundario
  execute immediate 'ALTER TABLE B$SECCOND_LB DISABLE ALL TRIGGERS';
  delete from B$SECCOND_LB l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_conductorsec
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  for i in 1 .. subset.count loop
  
    --texto condcutor secundario
    for c in (select a.g3e_fid, a.g3e_fno, 31603 as g3e_cno, a.g3e_geometry
                from B$SECCOND_LN a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_conductorsec
               where b.subset = subset(i)) loop
      begin
        vseccond_lb          := null;
        vseccond_lb.g3e_fid  := c.g3e_fid;
        vseccond_lb.g3e_cno  := c.g3e_cno;
        vseccond_lb.g3e_fno  := c.g3e_fno;
        vseccond_lb.g3e_cid  := 1;
        vseccond_lb.g3e_id   := seccond_lb_seq.nextval;
        vseccond_lb.ltt_id   := 0;
        vseccond_lb.ltt_date := sysdate;
      
        vseccond_lb.g3e_geometry := carga_puntomedio(spatial_utils.linear.st_parallel(c.g3e_geometry, 0.00002, 0.01));
        
        insert into b$seccond_lb values vseccond_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fim texto conductor secundario
  
  end loop;

  execute immediate 'ALTER TABLE B$SECCOND_LB ENABLE ALL TRIGGERS';

end;
