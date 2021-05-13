create or replace procedure carga_componente_texto_condutor_pri is

  type array_subset is varray(2) of varchar2(10);
  subset array_subset := array_subset('AMAZONAS', 'RORAIMA');

  vpricond_lb b$pricond_lb%rowtype;

  fno_conductorpri number(5) default 306;

begin

  --deletando registros conductor secundario
  execute immediate 'ALTER TABLE B$PRICOND_LB DISABLE ALL TRIGGERS';
  delete from b$pricond_lb l
   where exists (select 1
            from b$common_n
           where g3e_fno = fno_conductorpri
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;

  for i in 1 .. subset.count loop
  
    --texto condcutor primario
    for c in (select a.g3e_fid, a.g3e_fno, 30603 as g3e_cno, a.g3e_geometry
                from b$pricond_ln a
               inner join b$common_n b
                  on b.g3e_fid = a.g3e_fid
                 and b.g3e_fno = fno_conductorpri
               where b.subset = subset(i)) loop
      begin
        vpricond_lb          := null;
        vpricond_lb.g3e_fid  := c.g3e_fid;
        vpricond_lb.g3e_cno  := c.g3e_cno;
        vpricond_lb.g3e_fno  := c.g3e_fno;
        vpricond_lb.g3e_cid  := 1;
        vpricond_lb.g3e_id   := pricond_lb_seq.nextval;
        vpricond_lb.ltt_id   := 0;
        vpricond_lb.ltt_date := sysdate;
      
        vpricond_lb.g3e_geometry := carga_puntomedio(spatial_utils.linear.st_parallel(c.g3e_geometry, 0.00002, 0.01));
        
        insert into b$pricond_lb values vpricond_lb;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
    --fim texto conductor primario
  
  end loop;

  execute immediate 'ALTER TABLE B$PRICOND_LB ENABLE ALL TRIGGERS';

end;
