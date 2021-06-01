create or replace procedure carga_polecond is

  type array_subset is varray(2) of varchar2(10);
  subset array_subset := array_subset('AMAZONAS', 'RORAIMA');

  vpole_cond_n b$pole_cond_n%rowtype;

  --fnos filhos 2 nos (pais) (316, 306, 302, 235)
  --fno filhos 1 no (pais) (318, 305, 315)

begin

  --deletando registros importados - SOMENTE FILHOS
  execute immediate 'ALTER TABLE B$POLE_COND_N DISABLE ALL TRIGGERS';

  delete from b$pole_cond_n l
   where exists (select 1
            from b$common_n
           where g3e_fno in (318, 305, 315, 316, 306, 302, 235)
             and job_place_name = 'MIGRACAO'
             and g3e_fid = l.g3e_fid);
  commit;
  for i in 1 .. subset.count loop
  
    --filhos com 1 nó (pai)
    for c in (select a.g3e_fid,
                     a.g3e_fno,
                     a.cod_id,
                     a.location cod_id_pai,
                     b.g3e_fid  g3e_fid_pai,
                     b.g3e_fno  g3e_fno_pai
                from b$common_n a
               inner join b$common_n b
                  on b.cod_id = a.location
               where a.g3e_fno in (318, 305, 315)
                 and b.g3e_fno not in (230, 209, 208, 260)
                 and a.subset = subset(i)
                 and b.subset = a.subset) loop
      begin
        vpole_cond_n              := null;
        vpole_cond_n.g3e_fid      := c.g3e_fid;
        vpole_cond_n.g3e_cno      := 30660;
        vpole_cond_n.g3e_fno      := c.g3e_fno;
        vpole_cond_n.g3e_cid      := 1;
        vpole_cond_n.g3e_id       := pole_cond_n_seq.nextval;
        vpole_cond_n.ltt_id       := 0;
        vpole_cond_n.ltt_date     := sysdate;
        vpole_cond_n.g3e_ownerfno := c.g3e_fno_pai;
        vpole_cond_n.g3e_ownerfid := c.g3e_fid_pai;
      
        insert into b$pole_cond_n values vpole_cond_n;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
  
    --filhos com 2 nó (pai)
    for c in (select a.g3e_fid,
                     a.g3e_fno,
                     a.cod_id,
                     b.g3e_fid g3e_fid_pai1,
                     b.g3e_fno g3e_fno_pai1,
                     c.g3e_fid g3e_fid_pai2,
                     c.g3e_fno g3e_fno_pai2
                from b$common_n a
               inner join b$common_n b
                  on b.cod_id = a.location
               inner join b$common_n c
                  on c.cod_id = a.street_name
               where a.g3e_fno in (316, 306, 302, 235)
                 and b.g3e_fno in (230, 209, 208, 260)
                 and a.subset = subset(i)
                 and b.subset = a.subset
                 and c.subset = a.subset) loop
      begin
        
        vpole_cond_n              := null;
        vpole_cond_n.g3e_fid      := c.g3e_fid;
        vpole_cond_n.g3e_cno      := 30660;
        vpole_cond_n.g3e_fno      := c.g3e_fno;
        vpole_cond_n.g3e_cid      := 1;
        vpole_cond_n.g3e_id       := pole_cond_n_seq.nextval;
        vpole_cond_n.ltt_id       := 0;
        vpole_cond_n.ltt_date     := sysdate;
        vpole_cond_n.g3e_ownerfno := c.g3e_fno_pai1;
        vpole_cond_n.g3e_ownerfid := c.g3e_fid_pai1;
      
        insert into b$pole_cond_n values vpole_cond_n;
        commit;
      
        vpole_cond_n              := null;
        vpole_cond_n.g3e_fid      := c.g3e_fid;
        vpole_cond_n.g3e_cno      := 30660;
        vpole_cond_n.g3e_fno      := c.g3e_fno;
        vpole_cond_n.g3e_cid      := 2;
        vpole_cond_n.g3e_id       := pole_cond_n_seq.nextval;
        vpole_cond_n.ltt_id       := 0;
        vpole_cond_n.ltt_date     := sysdate;
        vpole_cond_n.g3e_ownerfno := c.g3e_fno_pai2;
        vpole_cond_n.g3e_ownerfid := c.g3e_fid_pai2;
      
        insert into b$pole_cond_n values vpole_cond_n;
        commit;
      
      exception
        when others then
          continue;
      end;
    
    end loop;
  
  end loop;

  execute immediate 'ALTER TABLE B$POLE_COND_N ENABLE ALL TRIGGERS';

end;
