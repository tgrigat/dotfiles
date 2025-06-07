-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes

vim.filetype.add {
  extension = {
    bean = "beancount",
    beancount = "beancount",
  },
  -- This example doesn't use filename or pattern, but they are left here for completeness
  filename = {
    -- Add specific filenames if needed
  },
  pattern = {
    -- Add patterns if needed
  },
}

