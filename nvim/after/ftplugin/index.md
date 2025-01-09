# File Type Plugins

Different languages have different file types they are associated with.
Setting options for a single file type, or overriding an option for a single file type is as easy
as the following:

1. Create file for that file type. E.g. `lua.lua`
2. Add options/overrides for that file type.

```lua
    vim.opt_local.shiftwidth = 2
```

3. Re-edit or re-opening the file will apply changes instantly. `:e`

