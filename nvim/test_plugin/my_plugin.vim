let s:script_dir = fnamemodify(resolve(expand('<sfile>', ':p')), ':h')



function! StartPy()

python3 << EOF
import sys
import vim

plugin_root_dir = vim.eval('s:script_dir') + "/python/"
sys.path.insert(0, plugin_root_dir)
import sample
EOF
endfunction

call StartPy()
