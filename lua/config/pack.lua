local plugins = require("plugins")

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name == "blink.cmp" and (kind == "install" or kind == "update") then
      if vim.fn.executable("cargo") == 1 then
        vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
      end
    end
  end,
})

vim.pack.add(plugins.specs, {
  confirm = false,
  load = true,
})

plugins.setup()
