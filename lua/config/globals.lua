-- global variables
PYTHON_PATH = ''
local host_handle = io.popen('hostname')
if host_handle ~= nil then
  local hostname = host_handle:read('*a')
  hostname = string.gsub(hostname, "\n$", "")
  if hostname == 'C02C2107MD6V' or hostname == 'JVGHGJ0H40' then
    PYTHON_PATH = '/Users/bassamsafadi/work/data/job-controller/.tox/py39/bin/python3.9'
  else
    PYTHON_PATH = vim.fn.exepath("python")
  end
  host_handle:close()
end
