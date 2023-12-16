-- global variables
PYTHON_PATH = ''
local host_handle = io.popen('hostname')
if host_handle ~= nil then
  local hostname = host_handle:read('*a')
  hostname = string.gsub(hostname, "\n$", "")
  if hostname == 'C02C2107MD6V' then
    PYTHON_PATH = '/Users/bassamsafadi/work/data/job-controller/.tox/py39/bin/python3.9'
  else
    local pypath_handle = io.popen('which python3')
    if pypath_handle ~= nil then
      PYTHON_PATH = pypath_handle:read("*a")
      pypath_handle:close()
    end
  end
  host_handle:close()
end
