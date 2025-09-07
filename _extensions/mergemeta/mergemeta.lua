local ute = require "devutils"

--[-- 07/09/25uh
-- updating table t1 with values from t2, recursing into nested tables
-- key values that occur in both t1 and t2 and are not tables are replaced
-- if t1 and t2 contain keys with values of different type, an error is thrown
--]--

function tableupdate(t1, t2)
  local vv
  if type(t1) ~= "table" then error("tableupdate: t1 is not a table", 2) end
  if type(t2) ~= "table" then error("tableupdate: t2 is not a table", 2) end
  for k, v in pairs(t2) do
    if type(k) == "number"
      then table.insert(t1, v)
      else -- check if included
         if t1[k] == nil
          then t1[k] = v
          else
            -- overwrite, check if same type
            if type(v) ~= type(t1[k])
              then
                error('tableupdate: new and old entries at key "'..k..'" are not of same type')
              else
                -- if not a table, just overwrite
                if type(v) ~= "table"
                  then vv = v
                  else vv = tableupdate(t1[k], v)
                  end
                t1[k] = vv
            end
         end
    end
  end
  return t1
end

function ykout (m)
  if m["Ykeys-local"] then
    Ykloc = m["Ykeys-local"]
    if Ykloc.X then print ("Ykloc.X = ".. pandoc.utils.stringify(Ykloc.X)) 
      print("Yloc.X.a: "..pandoc.utils.stringify(type(Ykloc.X)))
    end
    ute.tprint(m["Ykeys-local"])
  end
end


-- merge keys
function Meta(m)
  ykout(m)
  if m.mergemeta 
  then 
    print("merging stuff")
    for k, v in pairs(m.mergemeta) do
      vstr = pandoc.utils.stringify(v) 
      if m[vstr] == nil then
        print("nothing to merge in, "..vstr.." not found")
      else  
        if m[k] == nil then
          print("no original key "..k.." - create new from "..vstr)
          m[k] = m[vstr]
        else 
          print("update "..k.." with ".. vstr) 
          if type(m[k]) == "table" then
            -- check if string: just replace 
            if false then
               tableupdate(m[k], m[vstr])
            end   
            else m[k] = m[vstr]  
          end   
        end
    end
    end
  end
  ykout(m)
  return m
end


