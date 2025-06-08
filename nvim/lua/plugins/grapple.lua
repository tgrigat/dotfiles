return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
        icons = false, -- setting to "true" requires "nvim-web-devicons"
        status = false,
    },
    keys = {
        { "<leader>ga", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
        { "<leader>ge", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

        { "<leader>g1", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
        { "<leader>g2", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
        { "<leader>g3", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
        { "<leader>g4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
        { "<leader>gn", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
        { "<leader>gp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
    },
}
