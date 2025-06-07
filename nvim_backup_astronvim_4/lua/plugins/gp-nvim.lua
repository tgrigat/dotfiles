return {
  "robitx/gp.nvim",
  config = function(_, opts)
    -- Only setup the plugin if OPENAI_API_KEY environment variable exists
    if vim.fn.getenv "OPENAI_API_KEY" ~= vim.NIL then
      require("gp").setup(opts)
      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)
      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end
  end,
  opts = {
    agents = {
      {
        name = "ChatGPT3-5",
        disable = true,
      },
      -- {
      --   name = "MyCustomAgent",
      --   provider = "copilot",
      --   chat = true,
      --   command = true,
      --   model = { model = "gpt-4-turbo" },
      --   system_prompt = "Answer any query with just: Sure thing..",
      -- },
      {
        name = "Thesis Assistant",
        chat = true,
        command = false,
        -- string with model name or table with model name and parameters
        model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
        -- system prompt (use this to specify the persona/role of the AI)
        -- system_prompt = "You are a general AI assistant.\n\n"
        --   .. "The user provided the additional info about how they would like you to respond:\n\n"
        --   .. "- If you're unsure don't guess and say you don't know instead.\n"
        --   .. "- Ask question if you need clarification to provide better answer.\n"
        --   .. "- Think deeply and carefully from first principles step by step.\n"
        --   .. "- Zoom out first to see the big picture and then zoom in to details.\n"
        --   .. "- Use Socratic method to improve your thinking and coding skills.\n"
        --   .. "- Don't elide any code from your output if the answer requires coding.\n"
        --   .. "- Take a deep breath; You've got this!\n",
        system_prompt = "You are an AI assistant that is good at academic writing. \n\n "
          .. "The user need assistance in transforming his academic outline or draft into well-structured and coherent academic writing. \n\n"
          .. "- If you decide that the request is ambiguous or unclear, please ask for clarification. \n"
          .. "- The user is a non-native speaker, and he prefers a writing style that is accurate and easy to understand without being overly showy or exaggerated. \n"
          .. "- Bridge the logic and expression of the user's idea if necessary \n"
          .. "- If content is provided as bullet points, then it is a outline, please expand on the points and provide a well-structured and coherent academic writing. \n"
          .. "- If content is provided as paragraphs, then it is a draft, please revise and improve the writing. Don't expand the draft too much unless specified otherwise.  \n"
          .. "- When additional context are provided, % is used as the comment symbol, which indicates the overall idea of the following paragpraphs in the context. \n",
      },

      -- You are an AI programming assistant. Follow the user's requirements carefully and to the letter. First, think step-by-step and describe your plan for what to build in pseudocode, written out in great detail. Then, output the code in a single code block. Minimize any other prose.
      {
        name = "Code Assistant",
        chat = true,
        command = false,
        -- string with model name or table with model name and parameters
        model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
        system_prompt = "You are an AI programming assistant. Follow the user's requirements carefully and to the letter. First, think step-by-step and describe your plan for what to build in pseudocode, written out in great detail. Then, output the code in a single code block. Minimize any other prose. \n\n ",
      },
    },
    default_chat_agent = "Thesis Assistant",
  },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>a"] = { name = "AI Chat" },
            ["<Leader>at"] = { name = "Toggle" },
            ["<Leader>atv"] = { "<cmd>GpChatToggle vsplit<cr>", desc = "Toggle Vsplit" },
            ["<Leader>ats"] = { "<cmd>GpChatToggle split<cr>", desc = "Toggle Split" },
            ["<Leader>att"] = { "<cmd>GpChatToggle tabnew<cr>", desc = "Toggle New Tab" },
            ["<Leader>atp"] = { "<cmd>GpChatToggle popup<cr>", desc = "Toggle Popup" },
            ["<Leader>av"] = { "<cmd>GpChatToggle vsplit<cr>", desc = "Toggle Vsplit" },
            ["<Leader>af"] = { "<cmd>GpChatFinder<cr>", desc = "Search History" },
            ["<Leader>ad"] = { "<cmd>GpChatDelete<cr>", desc = "Delete Current" },
            ["<Leader>an"] = { "<cmd>GpChatNew<cr>", desc = "New Chat" },
            ["<Leader>aa"] = { "<cmd>GpChatRespond<cr>", desc = "Response" },
          },
          v = {
            ["<Leader>a"] = { name = "AI Chat" },
            ["<Leader>at"] = { name = "To" },
            ["<Leader>atv"] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", desc = "Vsplit" },
            ["<Leader>ats"] = { "<cmd>'<,'>GpChatPaste split<cr>", desc = "Split" },
            ["<Leader>att"] = { "<cmd>'<,'>GpChatPaste tabnew<cr>", desc = "New Tab" },
            ["<Leader>atp"] = { "<cmd>'<,'>GpChatPaste popup<cr>", desc = "Popup" },
            ["<Leader>av"] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", desc = "Send to Vsplit" },
            ["<Leader>ap"] = { "<cmd>'<,'>GpChatPaste<cr>", desc = "Send to Last" },
            ["<Leader>ar"] = { name = "Write" },
            ["<Leader>ara"] = { "<cmd>'<,'>GpAppend<cr>", desc = "Append Answer" },
            ["<Leader>arp"] = { "<cmd>'<,'>GpPrepend<cr>", desc = "Prepend Answer" },
            ["<Leader>arr"] = { "<cmd>'<,'>GpRewrite<cr>", desc = "Rewrite selection" },
            ["<Leader>ari"] = { "<cmd>'<,'>GpImplement<cr>", desc = "Implement From Comment" },
            ["<Leader>ac"] = { "<cmd>'<,'>GpContext vsplit<cr>", desc = "Add Context" },
          },
        },
      },
    },
  },
}
