local plug_ok, plug = pcall(require, "mason")
if not plug_ok then return end

plug.setup()
