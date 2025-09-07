--[[
MIT License

Copyright (c) 2025 Ute Hahn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--
-- pre-pre-release

-- local ute = require "devutils"

--[-- 07/09/25uh
-- updating table t1 with values from t2, recursing into nested tables
-- key values that occur in both t1 and t2 and are not tables are replaced
-- if t1 and t2 contain keys with values of different type, an error is thrown
--]--

function tableupdate(t1, t2)
  local vv
  if type(t1) ~= "table" then error("tableupdate: t1 is not a table", 2) end
  if type(t2) ~= "table" then error("tableupdate: t2 is not a table", 2) end
  -- print("-------- updating table t1: ")
  -- ute.tprint(t1)
  -- print("-------- with t2:")
  -- ute.tprint(t2)
  -- print("------------------")
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
                -- if not a table, or if a simple pandoc string, just overwrite
                if type(v) ~= "table" or  pandoc.utils.type(v) == "Inlines"
                  then vv = v
                  else
                    --print("recurse") 
                    --print(k.." has pandoctype "..pandoc.utils.type(v))
                     vv = tableupdate(t1[k], v)
                  end
                t1[k] = vv
            end
         end
    end
  end
  -- print("---- result ------")
  -- ute.tprint(t1)
  -- print("==============")
  return t1
end


-- merge keys
function Meta(m)
  if m.mergemeta 
  then 
    print("merging meta keys")
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
            -- check if string: just replace (Pandoc Inline) 
            -- print("Pandoctype: "..pandoc.utils.type(m[k]))
            tableupdate(m[k], m[vstr])
            --else m[k] = m[vstr]  
          end   
        end
    end
    end
  end
  return m
end


