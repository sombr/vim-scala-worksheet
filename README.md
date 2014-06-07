vim-scala-worksheet
===================

Tiny Vim plugin that turns your file into interactive worksheet

Installation
============
This is just a first sketch of a plugin and it's not particularly pretty, but already quite handy.
It *requires* though VIM compiled with *ruby* support.
Just clone repository into your vim/bundle directory.

Using
=====
Files with extension \*.scalaws are interpreted as worksheets and evaluated line by line with evaluation results
added as comments to each line.
( It takes a second to evaluate first time because of lazy "scala" execution, but other lines are communicated directly with an existing worksheet instance.
