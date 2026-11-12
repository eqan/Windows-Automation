#If Vim.IsVimGroup() and (Vim.State.IsCurrentVimMode("Vim_Normal"))
:::Vim.State.SetMode("Command") ;(:)
`;::Vim.State.SetMode("Command") ;(;)
#If Vim.IsVimGroup() and (Vim.State.IsCurrentVimMode("Command"))
w::Vim.State.SetMode("Command_w")
h::
  Send, {F1}
  Vim.State.SetMode("Vim_Normal")
Return

#If Vim.IsVimGroup() and (Vim.State.IsCurrentVimMode("Command_w"))
Return::
  Send, ^s
  Vim.State.SetMode("Vim_Normal")
Return

Space::
  Send, !fa
  Vim.State.SetMode("Insert")
Return
