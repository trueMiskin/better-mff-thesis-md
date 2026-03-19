-- Edited: https://github.com/rnwst/pandoc-lua-crossrefs/blob/master/lib/utils.lua
---Require a module from the filter directory.
local require = function(modname) -- luacheck: ignore 122
    return pandoc.system.with_working_directory(
       pandoc.path.directory(PANDOC_SCRIPT_FILE),
       function() return require(modname) end
    )
 end
 
local parse_attr = require('lib/parse-attr')
 
---@param doc Pandoc
 function Pandoc(doc) 
    return doc:walk({
       Table = parse_attr.parse_table_attr,
       Inlines = parse_attr.parse_equation_attr,
    })
       :walk({
          Span = parse_attr.remove_temp_classes,
       })
 end