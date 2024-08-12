--[[
  Original work: veeponym, https://gist.github.com/veeponym/6a8f7ba661032ddce1e941095a998a69
]]

-- Define a dotenv object
local dotenv = {
  -- Define an env object which will contain our environment variables
  env = {}
}

--- Reads a file
--- Returns its contents as a string or `nil` with an error
---@param filename string
---@return string?
---@return string?
local function read_file(filename)
  -- Open the file in read mode
  local file = io.open(filename, 'r')
  -- Check if the file exists
  if not file then
    -- Return nil and an error message
    return nil, 'File not found: ' .. filename
  end
  -- Read the whole file content
  local content = file:read('*a')
  -- Close the file
  file:close()
  -- Return the content
  return content
end

--- Parses the `.env` file's content
--- Returns a table of key-value pairs
---@param content string
---@return table
local function parse_env(content)
  -- Create an empty table to store the pairs
  local items = {}
  -- Loop through each line in the content
  for line in content:gmatch('[^\r\n]+') do
    -- Trim any leading or trailing whitespace from the line
    line = line:match('^%s*(.-)%s*$')
    -- Ignore empty lines or lines starting with #
    if line ~= '' and line:sub(1, 1) ~= '#' then
      -- Split the line by the first = sign
      local key, value = line:match('([^=]+)=(.*)')
      -- Trim any leading or trailing whitespace from the key and value
      key = key:match('^%s*(.-)%s*$')
      value = value:match('^%s*(.-)%s*$')
      -- Check if the value is surrounded by double quotes
      if value:sub(1, 1) == '"' and value:sub(-1, -1) == '"' then
        -- Remove the quotes and unescape any escaped characters
        value = value:sub(2, -2):gsub('\\"', '"')
      end
      -- Check if the value is surrounded by single quotes
      if value:sub(1, 1) == "'" and value:sub(-1, -1) == "'" then
        -- Remove the quotes
        value = value:sub(2, -2)
      end
      -- Store the key-value pair in the table
      items[key] = value
    end
  end
  -- Return the table
  return items
end

--- Gets the environment variable from the .env file or directly from the os
--- Returns the value of that variable or nil
---@param env string
---@return string?
function dotenv.env.get(env)
  dotenv.env[env] = dotenv.env[env] or os.getenv(env)
  return dotenv.env[env]
end

--- Loads the specified file or a `.env` file
--- Returns the env table or the env table with an error
---@param filename? string
function dotenv.load(filename)
  -- Use .env as the default filename if not provided
  filename = filename or '.env'
  -- Read the file content
  local content, err = read_file(filename)
  -- Check if there was an error
  if not content then
    -- Return the empty table and the error message
    return dotenv.env, err
  end
  -- Parse the file content
  local items = parse_env(content)
  -- Loop through the pairs
  for key, value in pairs(items) do
    -- Check if the key is not already in the env table
    if not dotenv.env[key] then
      -- Set the key-value pair in the env table
      dotenv.env[key] = value
    end
  end
  -- Return env table
  return dotenv.env
end

-- Return the dotenv object
return dotenv
