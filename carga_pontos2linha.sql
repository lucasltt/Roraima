create or replace function carga_pontos2linha(geom1 in sdo_geometry,
                                              geom2 in sdo_geometry)
  return sdo_geometry is

  /* Created by Lucas Turchet
     14/04/2021
     This function takes 2 sdo_geometryd and converts into a line assuming srid 4674
  */

  x1 number default 0;
  x2 number default 0;
  y1 number default 0;
  y2 number default 0;

  geomfinal sdo_geometry;

begin

  select t.x, t.y
    into x1, y1
    from table(sdo_util.GetVertices(geom1)) t
   where t.id = 1;

  select t.x, t.y
    into x2, y2
    from table(sdo_util.GetVertices(geom2)) t
   where t.id = 1;

  geomfinal := sdo_geometry(3002,
                            4674,
                            null,
                            sdo_elem_info_array(1, 2, 1),
                            sdo_ordinate_array(x1, y1, 0, x2, y2, 0));

  return geomfinal;
end;
