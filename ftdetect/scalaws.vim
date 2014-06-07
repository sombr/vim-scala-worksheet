function! DoREPL()
ruby << EOF
    (row, col) = VIM::Window.current.cursor
    @maxlen ||= 0
    if @aaa.nil?
        @aaa = IO.popen("scala", "r+")
        @aaa.write("\n")
        text = ""
        while text !~ /scala/
            text = @aaa.readpartial(4096)
        end
        text.gsub!("scala","")
        while text !~ /scala/
            text += @aaa.readpartial(4096)
        end
    end
    line = VIM::Buffer.current[row]
    if line =~ /\/\/::/
        line = line.sub(/\/\/::.*$/,"")
    end
    @maxlen ||= line.length
    @maxlen = line.length if @maxlen < line.length

    @aaa.write("#{line}\n")
    text = ""
    while text !~ /scala|\|\s/
        text += @aaa.readpartial(4096)
    end
    text.gsub!("scala>", "")
    text.strip!
    text.gsub!("\n", " ---> ")
    text.gsub!(/\s+/, " ")
    if ( text != "" )
        line.gsub!(/\s+$/, "")
        spaces = @maxlen - line.length
        VIM::Buffer.current[row] = "#{line} #{ " " * spaces }//:: #{text}"
    end
    line =~ /^(\s*)/
    VIM::Buffer.current.append(row, " " * $1.length)
    VIM::Window.current.cursor = [ row + 1, col ]
EOF
endfunction

au BufRead,BufNewFile *.scalaws set filetype=scala
au BufRead,BufNewFile *.scalaws imap <silent> <CR> <c-o>:call DoREPL()<CR>
